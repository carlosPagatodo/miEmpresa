//
//  Listas.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 08/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagaTodoAppDelegate.h"
#import "RenglonLista.h"
#import "Productos.h"
#import "ListaProducto.h"

@interface Listas : UIViewController <UITextFieldDelegate, RenglonListaDelegate, UIAlertViewDelegate, UIActionSheetDelegate>{
    IBOutlet UIScrollView *sView;
    IBOutlet UIView *viewContenido;
    IBOutlet UIView *viewNueva;
    IBOutlet UITextField *txtNueva;
    IBOutlet UIToolbar *toolTeclado;
    IBOutlet UIButton *btnAtras;
    IBOutlet UITableView *tabla;
    NSString *strModal;
    NSMutableArray *arrListas;
    UIAlertView* dialogAgregar;
    Categoria *prod;
}
@property (nonatomic, retain) IBOutlet UIScrollView *sView;
@property (nonatomic, retain) IBOutlet UIView *viewContenido;
@property (nonatomic, retain) IBOutlet UIView *viewNueva;
@property (nonatomic, retain) IBOutlet UITextField *txtNueva;
@property (nonatomic, retain) IBOutlet UIToolbar *toolTeclado;
@property (nonatomic, retain) IBOutlet UITableView *tabla;
@property (nonatomic, retain) IBOutlet UIButton *btnAtras;
@property (nonatomic, retain) NSString *strModal;
@property (nonatomic, retain) NSMutableArray *arrListas;
@property (nonatomic, retain) UIAlertView* dialogAgregar;
@property (nonatomic, retain) Categoria *prod;

-(IBAction)Atras:(id)sender;
-(IBAction)AbreTeclado;
-(IBAction)CierraTeclado;
-(IBAction)Crear;

-(void)CargaListas;
-(void)SincronizarListas;


@end
