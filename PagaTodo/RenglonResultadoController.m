    //
//  RenglonResultadoController.m
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RenglonResultadoController.h"


@implementation RenglonResultadoController

@synthesize lblDistancia;
@synthesize lblNombre;
@synthesize lblTipo;
@synthesize lblDireccion;
@synthesize lblColonia;
@synthesize neg;
@synthesize lblEstado;
@synthesize delegate;
@synthesize lblDelegacion;
@synthesize viewFoto;

-(IBAction)Seleccionar{
	[self.delegate RenglonSelected:self];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    AsyncImageView* asyncImage1 = [[[AsyncImageView alloc] initWithFrame:viewFoto.bounds] autorelease];
	NSURL* url1 = [NSURL URLWithString: neg.foto];
	[asyncImage1 loadImageFromURL:url1];
	[viewFoto addSubview:asyncImage1];

	lblNombre.text = neg.nombre;
	lblDireccion.text = neg.direccion;
	lblColonia.text = neg.colonia;
	lblTipo.text = neg.tipo;
	lblDistancia.text = neg.distancia;
	lblEstado.text = neg.estado;
	lblDelegacion.text = neg.delegacion;
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
