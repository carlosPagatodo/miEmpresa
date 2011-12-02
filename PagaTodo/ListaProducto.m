//
//  ListaProducto.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 04/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ListaProducto.h"

@implementation ListaProducto
@synthesize sView;

@synthesize btnAgregar;
@synthesize btnEditar;
@synthesize btnEnviar;
@synthesize btnGuardar;
@synthesize btnEliminar;
@synthesize arrSubviewControllers;
@synthesize strListaId;
@synthesize dialogAgregar;
@synthesize viewTitulo;
@synthesize lblTitulo;


int intEditando;
int intTopBotones;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == dialogAgregar) {
        if (buttonIndex==0) {
            //regresar    
            
            
        } else {
            //continuar
            [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] deleteCatalogo:@"ListaProducto" conPredicado:[NSString stringWithFormat:@"Id ='%@'",self.strListaId]];

            [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] deleteCatalogo:@"Lista" conPredicado:[NSString stringWithFormat:@"Id ='%@'",self.strListaId]];

            UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
            [dialog setDelegate:self];
            [dialog setTitle:@"Aviso"];
            [dialog setMessage:@"¡Lista eliminada correctamente!"];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];	

            [self.navigationController popViewControllerAnimated:YES];

        
        }
    }
}

-(void)AgregaBotones1{
    [btnGuardar removeFromSuperview];
    [btnEliminar removeFromSuperview];
    
    int intTop = intTopBotones;
    
    btnAgregar.frame = CGRectMake(0, intTop, 320, 50);
    [sView addSubview:btnAgregar];
    intTop = intTop + 50;
    
    btnEditar.frame = CGRectMake(0, intTop, 320, 50);
    [sView addSubview:btnEditar];
    intTop = intTop + 50;
    
    btnEnviar.frame = CGRectMake(0, intTop, 320, 50);
    [sView addSubview:btnEnviar];
    intTop = intTop + 50;
    
    /*    btnGuardar.frame = CGRectMake(0, intTop, 320, 50);
     [sView addSubview:btnGuardar];
     intTop = intTop + 50;
     
     btnEliminar.frame = CGRectMake(0, intTop, 320, 50);
     [sView addSubview:btnEliminar];
     intTop = intTop + 50;
     */
    intTop = intTop + 20;

    [sView setContentSize:CGSizeMake(320, intTop)];

}

-(void)AgregaBotones2{
    [btnAgregar removeFromSuperview];
    [btnEditar removeFromSuperview];
    [btnEnviar removeFromSuperview];
    
    int intTop = intTopBotones;
    
    btnGuardar.frame = CGRectMake(0, intTop, 320, 50);
     [sView addSubview:btnGuardar];
     intTop = intTop + 50;
     
     btnEliminar.frame = CGRectMake(0, intTop, 320, 50);
     [sView addSubview:btnEliminar];
     intTop = intTop + 50;

    intTop = intTop + 20;

    [sView setContentSize:CGSizeMake(320, intTop)];
}

/*
-(void)ListaSeleccionada:(RenglonLista *)controller{
    
    Categoria * cat = [[Categoria alloc] init];
    cat.idr = controller.strListaId;
    cat.titulo = @"";//(NSString *)[dicCampos objectForKey:@"name"];
    cat.imagen = @"";//(NSString *)[dicCampos objectForKey:@"thumbnail"];
    cat.price = @"";//(NSString *)[dicCampos objectForKey:@"price"];
    cat.price_with_discount = @"";//(NSString *)[dicCampos objectForKey:@"price_with_discount"];

    
    DetalleProducto *det = [[DetalleProducto alloc] initWithNibName:@"DetalleProducto" bundle:[NSBundle mainBundle]];
    det.prod = cat;
    [self.navigationController pushViewController:det animated:YES];
}*/

-(void)ProductoSelected:(RenglonProducto *)controller{
    DetalleProducto *det = [[DetalleProducto alloc] initWithNibName:@"DetalleProducto" bundle:[NSBundle mainBundle]];
    det.strAgregando = @"";
    det.prod = controller.prod;
    [self.navigationController pushViewController:det animated:YES];
}

/*
-(void)ListaEliminada:(RenglonLista *)controller{

    [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] deleteCatalogo:@"ListaProducto" conPredicado:[NSString stringWithFormat:@"Id ='%@' and Producto = '%@'",self.strListaId, controller.strListaId]];
    [self MuestraLista];
}*/

-(void)ProductoEliminado:(RenglonProducto *)controller{
    
    [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] deleteCatalogo:@"ListaProducto" conPredicado:[NSString stringWithFormat:@"Id ='%@' and Producto = '%@'",self.strListaId, controller.prod.idr]];
    [self MuestraLista];
}


-(void)MuestraLista{
    int intTop = 10;
    
    for (UIViewController *vc in arrSubviewControllers){
		if ([vc isMemberOfClass:[RenglonProducto class]]){
			[vc.view removeFromSuperview];
			[(RenglonProducto *)vc setDelegate:nil];
			//[vc release];
			vc=nil;
		} 
	}
    
    arrSubviewControllers = [NSMutableArray new];
    
    NSArray * arrProds = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"ListaProducto" conPredicado:[NSString stringWithFormat:@"Id='%@'",strListaId] conOrden:@""];
    
    if ([arrProds count]==0) {
        
        UIAlertView *dialogo = [[[UIAlertView alloc] init] retain];
        [dialogo setDelegate:self];
        [dialogo setTitle:@"Aviso"];
        [dialogo setMessage:@"Aún no ha agregado productos a esta lista."];
        [dialogo addButtonWithTitle:@"OK"];
        [dialogo show];
        [dialogo release];	

    }
    
    viewTitulo.frame = CGRectMake(0, 0, 320, viewTitulo.frame.size.height);
    [sView addSubview:viewTitulo];
    intTop = intTop + viewTitulo.frame.size.height;

    
    for (int i=0; i<[arrProds count]; i++) {
        NSDictionary *dicCampos = (NSDictionary *)[arrProds objectAtIndex:i];
        
        /*RenglonLista *reng = [[RenglonLista alloc] initWithNibName:@"RenglonLista" bundle:[NSBundle mainBundle]];
        reng.delegate = self;
        reng.view.frame = CGRectMake(0, intTop, 320, 44);
        [sView addSubview:reng.view];
        reng.strListaId = (NSString *)[dicCampos objectForKey:@"Producto"];
        reng.lblNombre.text = (NSString *)[dicCampos objectForKey:@"Nombre"];
        reng.lblTotal.text = @"";
        
        if (i==0) {
            reng.imgFondo.image = [UIImage imageNamed:@"tablasuperior.png"];
        } else if (i==[arrProds count]-1){
            reng.imgFondo.image = [UIImage imageNamed:@"tablainferior.png"];
        }
        
        if ([arrProds count]==1) {
            reng.imgFondo.image = [UIImage imageNamed:@"tablaunica.png"];
        }
        if (intEditando>0) {
            reng.btnEliminar.hidden=NO;
        }
        
        [arrSubviewControllers addObject:reng];
        [reng release];
        
        intTop = intTop + 44;*/
        
        Categoria *cat;
        
        //nuevo neg
        cat = [[Categoria alloc] init];
        cat.idr = (NSString *)[dicCampos objectForKey:@"Producto"];
        cat.titulo = (NSString *)[dicCampos objectForKey:@"Nombre"];
        cat.imagen = (NSString *)[dicCampos objectForKey:@"imagen"];
        cat.price = @"";
        cat.price_with_discount = @"";
        
        
        RenglonProducto *reng = [[RenglonProducto alloc] initWithNibName:@"RenglonProducto" bundle:[NSBundle mainBundle]];
        reng.cat = nil;
        reng.sub = nil;
        reng.prod = cat;
        reng.delegate =self;
        reng.view.frame = CGRectMake(0, intTop, 320, 70);
        [sView addSubview:reng.view];
        
        if (intEditando>0) {
            reng.btnEliminar.hidden=NO;
        }
        
        [arrSubviewControllers addObject:reng];
        [reng release];

        
        intTop = intTop + 70;
        

        
    }
    
    intTop = intTop + 24;
    
    intTopBotones = intTop;
    if (intEditando>0) {
        [self AgregaBotones2];
    } else {
        [self AgregaBotones1];
    }    
}

-(IBAction)Agregar:(id)sender{
    
  [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] setStrListaId:self.strListaId];

    Productos *p = [[Productos alloc] init];
    p.strAgregando = @"SI";
    [self.navigationController pushViewController:p animated:YES];
}

-(IBAction)Editar:(id)sender{
    intEditando=1;
    
    for (UIViewController *vc in arrSubviewControllers){
		if ([vc isMemberOfClass:[RenglonProducto class]]){
            RenglonProducto* r= (RenglonProducto *)vc;
            r.btnEliminar.hidden=NO;
		} 
	}

    [self AgregaBotones2];
}

-(IBAction)Enviar:(id)sender{
    
    
    NSArray * arrProds = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"ListaProducto" conPredicado:[NSString stringWithFormat:@"Id='%@'",strListaId] conOrden:@""];
    
    NSString *strHTML = @"<ul>";
    for (int i=0; i<[arrProds count]; i++) {
        NSDictionary *dicCampos = (NSDictionary *)[arrProds objectAtIndex:i];

        strHTML = [strHTML stringByAppendingFormat:@"<li>%@ (SKU: %@)</li>",(NSString *)[dicCampos objectForKey:@"Nombre"],(NSString *)[dicCampos objectForKey:@"Producto"]];

    }
    strHTML = [strHTML stringByAppendingString:@"</ul>"];
    NSString *strURL = [NSString stringWithFormat:@"mailto:?subject=Lista enviado desde App de Empresa&body=Hola,<br><br>Te envío la siguiente lista:<br><br><b>Contenido de Lista</b>%@<br><br>Saludos,",strHTML];
    
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:strURL]];
}

-(IBAction)NoEditar:(id)sender{
    intEditando=0;
    
    for (UIViewController *vc in arrSubviewControllers){
		if ([vc isMemberOfClass:[RenglonProducto class]]){
            RenglonProducto* r= (RenglonProducto *)vc;
            r.btnEliminar.hidden=YES;
		} 
	}

    [self AgregaBotones1];
}

-(IBAction)Eliminar:(id)sender{
    
    dialogAgregar = [[[UIAlertView alloc] init] retain];
    [dialogAgregar setDelegate:self];
    [dialogAgregar setTitle:@"Confirmación"];
    [dialogAgregar setMessage:@"¿Está seguro de que desea eliminar la lista completa?"];
    [dialogAgregar addButtonWithTitle:@"No"];
    [dialogAgregar addButtonWithTitle:@"Sí"];
    [dialogAgregar show];
    [dialogAgregar release];	
    return;

    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    intEditando = 0;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self MuestraLista];
    [super viewWillAppear:animated];
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
