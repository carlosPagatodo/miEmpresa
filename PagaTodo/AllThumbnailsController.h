//
//  AllThumbnailsController.h
//  SouthAfrica-Fan
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 11/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbnailController.h"
#import "FotografiaController.h"
#import "Foto.h"
//#import "VideoController.h"

@interface AllThumbnailsController : UIViewController <ThumbnailControllerDelegate> {
	IBOutlet UIScrollView *sView;
	NSMutableArray *arrFotos;
	NSMutableArray *subViewControllers;

}
@property (nonatomic, retain) IBOutlet UIScrollView *sView;
@property (nonatomic, copy) NSMutableArray *arrFotos;
@property (nonatomic, retain) NSMutableArray *subViewControllers;

-(void)Refresh;
-(IBAction)Regresar;

@end
