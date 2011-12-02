//
//  RenglonResultadoController.h
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Negocio.h"
#import "AsyncImageView.h"

@protocol RenglonResultadoControllerDelegate;

@interface RenglonResultadoController : UIViewController {
	IBOutlet UILabel *lblDistancia;
	IBOutlet UILabel *lblNombre;
	IBOutlet UILabel *lblTipo;
	IBOutlet UILabel *lblDireccion;
	IBOutlet UILabel *lblColonia;
	 IBOutlet UILabel *lblEstado;
	IBOutlet UILabel *lblDelegacion;
    IBOutlet UIView *viewFoto;
	id <RenglonResultadoControllerDelegate> delegate;
	Negocio *neg;
}
@property (nonatomic, retain) IBOutlet UILabel *lblDistancia;
@property (nonatomic, retain) IBOutlet UILabel *lblNombre;
@property (nonatomic, retain) IBOutlet UILabel *lblTipo;
@property (nonatomic, retain) IBOutlet UILabel *lblDireccion;
@property (nonatomic, retain) IBOutlet UILabel *lblEstado;
@property (nonatomic, retain) IBOutlet UILabel *lblDelegacion;
@property (nonatomic, retain) IBOutlet UILabel *lblColonia;
@property (nonatomic, retain) IBOutlet UIView *viewFoto;
@property (nonatomic, assign) id <RenglonResultadoControllerDelegate> delegate;
@property (nonatomic, retain) Negocio *neg;

-(IBAction)Seleccionar;

@end

@protocol RenglonResultadoControllerDelegate
- (void)RenglonSelected:(RenglonResultadoController *)controller;
@end

