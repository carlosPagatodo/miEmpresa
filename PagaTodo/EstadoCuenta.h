//
//  EstadoCuenta.h
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 28/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RenglonEdoCta.h"
#import "Movimiento.h"
#import "SBJSON.h"
#import "PagaTodoAppDelegate.h"

@interface EstadoCuenta : UIViewController {
    IBOutlet UIScrollView *sView;
}
@property (nonatomic, retain) IBOutlet UIScrollView *sView;

-(IBAction)Atras;

@end
