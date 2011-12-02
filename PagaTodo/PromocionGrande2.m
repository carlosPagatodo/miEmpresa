//
//  PromocionGrande2.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 03/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PromocionGrande2.h"

@implementation PromocionGrande2

@synthesize delegate;
@synthesize viewPromocion;
@synthesize promocion;

-(IBAction)AbrirPromocion{
    [self.delegate Promo2Selected:self];
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

    AsyncImageView* asyncImage1 = [[[AsyncImageView alloc] initWithFrame:viewPromocion.bounds] autorelease];
	NSURL* url1 = [NSURL URLWithString: promocion.imagen];
	[asyncImage1 loadImageFromURL:url1];
	[viewPromocion addSubview:asyncImage1];
    
    //578x382 retina
    //289x191

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
