//
//  RenglonCategoria.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RenglonCategoria.h"

@implementation RenglonCategoria
@synthesize viewImagen;
@synthesize lblTitulo;
@synthesize lblTotal;
@synthesize cat;
@synthesize delegate;

-(IBAction)AbrirCategoria:(id)sender{
    [self.delegate CategoriaSelected:self];
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
	NSURL* url1 = [NSURL URLWithString: cat.imagen];
	[asyncImage1 loadImageFromURL:url1];
	[viewImagen addSubview:asyncImage1];
    
    lblTitulo.text = cat.titulo;
    lblTotal.text = [NSString stringWithFormat:@"(%@)",cat.total];


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
