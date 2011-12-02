//
//  DetalleProducto.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJSON.h"
#import "Categoria.h"
#import "AsyncImageView.h"
#import "Foto.h"
#import "FotografiaController.h"
#import "PagaTodoAppDelegate.h"
#import "Listas.h"
#import "Facebook.h"
#import "FBConnect.h"
#import "FBLoginButton.h"

#import "SA_OAuthTwitterController.h"


@class SA_OAuthTwitterEngine;

@interface DetalleProducto : UIViewController <UIAlertViewDelegate,FBRequestDelegate,
FBDialogDelegate,
FBSessionDelegate, SA_OAuthTwitterControllerDelegate>{
    
    SA_OAuthTwitterEngine *_engine;

    IBOutlet FBLoginButton* _fbButton;

    IBOutlet UIScrollView *sView;
    IBOutlet UIView *viewContenido;
    IBOutlet UIView *viewContenido2;
    Categoria* categoria;
    Categoria* subcategoria;
    Categoria* producto;
    IBOutlet UILabel *lblTitulo;
    IBOutlet UILabel *lblPrecio;
    IBOutlet UILabel *lblSKU;
    IBOutlet UILabel *lblDisponible;
    IBOutlet UILabel *lblColores;
    IBOutlet UITextView *txtDescripcion;
    IBOutlet UIView *viewImagen;

    IBOutlet UILabel *lblTitulo2;
    IBOutlet UILabel *lblPrecio2;
    IBOutlet UILabel *lblPrecioDesc2;
    IBOutlet UILabel *lblPrecioTachado2;
    IBOutlet UILabel *lblSKU2;
    IBOutlet UILabel *lblDisponible2;
    IBOutlet UILabel *lblColores2;
    IBOutlet UITextView *txtDescripcion2;
    IBOutlet UIView *viewImagen2;
    
    UIAlertView *dialogAgregar;

    NSMutableArray *arrFotos;
    
    NSString *strAgregando;
    Categoria *prod;
    Facebook* _facebook;
    NSArray* _permissions;
    
    NSString *strCodigo;
    NSTimer * timer;
}
@property (nonatomic, retain) IBOutlet UIScrollView *sView;
@property (nonatomic, retain) IBOutlet UIView *viewContenido;
@property (nonatomic, retain) IBOutlet UIView *viewContenido2;
@property (nonatomic, retain) Categoria* categoria;
@property (nonatomic, retain) Categoria* subcategoria;
@property (nonatomic, retain) Categoria* producto;

@property (nonatomic, retain) IBOutlet UILabel *lblTitulo;
@property (nonatomic, retain) IBOutlet UILabel *lblPrecio;
@property (nonatomic, retain) IBOutlet UILabel *lblSKU;
@property (nonatomic, retain) IBOutlet UILabel *lblDisponible;
@property (nonatomic, retain) IBOutlet UILabel *lblColores;
@property (nonatomic, retain) IBOutlet UITextView *txtDescripcion;
@property (nonatomic, retain) IBOutlet UIView *viewImagen;

@property (nonatomic, retain) IBOutlet UILabel *lblTitulo2;
@property (nonatomic, retain) IBOutlet UILabel *lblPrecio2;
@property (nonatomic, retain) IBOutlet UILabel *lblPrecioDesc2;
@property (nonatomic, retain) IBOutlet UILabel *lblPrecioTachado2;
@property (nonatomic, retain) IBOutlet UILabel *lblSKU2;
@property (nonatomic, retain) IBOutlet UILabel *lblDisponible2;
@property (nonatomic, retain) IBOutlet UILabel *lblColores2;
@property (nonatomic, retain) IBOutlet UITextView *txtDescripcion2;
@property (nonatomic, retain) IBOutlet UIView *viewImagen2;

@property (nonatomic, retain) NSMutableArray* arrFotos;
@property (nonatomic, retain) NSString *strAgregando;

@property (nonatomic, retain) UIAlertView *dialogAgregar;
@property (nonatomic, retain) Categoria *prod;
@property(readonly) Facebook *facebook;
@property (nonatomic, retain) NSString * strCodigo;
@property (nonatomic, retain) NSTimer * timer;

-(IBAction)Atras:(id)sender;

-(IBAction)Agregar:(id)sender;
-(IBAction)Facebook:(id)sender;
-(IBAction)Twitter:(id)sender;
-(IBAction)VerGaleria:(id)sender;

-(IBAction)fbButtonClick:(id)sender;
-(IBAction)publishStream:(id)sender;
-(void)CierraPantalla;
- (void)login;
- (void)logout;

@end
