//
//  Productos.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 08/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categoria.h"
#import "RenglonCategoria.h"
#import "ListadoProductos.h"
#import "DetalleProducto.h"

#import "SBJSON.h"
#import "ZBarSDK.h"

@interface Productos : UIViewController <RenglonCategoriaDelegate, UITextFieldDelegate, ZBarReaderDelegate>{
    IBOutlet UIScrollView *sView;
    IBOutlet UIView *viewContenido;
    IBOutlet UIButton *btnAtras;
    Categoria *categoria;
    IBOutlet UITextField *txtBuscar;
    IBOutlet UIToolbar *toolTeclado;
    NSString *strAgregando;
}
@property (nonatomic, retain) IBOutlet UIScrollView *sView;
@property (nonatomic, retain) IBOutlet UIView *viewContenido;
@property (nonatomic, retain) IBOutlet UIButton *btnAtras;
@property (nonatomic, retain) Categoria *categoria;
@property (nonatomic, retain) IBOutlet UITextField *txtBuscar;
@property (nonatomic, retain) IBOutlet UIToolbar *toolTeclado;
@property (nonatomic, retain) NSString *strAgregando;

-(IBAction)Atras:(id)sender;
-(IBAction)Search;
-(IBAction)AbreTeclado;
-(IBAction)CierraTeclado;
-(IBAction)Escanear:(id)sender;

@end
