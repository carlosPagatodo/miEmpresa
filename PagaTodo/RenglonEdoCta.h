//
//  RenglonEdoCta.h
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 28/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RenglonEdoCta : UIViewController {
    IBOutlet UIView *viewImagen;
    IBOutlet UILabel *lblNombre;
    IBOutlet UILabel *lblFecha;
    IBOutlet UILabel *lblMonto;
    IBOutlet UILabel *lblSaldo;
    IBOutlet UILabel *lblDescripcion;
}
@property (nonatomic, retain) IBOutlet UIView *viewImagen;
@property (nonatomic, retain) IBOutlet UILabel *lblNombre;
@property (nonatomic, retain) IBOutlet UILabel *lblFecha;
@property (nonatomic, retain) IBOutlet UILabel *lblMonto;
@property (nonatomic, retain) IBOutlet UILabel *lblSaldo;
@property (nonatomic, retain) IBOutlet UILabel *lblDescripcion;

@end
