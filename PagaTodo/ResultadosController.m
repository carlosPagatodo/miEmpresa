    //
//  ResultadosController.m
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ResultadosController.h"


@implementation ResultadosController

@synthesize sView;
@synthesize toolAnterior;
@synthesize toolSiguiente;
@synthesize lblPaginasAnterior;
@synthesize lblPaginasSiguiente;
@synthesize mapa;
@synthesize strProducto;
@synthesize strNombre;
@synthesize strCategoria;
@synthesize strEstado;
@synthesize strDelegacion;
@synthesize strColonia;
@synthesize strCP;
@synthesize arrNegocios;
@synthesize strTipoBusqueda;
@synthesize botonMapa;
@synthesize txtBuscar;
@synthesize toolTeclado;
@synthesize strBusqueda;
@synthesize btnAtras;
@synthesize subviewControllers;

CLLocationCoordinate2D _annotation;

MKUserLocation *userLocation1;

int intPagina = 0;
int intPaginasTotales = 0;


-(IBAction)Atras:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)AbreTeclado{
    toolTeclado.hidden=NO;
}

-(IBAction)CierraTeclado{
    [txtBuscar resignFirstResponder];
    toolTeclado.hidden=YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self CierraTeclado];
    [self Search];
    return YES;
}

-(IBAction)Search{
    
    if ([txtBuscar.text length]==0) {
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Error"];
        [dialog setMessage:@"Por favor introduzca su búsqueda."];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        return;
    }
    
    ResultadosController *res = [[ResultadosController alloc] initWithNibName:@"Resultados" bundle:[NSBundle mainBundle]];
    res.strBusqueda = txtBuscar.text;
    [self.navigationController pushViewController:res animated:YES];
    res.btnAtras.hidden=NO;
    //[res Listado];
    [res Buscar];
    
    res.mapa.hidden = YES;
    res.sView.hidden = NO;
    [res.botonMapa setImage:[UIImage imageNamed:@"vermapa.png"] forState:UIControlStateNormal];
    res.btnAtras.hidden=NO;
    res.txtBuscar.text = res.strBusqueda;


}


-(IBAction)Mapa{
	mapa.hidden = NO;
	sView.hidden = YES;
}

-(IBAction)Listado{
    
    if (sView.hidden) {
    
        ResultadosController *rs = [[ResultadosController alloc] initWithNibName:@"Resultados" bundle:[NSBundle mainBundle]];
        rs.strBusqueda = txtBuscar.text;
        [self.navigationController pushViewController:rs animated:YES];
        rs.mapa.hidden = YES;
        rs.sView.hidden = NO;
        [rs.botonMapa setImage:[UIImage imageNamed:@"vermapa.png"] forState:UIControlStateNormal];
        rs.btnAtras.hidden=NO;
        rs.txtBuscar.text = rs.strBusqueda;
        //if ([strBusqueda length]>0) {
            [rs Buscar];
        //}
    } else {
    
        ResultadosController *rs = [[ResultadosController alloc] initWithNibName:@"Resultados" bundle:[NSBundle mainBundle]];
        rs.strBusqueda = txtBuscar.text;
        [self.navigationController pushViewController:rs animated:YES];

        rs.mapa.hidden = NO;
        rs.sView.hidden = YES;
        rs.btnAtras.hidden=NO;
        rs.txtBuscar.text = rs.strBusqueda;
        //if ([strBusqueda length]>0) {
            [rs Buscar];
        //}

    }

}



-(void) ObtenResultados {
	self.arrNegocios = [[NSMutableArray alloc] init];
	
	intPaginasTotales = 1;
    
    if (   [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] ValidaConexion]==NO) {
        return;
    }

    
	//codigo para obtener resultados
	
    NSString *strURL;
    if ([strBusqueda length]==0) {
        strURL = [NSString stringWithFormat: @"http://dextramedia.com/middleware/liverpool/stores/?lat=%g&lon=%g",userLocation1.coordinate.latitude, userLocation1.coordinate.longitude];
    } else {
        if (userLocation1 != nil) {
            strURL = [NSString stringWithFormat: @"http://dextramedia.com/middleware/liverpool/stores/?lat=%g&lon=%g&name=%@",userLocation1.coordinate.latitude, userLocation1.coordinate.longitude,strBusqueda];
        } else {
            strURL = [NSString stringWithFormat: @"http://dextramedia.com/middleware/liverpool/stores/?name=%@",strBusqueda];
        }
    }
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //NSURL *url = [[NSURL alloc] initWithString:strURL];
    NSString *strResultado = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getURLCache:strURL];
   // NSLog(strResultado);
    
    SBJSON *jsonParser = [SBJSON new];
    
	NSDictionary *results = (NSDictionary *)[jsonParser objectWithString:strResultado error:NULL];
   // NSString *total = [NSString stringWithFormat:@"%@", [results objectForKey:@"total"]];
    
    NSArray *stores = (NSArray *)[results objectForKey:@"stores"];
    
    for (int i=0; i<[stores count]; i++) {
        NSDictionary *dicCampos = (NSDictionary *)[stores objectAtIndex:i];
        Negocio *neg1;
        
        //nuevo neg
        neg1 = [[Negocio alloc] init];
        neg1.idr = (NSString *)[dicCampos objectForKey:@"id"];
        neg1.nombre = (NSString *)[dicCampos objectForKey:@"name"];
        neg1.direccion = (NSString *)[dicCampos objectForKey:@"address"];
        neg1.tel1 = (NSString *)[dicCampos objectForKey:@"phone"];
        neg1.horarios = (NSString *)[dicCampos objectForKey:@"hours"];
        neg1.lat = (NSString *)[dicCampos objectForKey:@"latitude"];
        neg1.lng = (NSString *)[dicCampos objectForKey:@"longitude"];  
        neg1.foto =  (NSString *)[dicCampos objectForKey:@"image"];  
        neg1.fax =  (NSString *)[dicCampos objectForKey:@"fax"];  
        neg1.distancia =  [NSString stringWithFormat:@"%@",(NSString *)[dicCampos objectForKey:@"distance"]];  
        [arrNegocios addObject:neg1];

    }



}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{

    
    for (int i =0; i<[subviewControllers count]; i++) {
    
        RenglonResultadoController *rc = (RenglonResultadoController *)[subviewControllers objectAtIndex:i];
        Negocio *c1 = rc.neg;
        CLLocation *loc1a = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        CLLocation *loc2a = [[CLLocation alloc] initWithLatitude:[c1.lat floatValue] longitude:[c1.lng floatValue]];
        CLLocationDistance meters2 = [loc1a getDistanceFrom:loc2a]/1000;
        NSLog(@"%f %f %g",userLocation.coordinate.latitude,userLocation.coordinate.longitude,meters2);
        rc.lblDistancia.text = [NSString stringWithFormat:@"%.1f Km", meters2];
        
    }

    
    if (userLocation1==nil) {
        userLocation1 = userLocation;
        if ([strBusqueda length]==0) {
            [self Buscar];
        }
    } else {
        
        CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:userLocation1.coordinate.latitude longitude:userLocation1.coordinate.longitude];
        CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        
        CLLocationDistance meters2 = [loc1 getDistanceFrom:loc2];
        if (meters2<1000) {
            return;
        } else {
            userLocation1 = userLocation;
            if ([strBusqueda length]==0) {
                [self Buscar];
            }
        }
    }
    [mapa setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.5, 0.5)) animated:YES];

    if (_annotation.latitude == 19.43) {
        return;
    }

    CLLocationCoordinate2D southWest = userLocation.coordinate;
    CLLocationCoordinate2D northEast = southWest;
    
    southWest.latitude = MIN(southWest.latitude, _annotation.latitude);
    southWest.longitude = MIN(southWest.longitude, _annotation.longitude);
    
    northEast.latitude = MAX(northEast.latitude, _annotation.latitude);
    northEast.longitude = MAX(northEast.longitude, _annotation.longitude);
    
    CLLocation *locSouthWest = [[CLLocation alloc] initWithLatitude:southWest.latitude longitude:southWest.longitude];
    CLLocation *locNorthEast = [[CLLocation alloc] initWithLatitude:northEast.latitude longitude:northEast.longitude];
    
    // This is a diag distance (if you wanted tighter you could do NE-NW or NE-SE)
    CLLocationDistance meters = [locSouthWest getDistanceFrom:locNorthEast];
    
    MKCoordinateRegion region;
    region.center.latitude = (southWest.latitude + northEast.latitude) / 2.0;
    region.center.longitude = (southWest.longitude + northEast.longitude) / 2.0;
    region.span.latitudeDelta = meters / 111319.5;
    region.span.longitudeDelta = 0.0;
    
    [mapa setRegion:[mapa regionThatFits:region] animated:YES];
    
    [locSouthWest release];
    [locNorthEast release];

}




-(void)Buscar{
	 
	
	int intTop = 0;

	    
    [self ObtenResultados];
	
	if ([arrNegocios count]==0) {
		UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
		[dialog setDelegate:self];
		[dialog setTitle:@"Aviso"];
		[dialog setMessage:@"No hay resultados que coincidan con los criterios de búsqueda."];
		[dialog addButtonWithTitle:@"OK"];
		[dialog show];
		[dialog release];			
	}
	
	
	for(UIView *view in [sView subviews]) {
		[view removeFromSuperview];
	}

	
	if (intPagina>1) {
		toolAnterior.frame = CGRectMake(0, intTop, 320, 44);
		lblPaginasAnterior.title = [NSString stringWithFormat:@"Página %i de %i", intPagina, intPaginasTotales];
		[sView addSubview:toolAnterior];
		intTop = intTop + 44;
	}
	
	
	
	
	[mapa removeAnnotations:[mapa annotations]];
	
	subviewControllers = [NSMutableArray new];
    
	CLLocationCoordinate2D loc ;
    loc.latitude = [@"19.43" floatValue];
    loc.longitude = [@"-99.2" floatValue];
    _annotation = loc;
    
	[mapa setRegion:MKCoordinateRegionMake(loc, MKCoordinateSpanMake(0.5, 0.5)) animated:YES];
	[mapa setDelegate: self];
	
	NegocioAnnotation *pm;
	RenglonResultadoController *renglonController;

	for (int i=0;i<[arrNegocios count];i++){
		Negocio *c1 = (Negocio *)[arrNegocios objectAtIndex:i];
		
		if ([c1.lat length]>0) {
			CLLocationCoordinate2D loc2 ;
			loc2.latitude = [c1.lat floatValue];
			loc2.longitude = [c1.lng floatValue];
			
			if (i==0) {
                 _annotation = loc2;
                    [mapa setRegion:MKCoordinateRegionMake(loc2, MKCoordinateSpanMake(0.5, 0.5)) animated:YES];
			}
			
			pm = [[NegocioAnnotation alloc] initWithCoordinate:loc2];
			pm.currentTitle=c1.nombre;
			pm.currentSubTitle=[NSString stringWithFormat:@"%@ Km",c1.distancia];
			pm.neg=c1;
			[mapa addAnnotation:pm];
		}
		
		//listado
		
		renglonController = [[RenglonResultadoController alloc] initWithNibName:@"RenglonResultado" bundle:[NSBundle mainBundle]];
		renglonController.neg = c1;
        renglonController.view.frame = CGRectMake(0, intTop, 320, 60);
		renglonController.delegate = self;
		[sView addSubview:renglonController.view];
        [subviewControllers addObject:renglonController];
        [renglonController release];
        
        if (userLocation1 != nil) {
                
                Negocio *c1 = renglonController.neg;
                CLLocation *loc1a = [[CLLocation alloc] initWithLatitude:userLocation1.coordinate.latitude longitude:userLocation1.coordinate.longitude];
                CLLocation *loc2a = [[CLLocation alloc] initWithLatitude:[c1.lat floatValue] longitude:[c1.lng floatValue]];
                CLLocationDistance meters2 = [loc1a getDistanceFrom:loc2a]/1000;
                NSLog(@"%f %f %g",userLocation1.coordinate.latitude,userLocation1.coordinate.longitude,meters2);
                renglonController.lblDistancia.text = [NSString stringWithFormat:@"%.1f Km", meters2];
                

        }
        

        
		intTop = intTop + 60;
		
	}
	
	
	
	
	
	if (intPagina < intPaginasTotales) {
		toolSiguiente.frame = CGRectMake(0, intTop, 320, 44);
		lblPaginasSiguiente.title = [NSString stringWithFormat:@"Página %i de %i", intPagina, intPaginasTotales];
		[sView addSubview:toolSiguiente];
		intTop = intTop + 44;//margen
	}
	
	[sView setContentSize:CGSizeMake(320.0,intTop)];
	
	if (intTop>0) {
		CGPoint point;
		point.x = 0;
		point.y = 0;
		[sView setContentOffset:point animated:YES];
		
	}
	
}


-(IBAction)Anterior{

	if (intPagina>1) {
		intPagina--;
		[self Buscar];
	} else {
		UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
		[dialog setDelegate:self];
		[dialog setTitle:@"Aviso"];
		[dialog setMessage:@"Esta es la primer página de resultados"];
		[dialog addButtonWithTitle:@"OK"];
		[dialog show];
		[dialog release];	
		
	}

}

-(IBAction)Siguiente{

	if (intPagina<intPaginasTotales) {
		intPagina++;
		[self Buscar];
	} else {
		UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
		[dialog setDelegate:self];
		[dialog setTitle:@"Aviso"];
		[dialog setMessage:@"Esta es la última página de resultados"];
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

- (void)RenglonSelected:(RenglonResultadoController *)controller{
	
	DetalleEstablecimientoController *detalleController = [[DetalleEstablecimientoController alloc] initWithNibName:@"DetalleEstablecimient" bundle:[NSBundle mainBundle]];
	detalleController.title = @"Detalle";
	detalleController.neg = controller.neg;
	[self.navigationController pushViewController:detalleController animated:YES];
	
}

- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation
{
	
	if ([annotation isKindOfClass:[MKUserLocation class]]){
		return nil;
	}
	
	
	MKPinAnnotationView *pin = (MKPinAnnotationView *) [self.mapa dequeueReusableAnnotationViewWithIdentifier: [annotation title]];
	if (pin == nil) {
		pin = [[[MKPinAnnotationView alloc]  initWithAnnotation: annotation reuseIdentifier: [annotation title]] autorelease];
	} else {
		pin.annotation = annotation;
		//pin = [[[MKPinAnnotationView alloc]  initWithAnnotation: annotation reuseIdentifier: [annotation title]] autorelease];
		
	}
	
	pin.pinColor = MKPinAnnotationColorRed;
	pin.animatesDrop = YES;
	UIButton *btnDetalle = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	btnDetalle.tag=[[annotation title] intValue];
    
//jpghc
    
   /* AsyncImageView* asyncImage1 = [[[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)] autorelease];
	NSURL* url1 = [NSURL URLWithString: @"http://www.estoyenelmapa.com/icons/categorias/liverpool.gif"];
	[asyncImage1 loadImageFromURL:url1];

    
    
	pin.leftCalloutAccessoryView = asyncImage1;
    */
    
    pin.rightCalloutAccessoryView = btnDetalle;
	pin.canShowCallout = YES;
	pin.enabled = YES;
	
	[pin setHighlighted:YES];
	
	return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	NegocioAnnotation *annotationnegocio = (NegocioAnnotation *)view.annotation;
	Negocio *neg = (Negocio *) [annotationnegocio neg];
	DetalleEstablecimientoController *detalleController = [[DetalleEstablecimientoController alloc] initWithNibName:@"DetalleEstablecimient" bundle:[NSBundle mainBundle]];
	detalleController.title = @"Detalle";
	detalleController.neg = neg;
	[self.navigationController pushViewController:detalleController animated:YES];
	
}	


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	intPagina = 1;
	
	
	
	mapa.showsUserLocation=YES;
	mapa.delegate = self;
	

	/*
	TituloResultadosController *tituloController;
	
	tituloController = [[TituloResultadosController alloc] initWithNibName:@"TituloResultados" bundle:[NSBundle mainBundle]];
	tituloController.view.frame = CGRectMake(0, intTop, 320, 50);
	if ([strProducto isEqualToString:@"ValeDespensas"]) {
		tituloController.imgTipoProducto.image = [UIImage imageNamed:@"valedespensas.png"];
	} else if ([strProducto isEqualToString:@"AlimentacionElectronico"]) {
		tituloController.imgTipoProducto.image = [UIImage imageNamed:@"ticketalimentacionelectronico.png"];
	} else if ([strProducto isEqualToString:@"Restaurante"]) {
		tituloController.imgTipoProducto.image = [UIImage imageNamed:@"TicketRestaurante.png"];
	} else if ([strProducto isEqualToString:@"RestauranteElectronico"]) {
		tituloController.imgTipoProducto.image = [UIImage imageNamed:@"ticketrestauranteelectronico.png"];
	} else if ([strProducto isEqualToString:@"Uniforme"]) {
		tituloController.imgTipoProducto.image = [UIImage imageNamed:@"ticketuniforme.png"];
	} else if ([strProducto isEqualToString:@"Compliments"]) {
		tituloController.imgTipoProducto.image = [UIImage imageNamed:@"ticketcompliments.png"];
	} else if ([strProducto isEqualToString:@"Gasolina"]) {
		tituloController.imgTipoProducto.image = [UIImage imageNamed:@"valegasolina.png"];
	} else if ([strProducto isEqualToString:@"Car"]) {
		tituloController.imgTipoProducto.image = [UIImage imageNamed:@"tickercar.png"];
	}

	[sView addSubview:tituloController.view];
	
	intTop = intTop + 50;
	
	
	SeparadorController *separadorController;
	
	
	separadorController = [[SeparadorController alloc] initWithNibName:@"Separador" bundle:[NSBundle mainBundle]];
	separadorController.view.frame = CGRectMake(0, intTop, 320, 20);
	separadorController.lblTitulo.text = @"Establecimientos Afiliados";
	[sView addSubview:separadorController.view];
	
	
	intTop = intTop + 20;
	 */
	
    
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
