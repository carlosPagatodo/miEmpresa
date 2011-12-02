//
//  FotografiaController.h
//  SouthAfrica-Fan
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 08/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "Foto.h"
#import "AllThumbnailsController.h"

@interface FotografiaController : UIViewController <UIScrollViewDelegate>{
	Foto *foto;
	NSMutableArray *arrFotos;
	IBOutlet UIButton *btnAtras;
	IBOutlet UIButton *btnAdelante;
	IBOutlet UIBarButtonItem *lblTotal;
	IBOutlet UIScrollView *viewImagen;
	IBOutlet UIPageControl *pageControl;
}
@property (nonatomic, retain)  Foto *foto;
@property (nonatomic, retain)  NSMutableArray *arrFotos;
@property (nonatomic, retain)  IBOutlet UIButton *btnAtras;
@property (nonatomic, retain)  IBOutlet UIButton *btnAdelante;
@property (nonatomic, retain)  UIBarButtonItem *lblTotal;
@property (nonatomic, retain)  IBOutlet UIScrollView *viewImagen;
@property (nonatomic, retain)  IBOutlet UIPageControl *pageControl;

-(IBAction)verAtras;
-(IBAction)verAdelante;
-(IBAction)Salir;
-(void)Refresh;
- (void)embedYouTube:(NSString*)idYouTube;  
-(void)Resize;
-(IBAction)Thumbnails;

@end
