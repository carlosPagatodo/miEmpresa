//
//  Configuracion.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Configuracion.h"

@implementation Configuracion
@synthesize sView;
@synthesize delegate;

int intOpcion;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (intOpcion==0) {
        return;
    } else if (intOpcion == 1){
        //Eliminar NIP (SI/NO)
        
        if (buttonIndex==1) {
            return;//NO
        }
        

        intOpcion = 5;
        TecleaCodigo *tc = [[TecleaCodigo alloc] initWithNibName:@"TecleaCodigo" bundle:[NSBundle mainBundle]];
        tc.delegate = self;
        tc.strFuncion = @"EliminarNIP";
        [self presentModalViewController:tc animated:YES];
        tc.lblLabel.text = @"Ingresa tu NIP:";

    
    } else if (intOpcion == 2){
        //Eliminar MONEDERO (SI/NO)
        if (buttonIndex==1) {
            return;//NO
        }

        NSArray *arrNIP = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"NIP" conPredicado:@"" conOrden:@""];
        
        if ([arrNIP count]>0) {
                        
            TecleaCodigo *tc = [[TecleaCodigo alloc] initWithNibName:@"TecleaCodigo" bundle:[NSBundle mainBundle]];
            tc.delegate = self;
            tc.strFuncion = @"EliminarMonedero";
            [self presentModalViewController:tc animated:YES];
            tc.lblLabel.text = @"Ingresa tu NIP:";
        } else {
            [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] deleteCatalogo:@"Monedero" conPredicado:@""];
            
            intOpcion = 0;
            
            UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
            [dialog setDelegate:self];
            [dialog setTitle:@"Aviso"];
            [dialog setMessage:@"Su monedero fue eliminado correctamente."];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];	
            
            [self.navigationController popViewControllerAnimated:YES];
            [self.delegate MonederoEliminado];

            
        }

    } else if (intOpcion == 3){
        //activar
        
    } else if (intOpcion == 4){
        //cambiar
    }
}

-(IBAction)Atras:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
-(void)ListaEliminada:(RenglonLista *)controller{
}

-(void)FormularioCancelado{
    intOpcion=0;
}

-(void)TarjetaAgregada:(NSString *)strTarjeta{

    if (intOpcion == 1){
        
        //revisar NIP. Si es igual borrar monedero
        intOpcion = 0;
        
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] deleteCatalogo:@"NIP" conPredicado:@""];


        UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Aviso"];
        [dialog setMessage:@"Su NIP fue eliminado correctamente."];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] setStrNIP:@""];

    } else if (intOpcion == 2) {
        
        NSArray *arrNIP = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"NIP" conPredicado:@"" conOrden:@""];
        NSDictionary *dicCampos = (NSDictionary *)[arrNIP objectAtIndex:0];
        NSString *strNIP = (NSString *)[dicCampos objectForKey:@"nip"];
        
        if ([strNIP isEqualToString:strTarjeta]) {
            
            [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] deleteCatalogo:@"NIP" conPredicado:@""];

            [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] deleteCatalogo:@"Monedero" conPredicado:@""];
            
            intOpcion = 0;
            
            UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
            [dialog setDelegate:self];
            [dialog setTitle:@"Aviso"];
            [dialog setMessage:@"Su monedero fue eliminado correctamente."];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];	
            
            [self.navigationController popViewControllerAnimated:YES];
            [self.delegate MonederoEliminado];
            return;
        } else {
            intOpcion = 0;

            UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
            [dialog setDelegate:self];
            [dialog setTitle:@"Error"];
            [dialog setMessage:@"NIP incorrecto"];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];	

            
        }        
        
    } else if (intOpcion == 3) {
        //activar
        intOpcion = 0;
        
        NSMutableDictionary *dicCampos = [[NSMutableDictionary alloc] init];
        [dicCampos setValue:strTarjeta forKey:@"nip"];
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] insertCatalogo:@"NIP" conCampos:dicCampos];
        
        UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Registro exitoso."];
        [dialog setMessage:@"Su NIP fue activado correctamente."];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] setStrNIP:[strTarjeta retain]];

    } else if (intOpcion == 4) {
        //cambiar
        intOpcion = 0;
        
        NSArray *arrNIP = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"NIP" conPredicado:@"" conOrden:@""];
        NSDictionary *dicCampos = (NSDictionary *)[arrNIP objectAtIndex:0];
        NSString *strNIP = (NSString *)[dicCampos objectForKey:@"nip"];
        
        if ([strNIP isEqualToString:strTarjeta]) {

            intOpcion = 6;
            
            TecleaCodigo *tc = [[TecleaCodigo alloc] initWithNibName:@"TecleaCodigo" bundle:[NSBundle mainBundle]];
            tc.strFuncion = @"NuevoNIP";
            tc.delegate = self;
            [self presentModalViewController:tc animated:NO];
            tc.lblLabel.text = @"Ingresa tu nuevo NIP:";
            return;
        } else {

            UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
            [dialog setDelegate:self];
            [dialog setTitle:@"Error"];
            [dialog setMessage:@"NIP incorrecto"];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];	

        }
        

    } else if (intOpcion==5){
        
        intOpcion=0;

        NSArray *arrNIP = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"NIP" conPredicado:@"" conOrden:@""];
        NSDictionary *dicCampos = (NSDictionary *)[arrNIP objectAtIndex:0];
        NSString *strNIP = (NSString *)[dicCampos objectForKey:@"nip"];
        
        if ([strNIP isEqualToString:strTarjeta]) {
            [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] deleteCatalogo:@"NIP" conPredicado:@""];

            UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
            [dialog setDelegate:self];
            [dialog setTitle:@"Aviso."];
            [dialog setMessage:@"Su NIP fue eliminado correctamente."];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];	
            
            [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] setStrNIP:@""];


        } else {

            UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
            [dialog setDelegate:self];
            [dialog setTitle:@"Error"];
            [dialog setMessage:@"NIP incorrecto"];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];	
            

        }
    } else if (intOpcion == 6 ) {
    
        intOpcion = 0;
        
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] deleteCatalogo:@"NIP" conPredicado:@""];
        NSMutableDictionary *dicCampos = [[NSMutableDictionary alloc] init];
        [dicCampos setValue:strTarjeta forKey:@"nip"];
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] insertCatalogo:@"NIP" conCampos:dicCampos];
        
        UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Aviso."];
        [dialog setMessage:@"Su NIP fue cambiado correctamente."];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] setStrNIP:[strTarjeta retain]];

    }

    [self viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    
        
        NSArray *arrNIP = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"NIP" conPredicado:@"" conOrden:@""];
        
        if ([arrNIP count]>0) {
            
            NSString *strNIP = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] strNIP];
            
            if ([strNIP length]==0) {
                [self.navigationController popViewControllerAnimated:NO];
            } 
            
        } 
        
    
}


-(void)ListaSeleccionada:(RenglonLista *)controller{

    if ([controller.strListaId isEqualToString:@"Ayuda"]) {
        Ayuda *ay = [[Ayuda alloc] initWithNibName:@"Ayuda" bundle:[NSBundle mainBundle]];
        ay.strWWW = @"http://www.pagatodo.com";
        [self.navigationController pushViewController:ay animated:YES];
    } else if ([controller.strListaId isEqualToString:@"Politica"]) {
        Ayuda *ay = [[Ayuda alloc] initWithNibName:@"Ayuda" bundle:[NSBundle mainBundle]];
        ay.strWWW = @"http://www.google.com.mx/intl/es-419/privacy/privacy-policy.html";
        [self.navigationController pushViewController:ay animated:YES];
    } else if ([controller.strListaId isEqualToString:@"Terminos"]) {
        Ayuda *ay = [[Ayuda alloc] initWithNibName:@"Ayuda" bundle:[NSBundle mainBundle]];
        ay.strWWW = @"http://www.google.com.mx/intl/es-419/privacy/privacy-policy.html";
        [self.navigationController pushViewController:ay animated:YES];
    } else if ([controller.strListaId isEqualToString:@"ActivarNIP"]) {
        
        intOpcion =3;

        TecleaCodigo *tc = [[TecleaCodigo alloc] initWithNibName:@"TecleaCodigo" bundle:[NSBundle mainBundle]];
        tc.strFuncion = controller.strListaId;
        tc.delegate = self;
        [self presentModalViewController:tc animated:YES];
        tc.lblLabel.text = @"Ingresa el NIP que deseas (4 dígitos):";
            
        
    } else if ([controller.strListaId isEqualToString:@"CambiarNIP"]) {

        intOpcion =4;

        TecleaCodigo *tc = [[TecleaCodigo alloc] initWithNibName:@"TecleaCodigo" bundle:[NSBundle mainBundle]];
        tc.strFuncion = controller.strListaId;
        tc.delegate = self;
        [self presentModalViewController:tc animated:YES];
        tc.lblLabel.text = @"Ingresa tu NIP anterior:";

    } else if ([controller.strListaId isEqualToString:@"EliminarNIP"]) {
        
        intOpcion =1;
        UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Confirmación"];
        [dialog setMessage:@"¿Está seguro de que desea eliminar su NIP?"];
        [dialog addButtonWithTitle:@"Sí"];
        [dialog addButtonWithTitle:@"No"];
        [dialog show];
        [dialog release];	

    } else if ([controller.strListaId isEqualToString:@"EliminarMonedero"]) {
        intOpcion=2;
        UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Confirmación"];
        [dialog setMessage:@"¿Está seguro de que desea eliminar su monedero?"];
        [dialog addButtonWithTitle:@"Sí"];
        [dialog addButtonWithTitle:@"No"];
        [dialog show];
        [dialog release];	

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    for (UIView *v in [sView subviews]){
        [v removeFromSuperview];
    }	

    intOpcion=0;
    
    int intTop=0;
    intTop = intTop + 20;

    RenglonLista *reng;
    
    NSArray *arrNIP = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"NIP" conPredicado:@"" conOrden:@""];
    
    if ([arrNIP count]>0) {

        //NIP
        reng = [[RenglonLista alloc] initWithNibName:@"RenglonLista" bundle:[NSBundle mainBundle]];
        reng.delegate = self;
        reng.view.frame = CGRectMake(0, intTop, 320, 44);
        [sView addSubview:reng.view];
        reng.strListaId = @"CambiarNIP";
        reng.lblNombre.text = @"Cambiar NIP";
        reng.lblTotal.text = @"";
        reng.imgFondo.image = [UIImage imageNamed:@"tablasuperior.png"];
        intTop = intTop + 44;
        
        reng = [[RenglonLista alloc] initWithNibName:@"RenglonLista" bundle:[NSBundle mainBundle]];
        reng.delegate = self;
        reng.view.frame = CGRectMake(0, intTop, 320, 44);
        [sView addSubview:reng.view];
        reng.strListaId = @"EliminarNIP";
        reng.lblNombre.text = @"Eliminar NIP";
        reng.lblTotal.text = @"";
        reng.imgFondo.image = [UIImage imageNamed:@"tablainferior.png"];
        intTop = intTop + 44;

    } else {
        //NIP
        reng = [[RenglonLista alloc] initWithNibName:@"RenglonLista" bundle:[NSBundle mainBundle]];
        reng.delegate = self;
        reng.view.frame = CGRectMake(0, intTop, 320, 44);
        [sView addSubview:reng.view];
        reng.strListaId = @"ActivarNIP";
        reng.lblNombre.text = @"Activar NIP";
        reng.lblTotal.text = @"";
        reng.imgFondo.image = [UIImage imageNamed:@"tablaunica.png"];
        intTop = intTop + 44;
    }
    
    
    intTop = intTop + 20;
    
    //Eliminar Monedero

    reng = [[RenglonLista alloc] initWithNibName:@"RenglonLista" bundle:[NSBundle mainBundle]];
    reng.delegate = self;
    reng.view.frame = CGRectMake(0, intTop, 320, 44);
    [sView addSubview:reng.view];
    reng.strListaId = @"EliminarMonedero";
    reng.lblNombre.text = @"Eliminar Monedero";
    reng.lblTotal.text = @"";
    reng.imgFondo.image = [UIImage imageNamed:@"tablaunica.png"];
    intTop = intTop + 44;
    intTop = intTop + 20;
    
    //Ayuda

    reng = [[RenglonLista alloc] initWithNibName:@"RenglonLista" bundle:[NSBundle mainBundle]];
    reng.delegate = self;
    reng.view.frame = CGRectMake(0, intTop, 320, 44);
    [sView addSubview:reng.view];
    reng.strListaId = @"Ayuda";
    reng.lblNombre.text = @"Ayuda";
    reng.lblTotal.text = @"";
    reng.imgFondo.image = [UIImage imageNamed:@"tablasuperior.png"];
    intTop = intTop + 44;

    reng = [[RenglonLista alloc] initWithNibName:@"RenglonLista" bundle:[NSBundle mainBundle]];
    reng.delegate = self;
    reng.view.frame = CGRectMake(0, intTop, 320, 44);
    [sView addSubview:reng.view];
    reng.strListaId = @"Politica";
    reng.lblNombre.text = @"Política de Privacidad";
    reng.lblTotal.text = @"";
    intTop = intTop + 44;

    reng = [[RenglonLista alloc] initWithNibName:@"RenglonLista" bundle:[NSBundle mainBundle]];
    reng.delegate = self;
    reng.view.frame = CGRectMake(0, intTop, 320, 44);
    [sView addSubview:reng.view];
    reng.strListaId = @"Terminos";
    reng.lblNombre.text = @"Términos y Condiciones";
    reng.lblTotal.text = @"";
    reng.imgFondo.image = [UIImage imageNamed:@"tablainferior.png"];
    intTop = intTop + 44;


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
