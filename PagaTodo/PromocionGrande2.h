//
//  PromocionGrande2.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 03/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Promocion.h"
#import "AsyncImageView.h"

@protocol PromocionGrande2ControllerDelegate;

@interface PromocionGrande2 : UIViewController{
    Promocion *promocion;
    IBOutlet UIView *viewPromocion;
    id <PromocionGrande2ControllerDelegate> delegate;
}
@property (nonatomic, retain) Promocion *promocion;
@property (nonatomic, retain) IBOutlet UIView *viewPromocion;
@property (nonatomic, assign) id <PromocionGrande2ControllerDelegate> delegate;

-(IBAction)AbrirPromocion;


@end

@protocol PromocionGrande2ControllerDelegate
- (void)Promo2Selected:(PromocionGrande2 *)controller;
@end
