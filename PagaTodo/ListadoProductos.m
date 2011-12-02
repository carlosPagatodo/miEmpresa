//
//  ListadoProductos.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ListadoProductos.h"

@implementation ListadoProductos

@synthesize categoria;
@synthesize subcategoria;
@synthesize sView;
@synthesize viewContenido;
@synthesize strBuscar;
@synthesize strAgregando;

@synthesize viewHeader;
@synthesize toolAnterior;
@synthesize toolAnterior2;
@synthesize toolSiguiente;
@synthesize toolAmbas1;
@synthesize toolAmbas2;
@synthesize btnPagina;
@synthesize txtBuscar;
@synthesize toolTeclado;
@synthesize strPromo;

int intPagina;
int intTotalPags;

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
    txtBuscar.text = symbol.data;
    
    // EXAMPLE: do something useful with the barcode image
    //resultImage.image =
    //[info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
    // [self Search];  
    [[(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] imgBarcode] setHidden:YES];

    
    //AbreDetalle
    DetalleProducto *det = [[DetalleProducto alloc] initWithNibName:@"DetalleProducto" bundle:[NSBundle mainBundle]];
    det.strAgregando = self.strAgregando;
    det.strCodigo = txtBuscar.text;
    [self.navigationController pushViewController:det animated:YES];
}

-(IBAction)AbreTeclado{
    toolTeclado.hidden=NO;
}

-(IBAction)CierraTeclado{
    [txtBuscar resignFirstResponder];
    toolTeclado.hidden=YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self CierraTeclado];
    [self Search];
    return YES;
}

-(IBAction)Search{
    
    if ([txtBuscar.text length]==0) {
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Error"];
        [dialog setMessage:@"Por favor introduzca su búsqueda."];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        return;
    }
    
    ListadoProductos *prod = [[ListadoProductos alloc] initWithNibName:@"ListadoProductos" bundle:[NSBundle mainBundle]];
    prod.categoria = self.categoria;
    prod.subcategoria = nil;
    prod.strBuscar = txtBuscar.text;
    prod.strAgregando = self.strAgregando;
    [self.navigationController pushViewController:prod animated:YES];

 
    /*
     
     para mostrar busquedas en la misma pantalla
     
    self.categoria = self.categoria;
    self.subcategoria = nil;
    self.strBuscar = txtBuscar.text;
    self.strAgregando = self.strAgregando;
    intPagina = 1;
    [self Buscar];*/
    
 }

-(void)Buscar{
    // Do any additional setup after loading the view from its nib.
    
    for (UIView *v in [sView subviews]){
        [v removeFromSuperview];
    }	

    NSString *strURL;
    if ([strBuscar length]>0) {
        if (categoria == nil) {
            strURL = [NSString stringWithFormat: @"http://dextramedia.com/middleware/liverpool/products/?name=%@&page=%i", strBuscar,intPagina];;
        } else {
            strURL = [NSString stringWithFormat: @"http://dextramedia.com/middleware/liverpool/products/?name=%@&cat=%@&page=%i", strBuscar,self.categoria.idr,intPagina];;
        }
    } else if ([strPromo length]>0){
        strURL = [NSString stringWithFormat: @"http://dextramedia.com/middleware/liverpool/productsPromo/%@/?page=1",strPromo];
    } else {
        strURL = [NSString stringWithFormat: @"http://dextramedia.com/middleware/liverpool/products/?cat=%@&page=%i", self.categoria.idr,intPagina];;
    }
    
    
    
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //NSURL *url = [[NSURL alloc] initWithString:strURL];
    NSString *strResultado = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getURLCache:strURL];
    //NSLog(strResultado);
    
    SBJSON *jsonParser = [SBJSON new];
    
	NSDictionary *results = (NSDictionary *)[jsonParser objectWithString:strResultado error:NULL];
   // NSString *total = [NSString stringWithFormat:@"%@", [results objectForKey:@"total"]];
    
    NSArray *stores = (NSArray *)[results objectForKey:@"products"];
    NSString *strPags = (NSString *)[results objectForKey:@"total_pages"];
    intTotalPags =  [strPags intValue];
    
    int intTop = 0;
    
    viewContenido.frame = CGRectMake(0, intTop, 320, 44);
     [sView addSubview:viewContenido];
     intTop = intTop + 44;
     
    
    btnPagina.text = [NSString stringWithFormat:@" Pág. %i de %i", intPagina, intTotalPags];
    viewHeader.frame = CGRectMake(0, intTop, 320, 40);
	[sView addSubview:viewHeader];
	intTop=intTop+40;
    
    
    if (intPagina>1){
		if (intPagina < intTotalPags){
			toolAmbas1.frame = CGRectMake(0, intTop, 320, 44);
			[sView addSubview:toolAmbas1];
		} else {
			toolAnterior.frame = CGRectMake(0, intTop, 320, 44);
			[sView addSubview:toolAnterior];
		}
		intTop=intTop+44;
	}
    
    
    for (int i=0; i<[stores count]; i++) {
        NSDictionary *dicCampos = (NSDictionary *)[stores objectAtIndex:i];
        Categoria *cat;
        
        //nuevo neg
        cat = [[Categoria alloc] init];
        cat.idr = (NSString *)[dicCampos objectForKey:@"sku"];
        cat.titulo = (NSString *)[dicCampos objectForKey:@"name"];
        cat.imagen = (NSString *)[dicCampos objectForKey:@"thumbnail"];
        cat.price = (NSString *)[dicCampos objectForKey:@"price"];
        cat.price_with_discount = (NSString *)[dicCampos objectForKey:@"price_with_discount"];
        
        
        RenglonProducto *reng = [[RenglonProducto alloc] initWithNibName:@"RenglonProducto" bundle:[NSBundle mainBundle]];
        reng.cat = categoria;
        reng.sub = subcategoria;
        reng.prod = cat;
        reng.delegate =self;
        reng.view.frame = CGRectMake(0, intTop, 320, 70);
        [sView addSubview:reng.view];
        intTop = intTop + 70;
        
    }
    
    if (intPagina<intTotalPags) {
        if (intTotalPags>1){
            if (intPagina>1){
                toolAmbas2.frame = CGRectMake(0, intTop, 320, 44);
                [sView addSubview:toolAmbas2];
            } else {
                toolSiguiente.frame = CGRectMake(0, intTop, 320, 44);
                [sView addSubview:toolSiguiente];
            }
            
            intTop=intTop+44;
        }
    } else {
        if (intPagina>1) {
            toolAnterior2.frame = CGRectMake(0, intTop, 320, 44);
            [sView addSubview:toolAnterior2];
            intTop=intTop+44;
        }
    }

    [sView setContentSize:CGSizeMake(320, intTop)];
    if (intTop>sView.frame.size.height) {
        [sView setContentOffset:CGPointMake(0, 44) animated:YES];
    } else {
        [sView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
}

-(IBAction)AtrasPag{
    if (intPagina>1) {
        intPagina--;
        [self Buscar];
    }
}
-(IBAction)AdelantePag{
    if (intPagina<intTotalPags) {
        intPagina++;
        [self Buscar];
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

-(void)ProductoSelected:(RenglonProducto *)controller{
    DetalleProducto *det = [[DetalleProducto alloc] initWithNibName:@"DetalleProducto" bundle:[NSBundle mainBundle]];
    det.strAgregando = self.strAgregando;
    det.prod = controller.prod;
    [self.navigationController pushViewController:det animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    intPagina = 1;
    [self Buscar];
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
