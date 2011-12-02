//
//  MonederoRenglon.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 20/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagaTodoAppDelegate.h"
#import "SBJSON.h"
#import "NKDEAN13Barcode.h"
#import "UIImage-NKDBarcode.h"

@protocol MonederoRenglonDelegate;

@interface MonederoRenglon : UIViewController {
    NSString *strTarjeta;
    IBOutlet UILabel *lblNumero;
    IBOutlet UILabel *lblSaldo;
    IBOutlet UILabel *lblFecha;
    IBOutlet UIView *viewCodigo;
    NSString *strDigito;
    id <MonederoRenglonDelegate> delegate;
}
@property (nonatomic, retain) NSString *strTarjeta;
@property (nonatomic, retain) IBOutlet UILabel *lblNumero;
@property (nonatomic, retain) IBOutlet UILabel *lblSaldo;
@property (nonatomic, retain) IBOutlet UILabel *lblFecha;
@property (nonatomic, retain) IBOutlet UIView *viewCodigo;
@property (nonatomic, retain) NSString * strDigito;
@property (nonatomic, assign) id <MonederoRenglonDelegate> delegate;


-(IBAction)Movimientos:(id)sender;
-(IBAction)Saldo:(id)sender;

@end

@protocol MonederoRenglonDelegate
-(void)VerMovimientos:(MonederoRenglon *)controller;
@end

