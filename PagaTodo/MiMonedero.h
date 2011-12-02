//
//  MiMonedero.h
//  CFE
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 26/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EstadoCuenta.h"
#import "MonederoRenglon.h"
#import "Felicidades.h"
#import "ZBarSDK.h"
#import "Configuracion.h"
#import "TecleaCodigo.h"

@interface MiMonedero : UIViewController <MonederoRenglonDelegate,UITextFieldDelegate,FelicidadesDelegate,TecleaCodigoDelegate, UIActionSheetDelegate, ZBarReaderDelegate, ConfiguracionDelegate>{
    IBOutlet UITextField *txtTarjeta;
    IBOutlet UILabel *lblSaldo;
    IBOutlet UIScrollView *sView;

    IBOutlet UIView *viewNuevo;
    IBOutlet UITextField *txtNuevo;
    IBOutlet UIToolbar *toolTeclado;

    IBOutlet UIPickerView *pickerSexo;
    IBOutlet UIDatePicker *pickerFecha;
    
    IBOutlet UITextField *txtNombre;
    IBOutlet UITextField *txtApellidos;
    IBOutlet UITextField *txtCorreo;
    
    IBOutlet UILabel *lblFecha;
    IBOutlet UILabel *lblSexo;
    
    IBOutlet UIView *viewRegistro;
    NSMutableArray *arrSexo;
    UIAlertView* dialogMonedero;
    
    
    


}
@property (nonatomic, retain) IBOutlet UITextField *txtTarjeta;
@property (nonatomic, retain) IBOutlet UILabel *lblSaldo;
@property (nonatomic, retain) IBOutlet UIScrollView *sView;

@property (nonatomic, retain) IBOutlet UIView *viewNuevo;
@property (nonatomic, retain) IBOutlet UITextField *txtNuevo;
@property (nonatomic, retain) IBOutlet UIToolbar *toolTeclado;


@property (nonatomic, retain) IBOutlet UIPickerView *pickerSexo;
@property (nonatomic, retain) IBOutlet UIDatePicker *pickerFecha;

@property (nonatomic, retain) IBOutlet UITextField *txtNombre;
@property (nonatomic, retain) IBOutlet UITextField *txtApellidos;
@property (nonatomic, retain) IBOutlet UITextField *txtCorreo;

@property (nonatomic, retain) IBOutlet UILabel *lblFecha;
@property (nonatomic, retain) IBOutlet UILabel *lblSexo;
@property (nonatomic, retain) NSMutableArray *arrSexo;
@property (nonatomic, retain) IBOutlet UIView *viewRegistro;
@property (nonatomic, retain)  UIAlertView* dialogMonedero;


-(IBAction)Registrar:(id)sender;

-(IBAction)Sexo:(id)sender;
-(IBAction)FecNac:(id)sender;
-(IBAction)CierraTecladoReg:(id)sender;
-(IBAction)AbreTecladoReg:(id)sender;
-(IBAction)AceptaValor:(id)sender;

-(IBAction)Anterior:(id)sender;
-(IBAction)Siguiente:(id)sender;


-(IBAction)Escanear:(id)sender;
-(IBAction)Enviar:(id)sender;
-(IBAction)AbreTeclado:(id)sender;
-(IBAction)CierraTeclado;

-(IBAction)Agrega:(id)sender;
-(IBAction)Config:(id)sender;

-(void)CargaMonederos;
-(void)AgregaSaldo:(NSString *)strCodigo;
-(void)CargaMonederosBack;


@end
