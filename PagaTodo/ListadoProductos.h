//
//  ListadoProductos.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categoria.h"
#import "RenglonProducto.h"
#import "SBJSON.h"
#import "DetalleProducto.h"
#import "PagaTodoAppDelegate.h"
#import "ZBarSDK.h"

@interface ListadoProductos : UIViewController <RenglonProductoDelegate, ZBarReaderDelegate>{
    Categoria* categoria;
    Categoria* subcategoria;
    IBOutlet UIScrollView *sView;
    IBOutlet UIView *viewContenido;
    NSString *strBuscar;
    NSString *strAgregando;

    IBOutlet UIView *viewHeader;
    IBOutlet UIToolbar *toolAnterior;
    IBOutlet UIToolbar *toolAnterior2;
    IBOutlet UIToolbar *toolSiguiente;
    IBOutlet UIToolbar *toolAmbas1;
    IBOutlet UIToolbar *toolAmbas2;
    
    IBOutlet UILabel *btnPagina;

    IBOutlet UITextField *txtBuscar;
    IBOutlet UIToolbar *toolTeclado;
    
    NSString *strPromo;

}
@property (nonatomic, retain) Categoria* categoria;
@property (nonatomic, retain) Categoria* subcategoria;
@property (nonatomic, retain) IBOutlet UIScrollView *sView;
@property (nonatomic, retain) IBOutlet UIView *viewContenido;
@property (nonatomic, retain) IBOutlet NSString *strBuscar;
@property (nonatomic, retain) NSString *strAgregando;

@property (nonatomic, retain) IBOutlet UILabel *btnPagina;
@property (nonatomic, retain) IBOutlet UIView *viewHeader;
@property (nonatomic, retain) IBOutlet UIToolbar *toolAnterior;
@property (nonatomic, retain) IBOutlet UIToolbar *toolAnterior2;
@property (nonatomic, retain) IBOutlet UIToolbar *toolSiguiente;
@property (nonatomic, retain) IBOutlet UIToolbar *toolAmbas1;
@property (nonatomic, retain) IBOutlet UIToolbar *toolAmbas2;

@property (nonatomic, retain) IBOutlet UITextField *txtBuscar;
@property (nonatomic, retain) IBOutlet UIToolbar *toolTeclado;
@property (nonatomic, retain) NSString *strPromo;

-(IBAction)Atras:(id)sender;

-(IBAction)AtrasPag;
-(IBAction)AdelantePag;

-(void)Buscar;

-(IBAction)Search;
-(IBAction)AbreTeclado;
-(IBAction)CierraTeclado;
-(IBAction)Escanear:(id)sender;

@end
