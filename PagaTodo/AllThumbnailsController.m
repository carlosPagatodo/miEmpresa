//
//  AllThumbnailsController.m
//  SouthAfrica-Fan
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 11/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AllThumbnailsController.h"


@implementation AllThumbnailsController

@synthesize sView;
@synthesize arrFotos;
@synthesize subViewControllers;

-(IBAction)Regresar{
	[self dismissModalViewControllerAnimated:YES];
}

-(void)Refresh{

	subViewControllers = [NSMutableArray new];

	int intHeight = 3;
	int intLeft = 3;
	
	for (int i=0; i<[arrFotos count]; i++) {
		
		//float f1 = (float)i/(float)[arrFotos count];
	//	NSString *strPje = [NSString stringWithFormat: @"%2.2f",f1];
		
		//[(WorldCup_FanAppDelegate *)[[UIApplication sharedApplication] delegate] setStrAvance:strPje];
		//[(WorldCup_FanAppDelegate *)[[UIApplication sharedApplication] delegate] ProgresoBack];

		
		ThumbnailController *thumbailView = [[ThumbnailController alloc] initWithNibName:@"Thumbnail" bundle:[NSBundle mainBundle]];
		thumbailView.view.frame = CGRectMake(intLeft, intHeight, 75, 80);
		thumbailView.delegate = self;
		Foto *f = (Foto *)[arrFotos objectAtIndex:i];
		thumbailView.foto = f;
		[thumbailView Refresh];
		[sView addSubview:thumbailView.view];
		[subViewControllers addObject:thumbailView];
		[thumbailView release];
		if (intLeft+80<320){
			intLeft = intLeft + 80;
		} else {
			intLeft = 3;
			intHeight = intHeight + 85;
		}
	}
	
	[sView setContentSize:CGSizeMake(320, intHeight + 85)];

	
} 

- (void)ThumbnailSelected:(ThumbnailController *)controller {
		FotografiaController *fotoView  = [[FotografiaController alloc] initWithNibName:@"Fotografia" bundle:[NSBundle mainBundle]];
		fotoView.title = @"Fotografías";//;[(WorldCup_FanAppDelegate *)[[UIApplication sharedApplication] delegate] TraduccionGlobal:@"LBL_PICTURE"];
		fotoView.foto = controller.foto;
		fotoView.arrFotos = arrFotos;
		[self presentModalViewController:fotoView animated:YES];	
		[fotoView Refresh];
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
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
	[self Refresh];
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	for (UIViewController *vc in subViewControllers){
		if ([vc isMemberOfClass:[ThumbnailController class]]){
			[vc.view removeFromSuperview];
			[(ThumbnailController *)vc setDelegate:nil];
			//[vc release];
			vc=nil;
		}
	}
	
	subViewControllers=nil;
	sView=nil;
	//arrFotos=nil;
	
}


- (void)dealloc {

	[subViewControllers release];
	[sView release];
	//[arrFotos release];

	subViewControllers=nil;
	sView=nil;
	//arrFotos=nil;
    [super dealloc];
}


@end
