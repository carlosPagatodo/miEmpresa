//
//  PromocionGrandeController.m
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 14/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PromocionGrandeController.h"


@implementation PromocionGrandeController


@synthesize delegate;
@synthesize viewPromocion;
@synthesize promocion;

-(IBAction)AbrirPromocion{
    [self.delegate PromoSelected:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{

//    UIImageView* asyncImage1 = [[[UIImageView alloc] initWithFrame:viewPromocion.bounds] autorelease];
  //  asyncImage1.image = [UIImage imageNamed:promocion.imagen];
    
	//NSURL* url1 = [NSURL URLWithString: promocion.imagen];
	//[asyncImage1 loadImageFromURL:url1];

	AsyncImageView* asyncImage1 = [[[AsyncImageView alloc] initWithFrame:viewPromocion.bounds] autorelease];
	NSURL* url1 = [NSURL URLWithString: promocion.imagen];
	[asyncImage1 loadImageFromURL:url1];
	[viewPromocion addSubview:asyncImage1];

    [super viewDidLoad];
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
