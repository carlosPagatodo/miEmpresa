//
//  RenglonLista.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 20/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RenglonLista.h"

@implementation RenglonLista
@synthesize lblNombre;
@synthesize lblTotal;
@synthesize delegate;
@synthesize imgFondo;
@synthesize btnEliminar;
@synthesize strListaId;

-(IBAction)SeleccionLista:(id)sender{
    [self.delegate ListaSeleccionada:self];
}

-(IBAction)EliminarLista:(id)sender{
    [self.delegate ListaEliminada:self];
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
