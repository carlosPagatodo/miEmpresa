//
//  RenglonProducto.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RenglonProducto.h"

@implementation RenglonProducto
@synthesize viewImagen;
@synthesize lblTitulo;
@synthesize lblPrecio;
@synthesize lblPrecioDescuento;
@synthesize imgTachado;
@synthesize cat;
@synthesize sub;
@synthesize prod;
@synthesize delegate;
@synthesize btnEliminar;

-(IBAction)EliminarProducto:(id)sender{
    [self.delegate ProductoEliminado:self];
}

-(IBAction)AbrirProducto:(id)sender{
    [self.delegate ProductoSelected:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    AsyncImageView* asyncImage1 = [[[AsyncImageView alloc] initWithFrame:viewImagen.bounds] autorelease];
	NSURL* url1 = [NSURL URLWithString: prod.imagen];
	[asyncImage1 loadImageFromURL:url1];
	[viewImagen addSubview:asyncImage1];
    
    lblTitulo.text = prod.titulo;
    if ([prod.price length]>0) {
        lblPrecio.text = [NSString stringWithFormat:@"$%@",prod.price];
    } else {
        lblPrecio.text = @"";
    }
    lblPrecioDescuento.hidden=YES;
    imgTachado.hidden=YES;

    if ([prod.price_with_discount length]>0) {
        lblPrecioDescuento.text = [NSString stringWithFormat:@"$%@",prod.price_with_discount];
        lblPrecioDescuento.hidden=NO;
        imgTachado.hidden=NO;
        NSString *strRayas = @"";
        for (int i=0; i<[lblPrecio.text length]; i++) {
            strRayas = [strRayas stringByAppendingString:@"_"];
        }
        imgTachado.text = strRayas;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
