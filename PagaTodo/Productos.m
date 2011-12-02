//
//  Productos.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 08/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Productos.h"

@implementation Productos
@synthesize sView;
@synthesize viewContenido;
@synthesize categoria;
@synthesize btnAtras;
@synthesize txtBuscar;
@synthesize toolTeclado;
@synthesize strAgregando;

-(IBAction)Escanear:(id)sender{
    
    
    
    [[(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] imgBarcode] setHidden:NO];
    
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
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

-(void)CategoriaSelected:(RenglonCategoria *)controller{
    if (categoria == nil) {
        Productos *prod = [[Productos alloc] initWithNibName:@"Productos" bundle:[NSBundle mainBundle]];
        prod.categoria = controller.cat;
        prod.strAgregando = self.strAgregando;
        [self.navigationController pushViewController:prod animated:YES];
    } else  if ([controller.cat.final isEqualToString:@"1"]) {
        ListadoProductos *prod = [[ListadoProductos alloc] initWithNibName:@"ListadoProductos" bundle:[NSBundle mainBundle]];
        prod.categoria = controller.cat;
        prod.strAgregando = self.strAgregando;
        [self.navigationController pushViewController:prod animated:YES];
    } else {
        Productos *prod = [[Productos alloc] initWithNibName:@"Productos" bundle:[NSBundle mainBundle]];
        prod.categoria = controller.cat;
        prod.strAgregando = self.strAgregando;
        [self.navigationController pushViewController:prod animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSString *strURL;
    if (categoria == nil) {
        btnAtras.hidden=YES;
        strURL = @"http://dextramedia.com/middleware/liverpool/categories";
    } else {
        strURL = [NSString stringWithFormat: @"http://dextramedia.com/middleware/liverpool/categories/%@/",categoria.idr];
    }
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //NSURL *url = [[NSURL alloc] initWithString:strURL];
    NSString *strResultado = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getURLCache:strURL];
    //NSLog(strResultado);
    
    SBJSON *jsonParser = [SBJSON new];
    
	NSDictionary *results = (NSDictionary *)[jsonParser objectWithString:strResultado error:NULL];
   // NSString *total = [NSString stringWithFormat:@"%@", [results objectForKey:@"total"]];
    
    NSArray *stores = (NSArray *)[results objectForKey:@"categories"];
    
    int intTop = 0;
    
    viewContenido.frame = CGRectMake(0, intTop, 320, 44);
    [sView addSubview:viewContenido];
    intTop = intTop + 44;
    
    for (int i=0; i<[stores count]; i++) {
        NSDictionary *dicCampos = (NSDictionary *)[stores objectAtIndex:i];
        Categoria *cat;
        
        //nuevo neg
        cat = [[Categoria alloc] init];
        cat.idr = [NSString stringWithFormat:@"%@",(NSString *)[dicCampos objectForKey:@"id"]];
        cat.titulo = (NSString *)[dicCampos objectForKey:@"name"];
        cat.imagen = (NSString *)[dicCampos objectForKey:@"image"];
        cat.total = [NSString stringWithFormat:@"%@",[dicCampos objectForKey:@"products_total"]];
        cat.final = [NSString stringWithFormat:@"%@",[dicCampos objectForKey:@"final"]];

        
        RenglonCategoria *reng = [[RenglonCategoria alloc] initWithNibName:@"RenglonCategoria" bundle:[NSBundle mainBundle]];
        reng.cat = cat;
        reng.delegate =self;
        reng.view.frame = CGRectMake(0, intTop, 320, 44);
        [sView addSubview:reng.view];
        intTop = intTop + 44;
        
    }

    [sView setContentSize:CGSizeMake(320, intTop)];
    
    if ([strAgregando isEqualToString:@"SI"]){
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
