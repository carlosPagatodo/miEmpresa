    //
//  DetalleEstablecimientoController.m
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DetalleEstablecimientoController.h"


@implementation DetalleEstablecimientoController

@synthesize sView;
@synthesize viewDetalle;
@synthesize neg;
@synthesize mapa;

@synthesize lblNombre;
@synthesize lblDireccion;
@synthesize lblTipo;
@synthesize lblDistancia;
@synthesize lblCP;

@synthesize lblColonia;
@synthesize lblDelegacion;
@synthesize lblEstado;

@synthesize lblTelefono;
@synthesize lblHorarios;
@synthesize viewImagen;

@synthesize lblFax;

-(IBAction)Atras:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Ruta{
	
	NSString *strLat = @"19.43";
	NSString *strLng = @"-99.2";
	BOOL blnUbicado=YES;
	
	CLLocationManager * locationManager1 = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] locationManager];
	if (locationManager1.location == nil) {
		blnUbicado=NO;
	}
	if (locationManager1.location.coordinate.latitude == 0) {
		blnUbicado=NO;
	}
	
	strLat = [NSString stringWithFormat:@"%f", locationManager1.location.coordinate.latitude];
	strLng = [NSString stringWithFormat:@"%f", locationManager1.location.coordinate.longitude];
	
    
	
	
	if (blnUbicado){
		NSString *s = @"http://maps.google.com/maps?daddr=";
		s = [s stringByAppendingString:neg.lat];
		s = [s stringByAppendingString:@","];
		s = [s stringByAppendingString:neg.lng];
		s = [s stringByAppendingString:@"&saddr="];
		s = [s stringByAppendingString:strLat];
		s = [s stringByAppendingString:@","];
		s = [s stringByAppendingString:strLng];
		s = [s stringByAppendingString:@"&sll="];
		s = [s stringByAppendingString:strLat];
		s = [s stringByAppendingString:@","];
		s = [s stringByAppendingString:strLng];
		
		//s = @"http://maps.google.com/maps?daddr=33.85797,-118.01014&saddr=33.918292,-118.302155";
		NSURL *myURL = [NSURL URLWithString: s];
		[[UIApplication sharedApplication] openURL:myURL];
		
		
	} else {
		
		UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
		[dialog setDelegate:self];
		[dialog setTitle:@"Aviso"];
		[dialog setMessage:@"No se puede trazar la ruta."];
		[dialog addButtonWithTitle:@"OK"];
		[dialog show];
		[dialog release];
		
		
	}

	
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

-(IBAction)Llamar{

	if ([neg.tel1 length]>0) {
		NSString *s = @"tel://";
		s = [s stringByAppendingString:neg.tel1];
		NSURL *myURL = [NSURL URLWithString: s];
		[[UIApplication sharedApplication] openURL:myURL];
	} else {
		UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
		 [dialog setDelegate:self];
		 [dialog setTitle:@"Error"];
		 [dialog setMessage:@"El establecimiento no cuenta con teléfono."];
		 [dialog addButtonWithTitle:@"OK"];
		 [dialog show];
		 [dialog release];
	}

}

-(IBAction)Mas{
	
}

-(IBAction)Web{
	if ([neg.www length]>0) {
		NSURL *myURL = [NSURL URLWithString: neg.www];
		[[UIApplication sharedApplication] openURL:myURL];
	} else {
		UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
		[dialog setDelegate:self];
		[dialog setTitle:@"Error"];
		[dialog setMessage:@"El establecimiento no cuenta con página web."];
		[dialog addButtonWithTitle:@"OK"];
		[dialog show];
		[dialog release];
	}
}

-(IBAction)Mail{
	if ([neg.mail length]>0) {
		NSString *s = @"mailto://";
		s = [s stringByAppendingString:neg.mail];
		NSURL *myURL = [NSURL URLWithString: s];
		[[UIApplication sharedApplication] openURL:myURL];
	} else {
		UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
		[dialog setDelegate:self];
		[dialog setTitle:@"Error"];
		[dialog setMessage:@"El establecimiento no cuenta con dirección de e-mail"];
		[dialog addButtonWithTitle:@"OK"];
		[dialog show];
		[dialog release];
	}
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[sView addSubview:viewDetalle];
	[sView setContentSize:viewDetalle.frame.size];

	if ([neg.lat length]>0) {
		NegocioAnnotation *pm;
		
		CLLocationCoordinate2D loc2 ;
		loc2.latitude = [neg.lat floatValue];
		loc2.longitude = [neg.lng floatValue];
		[mapa setRegion:MKCoordinateRegionMake(loc2, MKCoordinateSpanMake(0.005, 0.005)) animated:YES];
		
		pm = [[NegocioAnnotation alloc] initWithCoordinate:loc2];
		pm.currentTitle=neg.nombre;
		pm.currentSubTitle=@"";
		pm.neg=neg;
		[mapa addAnnotation:pm];
		
		
		
		//NSString *strLat = @"19.43";
		//NSString *strLng = @"-99.2";
		BOOL blnUbicado=NO;
		
		/*CLLocationManager * locationManager1 = [(CFEAppDelegate *)[[UIApplication sharedApplication] delegate] locationManager];
		if (locationManager1.location == nil) {
			blnUbicado=NO;
		}
		if (locationManager1.location.coordinate.latitude == 0) {
			blnUbicado=NO;
		}
		
		strLat = [NSString stringWithFormat:@"%f", locationManager1.location.coordinate.latitude];
		strLng = [NSString stringWithFormat:@"%f", locationManager1.location.coordinate.longitude];
		
*/
		if (blnUbicado) {
			
			/*UIBarButtonItem * botonRuta = [[UIBarButtonItem alloc] initWithTitle:@"Cómo llegar" style:UIBarButtonItemStyleBordered target:self action:@selector(Ruta)];
			self.navigationItem.rightBarButtonItem = botonRuta;
*/
			
		}
		
		
	} else {
		mapa.hidden=YES;
	}

	
	
	lblTelefono.text = [NSString stringWithFormat:@"Tel: %@" ,neg.tel1];
	lblFax.text = [NSString stringWithFormat:@"Fax: %@" ,neg.fax];
	lblHorarios.text = [NSString stringWithFormat:@"Horarios: %@" ,neg.horarios];
	
	lblNombre.text = neg.nombre;
	lblDireccion.text = neg.direccion;
	lblColonia.text = neg.colonia;
	lblCP.text = [NSString stringWithFormat:@"C.P. %@", neg.cp];
	lblDelegacion.text = neg.delegacion;
	lblEstado.text = neg.estado;
	
    AsyncImageView* asyncImage1 = [[[AsyncImageView alloc] initWithFrame:viewImagen.bounds] autorelease];
	NSURL* url1 = [NSURL URLWithString:neg.foto];
	[asyncImage1 loadImageFromURL:url1];
	[viewImagen addSubview:asyncImage1];

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
