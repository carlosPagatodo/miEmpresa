//
//  BeneficiosController.h
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 28/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetallePromocionController.h"
#import "PromocionGrandeController.h"
#import "Promocion.h"
#import "SBJSON.h"
#import "AsyncImageView.h"
#import "PagaTodoAppDelegate.h"
#import "PromocionGrande2.h"
#import "ListadoProductos.h"
#import "DetalleProducto.h"
#import "Ayuda.h"

@interface BeneficiosController : UIViewController <PromocionGrandeControllerDelegate, UIScrollViewDelegate, PromocionGrande2ControllerDelegate> {
    IBOutlet UIScrollView *sViewPromociones;
    IBOutlet UIScrollView *sView;
    IBOutlet UIView *viewLogin;
    IBOutlet UIPageControl *paginacion;
    IBOutlet UITextField *txtUsuario;
    IBOutlet UITextField *txtPassword;
    IBOutlet UIToolbar *toolTeclado;
    IBOutlet UIView *viewTopBanner1;
    IBOutlet UIView *viewTopBanner2;
    NSTimer *timer;
}
@property (nonatomic, retain) IBOutlet UIScrollView *sViewPromociones;
@property (nonatomic, retain) IBOutlet UIScrollView *sView;
@property (nonatomic, retain) IBOutlet UIView *viewLogin;
@property (nonatomic, retain) IBOutlet UIPageControl *paginacion;
@property (nonatomic, retain) IBOutlet UITextField *txtUsuario;
@property (nonatomic, retain) IBOutlet UITextField *txtPassword;
@property (nonatomic, retain) IBOutlet UIToolbar *toolTeclado;

@property (nonatomic, retain) IBOutlet UIView *viewTopBanner1;
@property (nonatomic, retain) IBOutlet UIView *viewTopBanner2;
@property (nonatomic, retain) NSTimer *timer;

-(IBAction)Entrar;
-(IBAction)Registrarse;
-(IBAction)VerDetalle;
-(void)Avanza;

-(IBAction)AbreTeclado;
-(IBAction)CierraTeclado;

-(IBAction)AbrirTopBanner1;
-(IBAction)AbrirTopBanner2;

@end
