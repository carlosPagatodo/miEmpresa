//
//  ThumbnailController.h
//  SouthAfrica-Fan
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 11/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "Foto.h"

@protocol ThumbnailControllerDelegate;

@interface ThumbnailController : UIViewController {
	id <ThumbnailControllerDelegate> delegate;
	IBOutlet UIButton *btnPlay;
	IBOutlet UIView *viewFoto;
	Foto *foto;
}

@property (nonatomic, assign) id <ThumbnailControllerDelegate> delegate;
@property (nonatomic, retain) Foto *foto;
@property (nonatomic, retain) IBOutlet UIButton *btnPlay;
@property (nonatomic, retain) IBOutlet UIView *viewFoto;

- (IBAction)VerImagen:(id)sender;
- (void)Refresh;
- (void)embedYouTube:(NSString*)idYouTube;

@end

@protocol ThumbnailControllerDelegate
- (void)ThumbnailSelected:(ThumbnailController *)controller;
@end
