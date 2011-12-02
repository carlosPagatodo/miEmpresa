//
//  DetalleEstablecimientoController.h
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Negocio.h"
#import "NegocioAnnotation.h"
#import "PagaTodoAppDelegate.h"
#import "AsyncImageView.h"

@interface DetalleEstablecimientoController : UIViewController {
	IBOutlet UIScrollView *sView;
	IBOutlet UIView *viewDetalle;
	Negocio *neg;
	IBOutlet MKMapView *mapa;
	IBOutlet UILabel *lblNombre;
	IBOutlet UILabel *lblDireccion;
	IBOutlet UILabel *lblColonia;
	IBOutlet UILabel *lblDelegacion;
	IBOutlet UILabel *lblEstado;
	IBOutlet UILabel *lblFax;
	IBOutlet UILabel *lblTipo;
	IBOutlet UILabel *lblDistancia;
	IBOutlet UILabel *lblCP;
    IBOutlet UILabel *lblTelefono;
    IBOutlet UILabel *lblHorarios;
    IBOutlet UIView *viewImagen;
}
@property (nonatomic, retain) IBOutlet UIScrollView *sView;
@property (nonatomic, retain) IBOutlet UIView *viewDetalle;
@property (nonatomic, retain) Negocio *neg;
@property (nonatomic, retain) IBOutlet MKMapView *mapa;
@property (nonatomic, retain) IBOutlet UILabel *lblNombre;
@property (nonatomic, retain) IBOutlet UILabel *lblDireccion;
@property (nonatomic, retain) IBOutlet UILabel *lblColonia;
@property (nonatomic, retain) IBOutlet UILabel *lblDelegacion;
@property (nonatomic, retain) IBOutlet UILabel *lblEstado;
@property (nonatomic, retain) IBOutlet UILabel *lblFax;
@property (nonatomic, retain) IBOutlet UILabel *lblTipo;
@property (nonatomic, retain) IBOutlet UILabel *lblDistancia;
@property (nonatomic, retain) IBOutlet UILabel *lblCP;
@property (nonatomic, retain) IBOutlet UILabel *lblTelefono;
@property (nonatomic, retain) IBOutlet UILabel *lblHorarios;
@property (nonatomic, retain) IBOutlet UIView *viewImagen;


- (IBAction)Ruta;
-(IBAction)Llamar;
-(IBAction)Mas;
-(IBAction)Web;
-(IBAction)Mail;
-(IBAction)Atras:(id)sender;

@end
