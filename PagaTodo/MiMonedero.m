//
//  MiMonedero.m
//  CFE
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 26/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MiMonedero.h"

@implementation MiMonedero

@synthesize txtTarjeta;
@synthesize lblSaldo;
@synthesize sView;
@synthesize viewNuevo;
@synthesize txtNuevo;
@synthesize toolTeclado;

@synthesize pickerSexo;
@synthesize pickerFecha;

@synthesize txtNombre;
@synthesize txtApellidos;
@synthesize txtCorreo;

@synthesize lblFecha;
@synthesize lblSexo;
@synthesize arrSexo;
@synthesize viewRegistro;



@synthesize dialogMonedero;

id controlactual;

int intOpcion;



- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView == dialogMonedero) {
        if (buttonIndex==1) {
            //Si
            intOpcion =3;//ACTIVAR        
            TecleaCodigo *tc = [[TecleaCodigo alloc] initWithNibName:@"TecleaCodigo" bundle:[NSBundle mainBundle]];
            tc.strFuncion = @"ActivarNIP";
            tc.delegate = self;
            [self presentModalViewController:tc animated:YES];
            tc.lblLabel.text = @"Ingresa el NIP que deseas (4 dígitos):";

        } else {
            //Mas tarde
        }
    }

}
-(IBAction)Agrega:(id)sender{
    UIActionSheet * actDelete1 = [[UIActionSheet alloc]
                                  initWithTitle:@"Elija una acción:"
                                  delegate:self
                                  cancelButtonTitle:@"Cancelar"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    [actDelete1 addButtonWithTitle:@"Escanear con la cámara"];
    [actDelete1 addButtonWithTitle:@"Teclear manualmente"];
    
    actDelete1.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actDelete1 showInView:[(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] window]];
    [actDelete1 release];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        return;
    } else if (buttonIndex==1){
        [self Escanear:nil];
    } else {
        
        intOpcion=1;
        
        TecleaCodigo *tc = [[TecleaCodigo alloc] initWithNibName:@"TecleaCodigo" bundle:[NSBundle mainBundle]];
        tc.delegate=self;
        [self presentModalViewController:tc animated:YES];
    }
}

-(void)FormularioCancelado{
    if (intOpcion==1) {
    } else if (intOpcion==3) {
    } else {
        //Debe ingresar el nip para ingresar al monedero
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Alerta"];
        [dialog setMessage:@"Debe ingresar el nip para ingresar al monedero."];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        
        [[(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] tabBarController] setSelectedIndex:0];


    }
}


-(void)TarjetaAgregada:(NSString *)strTarjeta{
    
    if (intOpcion==1) {
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Alerta"];
        [dialog setMessage:@"Saldo agregado correctamente."];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
    } else if (intOpcion==3) {
        
        NSMutableDictionary *dicCampos = [[NSMutableDictionary alloc] init];
        [dicCampos setValue:strTarjeta forKey:@"nip"];
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] insertCatalogo:@"NIP" conCampos:dicCampos];

        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Registro exitoso"];
        [dialog setMessage:@"NIP activado correctamente."];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] setStrNIP:[strTarjeta retain]];


    } else {
        NSArray *arrNIP = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"NIP" conPredicado:@"" conOrden:@""];
        NSDictionary *dicCampos = (NSDictionary *)[arrNIP objectAtIndex:0];
        NSString *strNIP = (NSString *)[dicCampos objectForKey:@"nip"];
        
        if ([strNIP isEqualToString:strTarjeta]==NO) {
            UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
            [dialog setDelegate:self];
            [dialog setTitle:@"Error"];
            [dialog setMessage:@"NIP incorrecto"];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];	
            

            TecleaCodigo *tc = [[TecleaCodigo alloc] initWithNibName:@"TecleaCodigo" bundle:[NSBundle mainBundle]];
            tc.delegate = self;
            tc.strFuncion = @"VerificarNIP";
            [self presentModalViewController:tc animated:NO];
            tc.lblLabel.text = @"Ingresa tu NIP:";

            return;
        } else {
        
           [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] setStrNIP:[strTarjeta retain]];

        }
    
    }
    

    [self performSelectorInBackground:@selector(CargaMonederosBack) withObject:nil];
}

-(void)CargaMonederosBack{
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self CargaMonederos];
    [pool release];
}

-(IBAction)Config:(id)sender{
    Configuracion *cf = [[Configuracion alloc] initWithNibName:@"Configuracion" bundle:[NSBundle mainBundle]];
    cf.delegate = self;
    [self.navigationController pushViewController:cf animated:YES];
}

-(IBAction)Sexo:(id)sender{
    controlactual = lblSexo;
    [self CierraTecladoReg:nil];
    [pickerSexo setHidden:NO];
    [self AbreTecladoReg:nil];
    [sView setContentOffset:CGPointMake(0, 220) animated:YES];

}

-(IBAction)FecNac:(id)sender{
    controlactual = lblFecha;
    [self CierraTecladoReg:nil];
    [pickerFecha setHidden:NO];
    [self AbreTecladoReg:nil];
    [sView setContentOffset:CGPointMake(0, 220) animated:YES];
}

-(IBAction)CierraTecladoReg:(id)sender{
    
    if (controlactual==lblFecha) {
            
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"dd/MMM/yyyy"];
            NSString *strFecha = [format stringFromDate:pickerFecha.date];
            
            lblFecha.text = strFecha;

    }
    
    if (controlactual==lblSexo) {
        int row = [pickerSexo selectedRowInComponent:0];
        if (row==0) {
            lblSexo.text = @"Masculino";
        } else {
            lblSexo.text = @"Femenino";
        }
    }
    
    [sView setContentSize:viewRegistro.frame.size ];
    toolTeclado.hidden=YES;
    pickerSexo.hidden=YES;
    pickerFecha.hidden=YES;
    [txtNombre resignFirstResponder];
    [txtApellidos resignFirstResponder];
    [txtCorreo resignFirstResponder];
}
-(IBAction)AbreTecladoReg:(id)sender{
    if (sender!=nil) {
        controlactual = sender;
    }
    //sView.frame = CGRectMake(0, 44, 320, 156) ;
    [sView setContentSize:CGSizeMake(320, viewRegistro.frame.size.height+220)];
    toolTeclado.frame = CGRectMake(0, 152, 320, 44);
    toolTeclado.hidden=NO;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
	return 40;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSString *strTitulo=@"";
    
    if (row==0) {
        strTitulo = @"Masculino";
    } else {
        strTitulo = @"Femenino";
    }
	
	
	return strTitulo;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
}


-(IBAction)AceptaValor:(id)sender{
    
    if (pickerFecha.hidden==NO) {
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"dd/MMM/yyyy"];
        NSString *strFecha = [format stringFromDate:pickerFecha.date];
        
        lblFecha.text = strFecha;
    } else {
        int row = [pickerSexo selectedRowInComponent:0];
        if (row==0) {
            lblSexo.text = @"Masculino";
        } else {
            lblSexo.text = @"Femenino";
        }

    }
    [self CierraTecladoReg:nil];
}

-(IBAction)Registrar:(id)sender{
    
    if (   [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] ValidaConexion]==NO) {
        return;
    }
    
    
    if ([txtNombre.text length]==0) {
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Error"];
        [dialog setMessage:@"Debe introducir su nombre"];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        return;
    }

    if ([txtApellidos.text length]==0) {
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Error"];
        [dialog setMessage:@"Debe introducir sus apellidos"];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        return;
    }

    if ([txtCorreo.text length]<5) {
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Error"];
        [dialog setMessage:@"Debe introducir su correo electrónico"];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        return;
    }
    
    if ([lblSexo.text isEqualToString:@"Masculino"]) {
        //nada
    }   else if ([lblSexo.text isEqualToString:@"Femenino"]) {
        //nada
    } else {
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Error"];
        [dialog setMessage:@"Debe seleccionar el sexo"];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        return;    
    }

    if ([lblFecha.text isEqualToString:@"Fecha de Nacimiento"]) {
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Error"];
        [dialog setMessage:@"Debe seleccionar su fecha de nacimiento"];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        return;    
    }

    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"dd/MMM/yyyy"];
    
    NSDate *date2 = [dateFormatter dateFromString:lblFecha.text];

    NSDate *date1 = [[NSDate alloc] init];
    NSTimeInterval diff = [date2 timeIntervalSinceDate:date1]; // diff = 3600.0

    if (diff>0) {
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Error"];
        [dialog setMessage:@"La fecha de nacimiento es incorrecta"];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        return;
    }

    NSString *strURL;
    strURL = @"http://dextramedia.com/middleware/liverpool/register";
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
   // NSURL *url = [[NSURL alloc] initWithString:strURL];
    NSString *strResultado = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getURLCache:strURL];
    //NSLog(strResultado);
    
    SBJSON *jsonParser = [SBJSON new];
    
	NSDictionary *results = (NSDictionary *)[jsonParser objectWithString:strResultado error:NULL];
    NSString *total = [NSString stringWithFormat:@"%@", [results objectForKey:@"result"]];
    NSString *barcode = [NSString stringWithFormat:@"%@", [results objectForKey:@"barcode"]];
    NSString *error_message = [NSString stringWithFormat:@"%@", [results objectForKey:@"error_message"]];
    
        
    
    if ([total isEqualToString:@"1"]){
        dialogMonedero = [[[UIAlertView alloc] init] retain];
        [dialogMonedero setDelegate:self];
        [dialogMonedero setTitle:@"Felicidades"];
        [dialogMonedero setMessage:[NSString stringWithFormat: @"Su monedero fue registrado correctamente con el número: %@\n¿Desea activar un NIP para proteger su monedero?",barcode]];
        [dialogMonedero addButtonWithTitle:@"Más tarde"];
        [dialogMonedero addButtonWithTitle:@"Sí"];
        [dialogMonedero show];
        [dialogMonedero release];	
    } else {
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Alerta"];
        [dialog setMessage:error_message];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        
        return;
    }
    
    
    //[self.navigationController popViewControllerAnimated:YES];
    
    
    NSMutableDictionary *dicCampos = [[NSMutableDictionary alloc] init];
    [dicCampos setValue:barcode forKey:@"Numero"];
    [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] insertCatalogo:@"Monedero" conCampos:dicCampos];
    
    
    [self.viewRegistro removeFromSuperview];
    [self CargaMonederos];
    


    
}

-(IBAction)Anterior:(id)sender{
    if (controlactual == txtApellidos) {
        [txtNombre becomeFirstResponder];
        [sView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (controlactual == txtCorreo) {
        [txtApellidos becomeFirstResponder];
        [sView setContentOffset:CGPointMake(0, 150) animated:YES];
    } else if (controlactual == lblFecha) {
        [self CierraTeclado];
        [txtApellidos becomeFirstResponder];
        [sView setContentOffset:CGPointMake(0, 200) animated:YES];
    } else {
            [self FecNac:nil];

    } 
}

-(IBAction)Siguiente:(id)sender{
    if (controlactual == txtNombre) {
        [txtApellidos becomeFirstResponder];
        [sView setContentOffset:CGPointMake(0, 150) animated:YES];
    } else if (controlactual == txtApellidos) {
        [txtCorreo becomeFirstResponder];
        [sView setContentOffset:CGPointMake(0, 200) animated:YES];
    } else {
        [self CierraTeclado];
        [sView setContentOffset:CGPointMake(0, 0) animated:YES];
        if (controlactual == txtCorreo) {
            [self FecNac:nil];
            return;
        }
        if (controlactual == lblFecha) {
            [self Sexo:nil];
            return;
        }
    } 
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == txtNombre) {
        [txtApellidos becomeFirstResponder];
        [sView setContentOffset:CGPointMake(0, 150) animated:YES];
    } else if (textField == txtApellidos) {
        [txtCorreo becomeFirstResponder];
        [sView setContentOffset:CGPointMake(0, 200) animated:YES];
    } else {
        [self CierraTeclado];
        if (textField == txtCorreo) {
            [self FecNac:nil];
        } else {
            [sView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
    
    return YES;
}

-(IBAction)AbreTeclado:(id)sender{
    if (sender!=nil) {
        controlactual = sender;
    }

    if (sender == txtNombre) {
        [sView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (sender == txtApellidos) {
        [sView setContentOffset:CGPointMake(0, 150) animated:YES];
    } else if (sender == txtCorreo) {
        [sView setContentOffset:CGPointMake(0, 200) animated:YES];
    } else {
    }

    toolTeclado.hidden=NO;
    toolTeclado.frame = CGRectMake(0, 200, 320, 44);

    [sView setContentSize:CGSizeMake(320, viewRegistro.frame.size.height+220)];
    //[sView setContentOffset:CGPointMake(0, 156)];
}

-(IBAction)CierraTeclado{
    
    if (controlactual==lblFecha) {
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"dd/MMM/yyyy"];
        NSString *strFecha = [format stringFromDate:pickerFecha.date];
        
        lblFecha.text = strFecha;
        
    }
    
    if (controlactual==lblSexo) {
        int row = [pickerSexo selectedRowInComponent:0];
        if (row==0) {
            lblSexo.text = @"Masculino";
        } else {
            lblSexo.text = @"Femenino";
        }
    }

    [sView setContentSize:viewRegistro.frame.size ];
    toolTeclado.hidden=YES;
    pickerSexo.hidden=YES;
    pickerFecha.hidden=YES;

    [txtNombre resignFirstResponder];
    [txtApellidos resignFirstResponder];
    [txtCorreo resignFirstResponder];

    [txtNuevo resignFirstResponder];
    toolTeclado.hidden=YES;

}

-(void)VerMovimientos:(MonederoRenglon *)controller{
    
    EstadoCuenta *edoCta = [[EstadoCuenta alloc] init];
    [self.navigationController pushViewController:edoCta animated:YES];

}


-(IBAction)Escanear:(id)sender{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    [[(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] imgBarcode] setHidden:NO];

    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [self presentModalViewController: reader
                            animated: YES];
    [reader release];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [[(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] imgBarcode] setHidden:YES];
    [picker dismissModalViewControllerAnimated: YES];
    
}


- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    //txtNuevo.text = symbol.data;
    [self AgregaSaldo:symbol.data];
    
    [[(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] imgBarcode] setHidden:YES];

    // EXAMPLE: do something useful with the barcode image
    //resultImage.image =
    //[info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
}

-(void)MonederoRegistrado:(NSString *)strMonedero{

}

-(void)AgregaSaldo:(NSString *)strCodigo{
    if ([strCodigo length]==0) {
        
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Alerta"];
        [dialog setMessage:@"Debe ingresar un número válido."];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        
        return;
        
    }
    
    UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
    [dialog setDelegate:self];
    [dialog setTitle:@"Alerta"];
    [dialog setMessage:@"Saldo agregado correctamente."];
    [dialog addButtonWithTitle:@"OK"];
    [dialog show];
    [dialog release];	
    [self CargaMonederos];
}

-(IBAction)Enviar:(id)sender{
    
    if ([txtNuevo.text length]==0) {
        
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Alerta"];
        [dialog setMessage:@"Debe ingresar un número válido."];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	

        return;
        
    }
    [self CierraTeclado];

    
    UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
    [dialog setDelegate:self];
    [dialog setTitle:@"Alerta"];
    [dialog setMessage:@"Saldo agregado correctamente."];
    [dialog addButtonWithTitle:@"OK"];
    [dialog show];
    [dialog release];	
    
    txtNuevo.text = @"";

    
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)CargaMonederos{
    
    [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] PensandoBack];
    
    int intTop = 0;
    
    for (UIView *v in [sView subviews]){
        [v removeFromSuperview];
    }	

    
    NSMutableDictionary *dicCampos = [[NSMutableDictionary alloc] init];
    [dicCampos setValue:txtNuevo.text forKey:@"Numero"];
    NSArray *arrMonederos = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"Monedero" conPredicado:@"" conOrden:@""];
    
    for (int i=0; i<[arrMonederos count]; i++) {
        NSMutableDictionary *dicCampos = (NSMutableDictionary *)[arrMonederos objectAtIndex:i];
        
        MonederoRenglon *reng = [[MonederoRenglon alloc] initWithNibName:@"MonederoRenglon" bundle:[NSBundle mainBundle]];
        reng.strTarjeta = (NSString *)[dicCampos objectForKey:@"Numero"];
        reng.delegate = self;
        
        reng.view.frame = CGRectMake(0, intTop, 320, 320);
        [sView addSubview:reng.view];
        
        NSString *strBarras = @"";
        NSString *strTarjeta = reng.strTarjeta;
        strTarjeta = [strTarjeta stringByAppendingString:reng.strDigito];
        
        for (int i=0; i<[strTarjeta length]; i++) {
            if (i==[strTarjeta length]-1) {
                strBarras = [strBarras stringByAppendingFormat:@"%@",[strTarjeta substringWithRange:NSMakeRange(i,1)]];
            } else {
                strBarras = [strBarras stringByAppendingFormat:@"%@ ",[strTarjeta substringWithRange:NSMakeRange(i,1)]];
            }
        }
        
        reng.lblNumero.text = strBarras;
        
        
        
        [reng Saldo:nil];
        
        intTop = intTop + 320;

    }
    

    
    
    viewNuevo.frame = CGRectMake(0, intTop, 320, 48);
    [sView addSubview:viewNuevo];
    intTop = intTop + 48;
    
    [sView setContentSize:CGSizeMake(320, intTop)];
    
    [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] NoPensandoBack];

}

-(void)MonederoEliminado{
    
    for (UIView *v in [sView subviews]){
        [v removeFromSuperview];
    }	

    txtNombre.text = @"";
    txtApellidos.text = @"";
    txtCorreo.text = @"";
    lblSexo.text = @"Sexo";
    lblFecha.text = @"Fecha de Nacimiento";
    
    [sView addSubview:viewRegistro];
    [sView setContentSize:viewRegistro.frame.size];
}


-(void)viewWillAppear:(BOOL)animated{

    NSArray *arrMonederos = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"Monedero" conPredicado:@"" conOrden:@""];
    
    if ([arrMonederos count]==0) {
       // [sView addSubview:viewRegistro];
        //[sView setContentSize:viewRegistro.frame.size];
    } else {
        
        NSArray *arrNIP = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"NIP" conPredicado:@"" conOrden:@""];
        
        if ([arrNIP count]>0) {
            
            NSString *strNIP = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] strNIP];
            
            if ([strNIP length]==0) {
                intOpcion = 2;
                TecleaCodigo *tc = [[TecleaCodigo alloc] initWithNibName:@"TecleaCodigo" bundle:[NSBundle mainBundle]];
                tc.delegate = self;
                tc.strFuncion = @"VerificarNIP";
                [self presentModalViewController:tc animated:NO];
                tc.lblLabel.text = @"Ingresa tu NIP:";
            } else {
                [self CargaMonederos];
            }
            
        } else {
            [self CargaMonederos];
        }
        
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self Refrescar:nil];
    NSArray *arrMonederos = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"Monedero" conPredicado:@"" conOrden:@""];
    
    if ([arrMonederos count]==0) {
        [sView addSubview:viewRegistro];
        [sView setContentSize:viewRegistro.frame.size];
    } 


    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
