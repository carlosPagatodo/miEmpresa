//
//  ListaProducto.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 04/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RenglonProducto.h"
#import "Productos.h"
#import "PagaTodoAppDelegate.h"
#import "DetalleProducto.h"

@interface ListaProducto : UIViewController <RenglonProductoDelegate, UIAlertViewDelegate>{
    IBOutlet UIScrollView *sView;
    IBOutlet UIButton *btnAgregar;
    IBOutlet UIButton *btnEditar;
    IBOutlet UIButton *btnEnviar;
    IBOutlet UIButton *btnGuardar;
    IBOutlet UIButton *btnEliminar;
    NSMutableArray *arrSubviewControllers;
    NSString *strListaId;
    UIAlertView *dialogAgregar;
    IBOutlet UIView *viewTitulo;
    IBOutlet UILabel *lblTitulo;
}
@property (nonatomic, retain) IBOutlet UIScrollView *sView;
@property (nonatomic, retain) IBOutlet UIButton *btnAgregar;
@property (nonatomic, retain) IBOutlet UIButton *btnEditar;
@property (nonatomic, retain) IBOutlet UIButton *btnEnviar;
@property (nonatomic, retain) IBOutlet UIButton *btnGuardar;
@property (nonatomic, retain) IBOutlet UIButton *btnEliminar;
@property (nonatomic, retain) IBOutlet UIView *viewTitulo;
@property (nonatomic, retain) IBOutlet UILabel *lblTitulo;

@property (nonatomic, retain) NSMutableArray *arrSubviewControllers;
@property (nonatomic, retain) NSString *strListaId;
@property (nonatomic, retain)  UIAlertView *dialogAgregar;

-(void)MuestraLista;
-(IBAction)Agregar:(id)sender;
-(IBAction)Editar:(id)sender;
-(IBAction)Enviar:(id)sender;
-(IBAction)NoEditar:(id)sender;
-(IBAction)Eliminar:(id)sender;
-(IBAction)Atras:(id)sender;

-(void)AgregaBotones1;
-(void)AgregaBotones2;

@end
