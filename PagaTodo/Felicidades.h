//
//  Felicidades.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 20/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagaTodoAppDelegate.h"
#import "SBJSON.h"

@protocol FelicidadesDelegate;

@interface Felicidades : UIViewController{
    id <FelicidadesDelegate> delegate;
    IBOutlet UIView *viewContenido;
    IBOutlet UIScrollView *sView;
    IBOutlet UIToolbar *toolTeclado;
    IBOutlet UIPickerView *pickerSexo;
    IBOutlet UIDatePicker *pickerFecha;

    IBOutlet UITextField *txtNombre;
    IBOutlet UITextField *txtApellidos;
    IBOutlet UITextField *txtCorreo;

    IBOutlet UILabel *lblFecha;
    IBOutlet UILabel *lblSexo;

    NSMutableArray *arrSexo;
}
@property (nonatomic, assign) id <FelicidadesDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIView *viewContenido;
@property (nonatomic, retain) IBOutlet UIScrollView *sView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolTeclado;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerSexo;
@property (nonatomic, retain) IBOutlet UIDatePicker *pickerFecha;

@property (nonatomic, retain) IBOutlet UITextField *txtNombre;
@property (nonatomic, retain) IBOutlet UITextField *txtApellidos;
@property (nonatomic, retain) IBOutlet UITextField *txtCorreo;

@property (nonatomic, retain) IBOutlet UILabel *lblFecha;
@property (nonatomic, retain) IBOutlet UILabel *lblSexo;
@property (nonatomic, retain) NSMutableArray *arrSexo;


-(IBAction)Enviar:(id)sender;
-(IBAction)Atras:(id)sender;

-(IBAction)Sexo:(id)sender;
-(IBAction)FecNac:(id)sender;
-(IBAction)CierraTeclado:(id)sender;
-(IBAction)AbreTeclado:(id)sender;
-(IBAction)AceptaValor:(id)sender;

@end

@protocol FelicidadesDelegate
-(void)MonederoRegistrado:(NSString *)strMonedero;
@end
