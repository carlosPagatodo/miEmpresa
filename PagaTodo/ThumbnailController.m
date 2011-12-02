//
//  ThumbnailController.m
//  SouthAfrica-Fan
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 11/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ThumbnailController.h"


@implementation ThumbnailController
@synthesize delegate;
@synthesize btnPlay;
@synthesize foto;
@synthesize viewFoto;

- (IBAction)VerImagen:(id)sender{
	[self.delegate ThumbnailSelected:self];
}

- (void)Refresh{

	if ([foto.foto_tipo isEqualToString:@"VIDEO"]){
		btnPlay.hidden=NO;
	} else 	if ([foto.foto_tipo isEqualToString:@"YOUTUBE"]){
		btnPlay.hidden=NO;
		
		[self embedYouTube:foto.foto_thumb];
	} else {
		btnPlay.hidden=YES;
		NSString *strPrefix=[foto.foto_url substringToIndex:4];
		if ([strPrefix isEqualToString:@"http"]){
			AsyncImageView* asyncImage = [[[AsyncImageView alloc] initWithFrame:self.view.bounds] autorelease];
			NSURL* asyncImageurl = [NSURL URLWithString: foto.foto_url];
			[asyncImage loadImageFromURL:asyncImageurl];
			[viewFoto addSubview:asyncImage];
		} else {
			UIImageView *imgView = [[UIImageView alloc] initWithFrame:viewFoto.frame];
			imgView.image = [UIImage imageNamed:foto.foto_thumb];
			[viewFoto addSubview:imgView];
			
		}
	}
	
}

- (void)embedYouTube:(NSString*)idYouTube {  
	if ([idYouTube length]>0) {
		UIWebView *videoView = [[UIWebView alloc] initWithFrame:viewFoto.bounds];  
		NSString *htmlString = @"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 75\"/></head><body style=\"margin-top:0px;margin-left:0px\"><div><object width=\"75\" height=\"80\"><param name=\"movie\" value=\"";
		htmlString = [htmlString stringByAppendingString: @"http://www.youtube.com/v/"];
		//htmlString = [htmlString stringByAppendingString: @"oHg5SJYRHA0"];
		
		htmlString = [htmlString stringByAppendingString: idYouTube];
		//htmlString = [htmlString stringByAppendingString: @"&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM"];
		htmlString = [htmlString stringByAppendingString: @"\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\""];
		htmlString = [htmlString stringByAppendingString: @"http://www.youtube.com/v/"];
		//htmlString = [htmlString stringByAppendingString: @"oHg5SJYRHA0"];
		htmlString = [htmlString stringByAppendingString: idYouTube];
		//htmlString = [htmlString stringByAppendingString: @"&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM"];
		htmlString = [htmlString stringByAppendingString:@"\" type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"75\" height=\"80\"></embed></object></div></body></html>"];
		
		[videoView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.southafrica-fan.com"]];
		
		[viewFoto addSubview:videoView];  
	}
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
}


- (void)dealloc {
	[btnPlay release];
	[viewFoto release];
	[foto release];
	btnPlay=nil;
	viewFoto=nil;
	foto=nil;
	
    [super dealloc];
}


@end
