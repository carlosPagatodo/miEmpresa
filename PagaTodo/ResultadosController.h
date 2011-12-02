//
//  ResultadosController.h
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RenglonResultadoController.h"
#import "DetalleEstablecimientoController.h"
#import "Negocio.h"
#import "NegocioAnnotation.h"
#import "SBJSON.h"
#import "PagaTodoAppDelegate.h"

@interface ResultadosController : UIViewController <UITextFieldDelegate, RenglonResultadoControllerDelegate, MKMapViewDelegate> {
	IBOutlet UIScrollView *sView;
	IBOutlet UIToolbar *toolAnterior;
	IBOutlet UIToolbar *toolSiguiente;
	IBOutlet UIBarButtonItem *lblPaginasAnterior;
	IBOutlet UIBarButtonItem *lblPaginasSiguiente;
	IBOutlet UITextField *txtBuscar;
	IBOutlet MKMapView *mapa;
	NSString *strProducto;
	NSString *strCategoria;
	NSString *strNombre;
	NSString *strEstado;
	NSString *strDelegacion;
	NSString *strColonia;
	NSString *strCP;
	NSString *strTipoBusqueda;
	NSMutableArray *arrNegocios;
	IBOutlet UIButton *botonMapa;
    NSString *strBusqueda;
    IBOutlet UIToolbar *toolTeclado;
    IBOutlet UIButton *btnAtras;
    NSMutableArray *subviewControllers;
}
@property (nonatomic, retain) IBOutlet UIScrollView *sView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolAnterior;
@property (nonatomic, retain) IBOutlet UIToolbar *toolSiguiente;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *lblPaginasAnterior;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *lblPaginasSiguiente;
@property (nonatomic, retain) IBOutlet UITextField *txtBuscar;
@property (nonatomic, retain) IBOutlet UIToolbar *toolTeclado;

@property (nonatomic, retain) IBOutlet MKMapView *mapa;
@property (nonatomic, retain) NSString *strProducto;
@property (nonatomic, retain) NSString *strCategoria;
@property (nonatomic, retain) NSString *strNombre;
@property (nonatomic, retain) NSString *strEstado;
@property (nonatomic, retain) NSString *strDelegacion;
@property (nonatomic, retain) NSString *strColonia;
@property (nonatomic, retain) NSString *strCP;
@property (nonatomic, retain) NSString *strTipoBusqueda;
@property (nonatomic, retain) NSMutableArray *arrNegocios;
@property (nonatomic, retain) IBOutlet UIButton *botonMapa;
@property (nonatomic, retain) NSString *strBusqueda;
@property (nonatomic, retain) IBOutlet UIButton *btnAtras;
@property (nonatomic, retain) NSMutableArray *subviewControllers;

-(IBAction)Mapa;
-(IBAction)Listado;
-(IBAction)Anterior;
-(IBAction)Siguiente;
-(IBAction)Atras:(id)sender;
-(void)Buscar;
-(IBAction)Search;
-(IBAction)AbreTeclado;
-(IBAction)CierraTeclado;

@end
