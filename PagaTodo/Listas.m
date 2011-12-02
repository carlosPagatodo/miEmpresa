//
//  Listas.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 08/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Listas.h"

@implementation Listas
@synthesize sView;
@synthesize viewContenido;
@synthesize toolTeclado;
@synthesize viewNueva;
@synthesize txtNueva;
@synthesize btnAtras;
@synthesize strModal;
@synthesize tabla;
@synthesize arrListas;
@synthesize dialogAgregar;
@synthesize prod;

int intSeleccionado;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == dialogAgregar) {
        if (buttonIndex==0) {
        //regresar    
            [self.navigationController popViewControllerAnimated:YES];
        } else {
        //continuar
            [self CargaListas];
        }
    }
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrListas count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


	CGRect CellFrame = CGRectMake(0, 0, 300, 30);
	CGRect Label1Frame = CGRectMake(40, 10, 260, 25);
	
	UILabel *lblTemp;
	
	//UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:CellFrame reuseIdentifier:[NSString stringWithFormat:@"cell%i",indexPath.row]] autorelease];

    UITableViewCell *cell = [[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%i",indexPath.row]] autorelease];
    cell.frame = CellFrame;
    
	//Initialize Label with tag 1.
	lblTemp = [[UILabel alloc] initWithFrame:Label1Frame];
	lblTemp.tag = 1;
	lblTemp.font = [UIFont boldSystemFontOfSize:12];
    lblTemp.backgroundColor = [UIColor clearColor];
    NSDictionary *dicCampos = (NSDictionary *)[arrListas objectAtIndex:indexPath.row];
    lblTemp.text = (NSString *)[dicCampos objectForKey:@"Nombre"];
    cell.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lblTemp];
	[lblTemp release];
	
	return cell;
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    
    if (buttonIndex==0) {
        return;
    } else if (buttonIndex == 1){
        //NSDictionary *dicCampos = (NSDictionary *)[arrListas objectAtIndex:intSeleccionado];
        Productos *p = [[Productos alloc] init];
        p.strAgregando = @"SI";
        [self.navigationController pushViewController:p animated:YES];
    } else if (buttonIndex == 2){
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Aviso"];
        [dialog setMessage:@"En construcción"];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
    } else if (buttonIndex == 3){

        NSString *strURL = [NSString stringWithFormat:@"mailto:?subject=Lista enviado desde App de Empresa&body=Hola,<br><br>Te envío la siguiente lista:<br><br><b>Contenido de Lista</b><br><br>Saludos,"];
        
        strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:strURL]];

    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([strModal isEqualToString:@"SI"]) {
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Aviso"];
        [dialog setMessage:@"El producto se ha agregado a la lista correctamente."];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
        intSeleccionado = indexPath.row;
        UIActionSheet * actDelete1 = [[UIActionSheet alloc]
                      initWithTitle:@"Elija una acción:"
                      delegate:self
                      cancelButtonTitle:@"Cancelar"
                      destructiveButtonTitle:nil
                      otherButtonTitles:nil];
        
        [actDelete1 addButtonWithTitle:@"Agregar Producto"];
        [actDelete1 addButtonWithTitle:@"Editar lista"];
        [actDelete1 addButtonWithTitle:@"Enviar por e-mail"];

        actDelete1.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actDelete1 showInView:[(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] window]];
        [actDelete1 release];

    }
}


-(IBAction)Atras:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ListaEliminada:(RenglonLista *)controller{
}


-(void)ListaSeleccionada:(RenglonLista *)controller{
    if ([strModal length]>0) {
        
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] deleteCatalogo:@"ListaProducto" conPredicado:[NSString stringWithFormat:@"Id ='%@' and Producto = '%@'",controller.strListaId,prod.idr]];

        
        NSMutableDictionary *dicCampos = [[NSMutableDictionary alloc] init];
        [dicCampos setValue:controller.strListaId forKey:@"Id"];
        [dicCampos setValue:prod.idr forKey:@"Producto"];
        [dicCampos setValue:prod.titulo forKey:@"Nombre"];
        [dicCampos setValue:prod.imagen forKey:@"imagen"];
        
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] insertCatalogo:@"ListaProducto" conCampos:dicCampos];
        
        UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Aviso"];
        [dialog setMessage:@"Producto agregado a la lista correctamente!"];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        [self.navigationController popViewControllerAnimated:YES];

        return;
    } else {
        ListaProducto *l = [[ListaProducto alloc] init];
        l.strListaId = controller.strListaId;
        [self.navigationController pushViewController:l animated:YES];
        l.lblTitulo.text = controller.lblNombre.text;
    }

}

-(IBAction)Crear{
    [self CierraTeclado];
    
    
    if ([txtNueva.text length]==0) {
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Aviso"];
        [dialog setMessage:@"Debe introducir el nombre de la lista a crear."];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        return;

    }
    
    
    NSMutableDictionary *dicCampos = [[NSMutableDictionary alloc] init];
    [dicCampos setValue:txtNueva.text forKey:@"Nombre"];
    
    
    int intCons = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] MaxLista];
    
    [dicCampos setValue:[NSString stringWithFormat:@"%i",intCons+1] forKey:@"Id"];
    [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] insertCatalogo:@"Lista" conCampos:dicCampos];
    txtNueva.text= @"";
    
    [self CargaListas];
    
    UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
    [dialog setDelegate:self];
    [dialog setTitle:@"Aviso"];
    [dialog setMessage:@"Lista Creada Correctamente."];
    [dialog addButtonWithTitle:@"OK"];
    [dialog show];
    [dialog release];	
    
    [self performSelectorInBackground:@selector(SincronizarListas) withObject:nil];
    return;

    
}


-(void)SincronizarListas{
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    
    NSArray *arrRegistros= [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"Lista" conPredicado:@"sincronizado='0'" conOrden:@""];
    

    for (int i=0; i<[arrRegistros count]; i++) {
        
        NSDictionary *dicCampos = (NSDictionary *)[arrRegistros objectAtIndex:i];
        
        
        NSString *strIDLista = [dicCampos objectForKey:@"Id"];
        NSString *strNombre = [dicCampos objectForKey:@"Nombre"];
        
        
        NSString *strURL = [NSString stringWithFormat: @"http://www.pagatodo.com/ws/listas.php?Id=%@&nombre=%@" , strIDLista , strNombre];
        
        //NSLog(@"@", strURL);
        
        
    }
    
    [pool release];

}

-(void)CargaListas{
    
    for (UIView *v in [sView subviews]){
        [v removeFromSuperview];
    }	

    int intTop = 0;
    
    
    if ([strModal length]==0) {
     //   viewContenido.frame = CGRectMake(0, intTop, 320, 242);
      //  intTop = intTop + 242;
       // [sView addSubview:viewContenido];
    }
    viewNueva.frame = CGRectMake(0, intTop, 320, 109);
    intTop = intTop + 109;
    [sView addSubview:viewNueva];
    
    
    arrListas = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"Lista" conPredicado:@"" conOrden:@""];
    
    for (int i=0; i<[arrListas count]; i++) {
        NSMutableDictionary *dicCampos = (NSMutableDictionary *)[arrListas objectAtIndex:i];
        
        RenglonLista *reng = [[RenglonLista alloc] initWithNibName:@"RenglonLista" bundle:[NSBundle mainBundle]];
        reng.delegate = self;
        reng.view.frame = CGRectMake(0, intTop, 320, 44);
        [sView addSubview:reng.view];
        reng.strListaId = (NSString *)[dicCampos objectForKey:@"Id"];
        reng.lblNombre.text = (NSString *)[dicCampos objectForKey:@"Nombre"];

        NSArray * arrProds = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getRegistros:@"ListaProducto" conPredicado:[NSString stringWithFormat:@"Id='%@'",(NSString *)[dicCampos objectForKey:@"Id"]] conOrden:@""];

        reng.lblTotal.text = [NSString stringWithFormat:@"(%i)",[arrProds count]];

        if (i==0) {
            reng.imgFondo.image = [UIImage imageNamed:@"tablasuperior.png"];
        } else if (i==[arrListas count]-1){
            reng.imgFondo.image = [UIImage imageNamed:@"tablainferior.png"];
        }
        
        if ([arrListas count]==1) {
            reng.imgFondo.image = [UIImage imageNamed:@"tablaunica.png"];
        }
        
        intTop = intTop + 44;
        
         
        
    }
    

    if ([arrListas count]==0) {
        intTop = intTop + 20;
        UILabel *lblSinListas = [[[UILabel alloc] initWithFrame:CGRectMake(0, intTop, 320, 80)] autorelease];
        lblSinListas.textAlignment = UITextAlignmentCenter;
        lblSinListas.font = [UIFont boldSystemFontOfSize:16];
        lblSinListas.numberOfLines = 4;
        lblSinListas.text = @"No tiene listas agregadas.\n\nPara crear una nueva lista introduzca el nombre y haga click en crear.";
        lblSinListas.backgroundColor = [UIColor clearColor];
        [sView addSubview:lblSinListas];
        intTop = intTop + 80;
    }
    
    [sView setContentSize:CGSizeMake(320, intTop)];
    //[tabla reloadData];
}

-(IBAction)AbreTeclado{
    toolTeclado.hidden=NO;
}

-(IBAction)CierraTeclado{
    [txtNueva resignFirstResponder];
    toolTeclado.hidden=YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self Crear];
    return YES;
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

- (void)viewWillAppear:(BOOL)animated{
    [self CargaListas];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([strModal length]>0) {
        btnAtras.hidden=NO;
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
