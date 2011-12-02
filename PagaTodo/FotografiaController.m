//
//  FotografiaController.m
//  SouthAfrica-Fan
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 08/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FotografiaController.h"


@implementation FotografiaController
@synthesize foto;
@synthesize arrFotos;
@synthesize viewImagen;
@synthesize btnAtras;
@synthesize btnAdelante;
@synthesize lblTotal;
@synthesize pageControl;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

int indice;
CGRect cg;
CGRect cg1;
CGRect cg2;
int cgw;
int cgh;

-(IBAction)verAtras{
	for (UIView *v in [viewImagen subviews]){
		[v removeFromSuperview];
	}	
	indice--;
	
	Foto *fotonueva = (Foto *)[arrFotos objectAtIndex:indice];
	if ([fotonueva.foto_tipo isEqualToString:@"YOUTUBE"]){
		[self embedYouTube: fotonueva.foto_url];  
	} else {
		NSString *strPrefix=[fotonueva.foto_url substringToIndex:4];
		if ([strPrefix isEqualToString:@"http"]){
			AsyncImageView* asyncImage = [[[AsyncImageView alloc] initWithFrame:cg1] autorelease];
			NSURL* asyncImageurl = [NSURL URLWithString: fotonueva.foto_url];
			[asyncImage loadImageFromURL:asyncImageurl];
			[viewImagen addSubview:asyncImage];
		} else {
			UIImageView *imgView = [[UIImageView alloc] initWithFrame:cg1];
			imgView.image = [UIImage imageNamed:fotonueva.foto_url];
			[viewImagen addSubview:imgView];
		}
	}
	
	NSString *strActual = [NSString stringWithFormat:@"%i",indice+1];
	NSString *strTotal = [NSString stringWithFormat:@"%i",[arrFotos count]];
	
	lblTotal.title = strActual;
	lblTotal.title = [lblTotal.title stringByAppendingString:@" / "];
	lblTotal.title = [lblTotal.title stringByAppendingString:strTotal];
	
	
	if (indice<=0){
		btnAtras.hidden=YES;
	} else {
		btnAtras.hidden=NO;
	}
	
	btnAdelante.hidden=NO;

}

-(IBAction)verAdelante{
	
	for (UIView *v in [viewImagen subviews]){
		[v removeFromSuperview];
	}	

	indice++;
	
	Foto *fotonueva = (Foto *)[arrFotos objectAtIndex:indice];
	
	if ([fotonueva.foto_tipo isEqualToString:@"YOUTUBE"]){
		[self embedYouTube: fotonueva.foto_url];  
	} else {
		NSString *strPrefix=[fotonueva.foto_url substringToIndex:4];
		if ([strPrefix isEqualToString:@"http"]){
			AsyncImageView* asyncImage = [[[AsyncImageView alloc] initWithFrame:cg1] autorelease];
			NSURL* asyncImageurl = [NSURL URLWithString: fotonueva.foto_url];
			[asyncImage loadImageFromURL:asyncImageurl];
			[viewImagen addSubview:asyncImage];
		} else {
			UIImageView *imgView = [[UIImageView alloc] initWithFrame:cg1];
			imgView.image = [UIImage imageNamed:fotonueva.foto_url];
			[viewImagen addSubview:imgView];
		}	
	}
	
	NSString *strActual = [NSString stringWithFormat:@"%i",indice+1];
	NSString *strTotal = [NSString stringWithFormat:@"%i",[arrFotos count]];
	
	lblTotal.title = strActual;
	lblTotal.title = [lblTotal.title stringByAppendingString:@" / "];
	lblTotal.title = [lblTotal.title stringByAppendingString:strTotal];
	
	
	if (indice>=[arrFotos count]-1){
		btnAdelante.hidden=YES;
	} else {
		btnAdelante.hidden=NO;
	}
	btnAtras.hidden=NO;

}

-(void)Refresh{
	
	/*
	for (UIView *v in [viewImagen subviews]){
		[v removeFromSuperview];
	}	
	
	if ([foto.foto_tipo isEqualToString:@"YOUTUBE"]){
		[self embedYouTube: foto.foto_url];  
	} else {
		NSString *strPrefix=[foto.foto_url substringToIndex:4];
		if ([strPrefix isEqualToString:@"http"]){

			AsyncImageView* asyncImage = [[[AsyncImageView alloc] initWithFrame:cg] autorelease];
			NSURL* asyncImageurl = [NSURL URLWithString: foto.foto_url];
			[asyncImage loadImageFromURL:asyncImageurl];
			[viewImagen addSubview:asyncImage];
		} else {
			UIImageView *imgView = [[UIImageView alloc] initWithFrame:cg];
			imgView.image = [UIImage imageNamed:foto.foto_url];
			[viewImagen addSubview:imgView];
		}		
	}
		
	
	
	int i;
	
	for (i=0;i<[arrFotos count];i++){
		Foto *f = (Foto *)[arrFotos objectAtIndex:i];
		if (f.foto_idr == foto.foto_idr){
			indice = i;
			break;
		}
	}
	
	
	NSString *strActual = [NSString stringWithFormat:@"%i",indice+1];
	NSString *strTotal = [NSString stringWithFormat:@"%i",[arrFotos count]];
	
	lblTotal.title = strActual;
	lblTotal.title = [lblTotal.title stringByAppendingString:@" / "];
	lblTotal.title = [lblTotal.title stringByAppendingString:strTotal];
	
	if (indice==0){
		btnAtras.hidden=YES;
	}

	if (indice==[arrFotos count]-1){
		btnAdelante.hidden=YES;
	}*/
	int indexSeleccionado=0;
	for (int i=0;i<[arrFotos count];i++){
		
		Foto *foto1 = (Foto *)[arrFotos objectAtIndex:i];
		if (self.foto != nil) {
				if ([foto1.foto_idr isEqualToString:foto.foto_idr]) {
					indexSeleccionado = i;
				}
		}

		AsyncImageView* asyncImage = [[[AsyncImageView alloc] initWithFrame:CGRectMake(i*cgw, 0, cgw, cgh)] autorelease];
		NSURL* asyncImageurl = [NSURL URLWithString: foto1.foto_url];
		[asyncImage loadImageFromURL:asyncImageurl];
		[viewImagen addSubview:asyncImage];
		
		
	}

	if (self.foto != nil) {
		[viewImagen scrollRectToVisible:CGRectMake(indexSeleccionado*cgw, 0, cgw, cgh) animated:NO];
	}
	 
	
}

-(IBAction)Salir{
	[self dismissModalViewControllerAnimated:YES];
}


- (void)embedYouTube:(NSString*)idYouTube {  
	if ([idYouTube length]>0) {
		UIWebView *videoView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 320, 367)];  
		NSString *htmlString = @"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 320\"/></head><body style=\"margin-top:0px;margin-left:0px\"><div><object width=\"320\" height=\"367\"><param name=\"movie\" value=\"";
		htmlString = [htmlString stringByAppendingString: @"http://www.youtube.com/v/"];
		//htmlString = [htmlString stringByAppendingString: @"oHg5SJYRHA0"];
		
		htmlString = [htmlString stringByAppendingString: idYouTube];
		//htmlString = [htmlString stringByAppendingString: @"&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM"];
		htmlString = [htmlString stringByAppendingString: @"\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\""];
		htmlString = [htmlString stringByAppendingString: @"http://www.youtube.com/v/"];
		//htmlString = [htmlString stringByAppendingString: @"oHg5SJYRHA0"];
		htmlString = [htmlString stringByAppendingString: idYouTube];
		//htmlString = [htmlString stringByAppendingString: @"&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM"];
		htmlString = [htmlString stringByAppendingString:@"\" type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"320\" height=\"367\"></embed></object></div></body></html>"];
		
		[videoView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.southafrica-fan.com"]];
		
		[viewImagen addSubview:videoView];  
	}
}  

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

-(IBAction)Thumbnails{
	
	AllThumbnailsController *viewController = [[AllThumbnailsController alloc] initWithNibName:@"AllThumbnails" bundle:[NSBundle mainBundle]];
	viewController.arrFotos = self.arrFotos;
	viewController.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
	[self presentModalViewController:viewController animated:YES];
	[viewController Refresh];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
		
	cg = CGRectMake(0, 0, 320, 480);
	cg1 = cg;
	cg2 = cg;
	cgw = 320;
	cgh = 480;
	
	viewImagen.contentSize = CGSizeMake(viewImagen.frame.size.width * [arrFotos count], viewImagen.frame.size.height);
    viewImagen.showsHorizontalScrollIndicator = NO;
    viewImagen.showsVerticalScrollIndicator = NO;
    viewImagen.scrollsToTop = NO;
    viewImagen.delegate = self;
	
	pageControl.numberOfPages = [arrFotos count];
    pageControl.currentPage = 0;

	NSString *strActual = [NSString stringWithFormat:@"%i",1];
	NSString *strTotal = [NSString stringWithFormat:@"%i",[arrFotos count]];
	
	lblTotal.title = strActual;
	lblTotal.title = [lblTotal.title stringByAppendingString:@" / "];
	lblTotal.title = [lblTotal.title stringByAppendingString:strTotal];
	
	[super viewDidLoad];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = viewImagen.frame.size.width;
    int page = floor((viewImagen.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
	NSString *strActual = [NSString stringWithFormat:@"%i",page+1];
	NSString *strTotal = [NSString stringWithFormat:@"%i",[arrFotos count]];
	
	lblTotal.title = strActual;
	lblTotal.title = [lblTotal.title stringByAppendingString:@" / "];
	lblTotal.title = [lblTotal.title stringByAppendingString:strTotal];
	
	
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	
	if (interfaceOrientation == UIInterfaceOrientationPortrait){
		cg = CGRectMake(0, 0, 320, 480);
		cg1= cg;
		cg2 = CGRectMake(0, 0, 320, 480);
		cgw = 320;
		cgh = 480;
	} else 	if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
		cg = CGRectMake(0, 0, 320, 480);
		cg2 = CGRectMake(0, 0, 320, 480);
		cg2 = CGRectMake(0, 0, 320, 480);
		cg1= cg;
		cgw = 320;
		cgh = 480;
	} else {
		cg = CGRectMake(0, 40, 480, 260);
		cg1 = CGRectMake(0, 0, 480, 260);
		cgw = 480;
		cgh = 260;
		cg2 = CGRectMake(0, 40, 480, 260);
	}
	
	//[self Refresh];
	[self Resize];
	
	return YES;
}

-(void)Resize{
	viewImagen.frame = cg2;
	viewImagen.contentSize = CGSizeMake(cgw * [arrFotos count], cgh);

	int i=0;
	for (UIView *v in [viewImagen subviews]){
		CGRect cg2 = CGRectMake(i*cgw, 0, cgw, cgh);
		v.frame = cg2;
		for (UIView *v1 in [v subviews]){
			v1.frame = CGRectMake(0, 0, cgw, cgh);
		}	
		i++;
	}	
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	foto =nil;
	arrFotos  =nil;
	viewImagen  =nil;
	btnAtras  =nil;
	btnAdelante  =nil;
	lblTotal=nil;
}


- (void)dealloc {
	[foto release];
	[arrFotos release];
	[viewImagen release];
	[btnAtras release];
	[btnAdelante release];
	[lblTotal release];

	foto =nil;
	arrFotos  =nil;
	viewImagen  =nil;
	btnAtras  =nil;
	btnAdelante  =nil;
	lblTotal=nil;
    [super dealloc];
}


@end
