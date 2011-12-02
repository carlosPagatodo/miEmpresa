//
//  PromocionGrandeController.h
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 14/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Promocion.h"
#import "AsyncImageView.h"

@protocol PromocionGrandeControllerDelegate;


@interface PromocionGrandeController : UIViewController {
    Promocion *promocion;
    IBOutlet UIView *viewPromocion;
    id <PromocionGrandeControllerDelegate> delegate;
}
@property (nonatomic, retain) Promocion *promocion;
@property (nonatomic, retain) IBOutlet UIView *viewPromocion;
@property (nonatomic, assign) id <PromocionGrandeControllerDelegate> delegate;

-(IBAction)AbrirPromocion;

@end

@protocol PromocionGrandeControllerDelegate
- (void)PromoSelected:(PromocionGrandeController *)controller;
@end
