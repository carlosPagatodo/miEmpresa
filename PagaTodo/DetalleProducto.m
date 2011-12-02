//
//  DetalleProducto.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetalleProducto.h"

#import "SA_OAuthTwitterEngine.h" 

#define kOAuthConsumerKey				@"m1HMDuIhkNeH5PEXnaHCA"		//Consumer Key de Twitter de la app de Pagatodo
#define kOAuthConsumerSecret			@"lPTANOavt022LCj7kR0uhXH77V1AmfKSsmA96xIbE"		//Consumer Secret de Twitter de la app de Pagatodo

@implementation DetalleProducto

@synthesize categoria;
@synthesize subcategoria;
@synthesize producto;
@synthesize sView;
@synthesize viewContenido;
@synthesize viewContenido2;
@synthesize lblTitulo;
@synthesize lblPrecio;
@synthesize lblSKU;
@synthesize txtDescripcion;
@synthesize lblDisponible;
@synthesize lblColores;

@synthesize lblTitulo2;
@synthesize lblPrecio2;
@synthesize lblPrecioDesc2;
@synthesize lblPrecioTachado2;
@synthesize lblSKU2;
@synthesize txtDescripcion2;
@synthesize lblDisponible2;
@synthesize lblColores2;

@synthesize viewImagen;
@synthesize viewImagen2;
@synthesize arrFotos;
@synthesize dialogAgregar;
@synthesize prod;
@synthesize strCodigo;

@synthesize strAgregando;
@synthesize facebook = _facebook;
@synthesize timer;

static NSString* kAppId = @"289567857721510";//ID de App de Facebook de PagaTodo


//=============================================================================================================================
#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
    
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}


//=============================================================================================================================
#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	NSLog(@"Authenicated for %@", username);

    NSString *strURL = prod.link;// @"http://liverpool.com.mx/shopping/store/shop.jsp?productDetailID=1001594202";

    [_engine sendUpdate: strURL];
    
    UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
    [dialog setDelegate:self];
    [dialog setTitle:@"Twitter"];
    [dialog setMessage:@"Publicación realizada correctamente!"];
    [dialog addButtonWithTitle:@"OK"];
    [dialog show];
    [dialog release];	
    return;


}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Failed!");
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Canceled.");
}

//=============================================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	NSLog(@"Request %@ succeeded", requestIdentifier);
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
}


-(IBAction)VerGaleria:(id)sender{
    if ([arrFotos count]==0) {
        return;
    }
    FotografiaController *viewController = [[FotografiaController alloc] initWithNibName:@"Fotografia" bundle:[NSBundle mainBundle]];
    viewController.arrFotos = arrFotos;
    viewController.foto = [arrFotos objectAtIndex:0];
    //[self.navigationController pushViewController:viewController	animated:YES];
    viewController.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:viewController animated:YES];
    [viewController Refresh];
}

-(IBAction)Atras:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == dialogAgregar) {
        if (buttonIndex==0) {
            //regresar    
            //[self.navigationController popToRootViewControllerAnimated:YES];
            [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
        } else {
            //continuar
        }
    }
}

-(IBAction)Agregar:(id)sender{
    
    if ([strAgregando isEqualToString:@"SI"]) {
        
        
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] deleteCatalogo:@"ListaProducto" conPredicado:[NSString stringWithFormat:@"Id ='%@' and Producto = '%@'",[(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] strListaId],prod.idr]];

        NSMutableDictionary *dicCampos = [[NSMutableDictionary alloc] init];
        [dicCampos setValue:[(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] strListaId] forKey:@"Id"];
        [dicCampos setValue:prod.idr forKey:@"Producto"];
        [dicCampos setValue:prod.titulo forKey:@"Nombre"];
        [dicCampos setValue:prod.imagen forKey:@"imagen"];

        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] insertCatalogo:@"ListaProducto" conCampos:dicCampos];

        dialogAgregar = [[[UIAlertView alloc] init] retain];
        [dialogAgregar setDelegate:self];
        [dialogAgregar setTitle:@"Aviso"];
        [dialogAgregar setMessage:@"Producto agregado a la lista correctamente!"];
        [dialogAgregar addButtonWithTitle:@"Regresar a Lista"];
        [dialogAgregar addButtonWithTitle:@"Cerrar"];
        [dialogAgregar show];
        [dialogAgregar release];	


    } else {
        Listas *l = [[Listas alloc] initWithNibName:@"Listas" bundle:[NSBundle mainBundle]];
        l.strModal = @"SI";
        l.prod = self.prod;
        [self.navigationController pushViewController:l animated:YES];
    }
    
}

-(IBAction)Facebook:(id)sender{
    
    NSString *strURL = prod.link;//@"http://liverpool.com.mx/shopping/store/shop.jsp?productDetailID=1001594202";
    NSString *s = @"http://www.facebook.com/share.php?u=";
	s = [s stringByAppendingString:strURL];

    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:s]];
}

-(IBAction)Twitter:(id)sender{
   /* NSString *strURL = @"http://liverpool.com.mx/shopping/store/shop.jsp?productDetailID=1001594202";
	NSString *s = @"http://twitter.com/home?status=Micrositio%20de%20Reis%20";
	s = [s stringByAppendingString:strURL];

    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:s]];
*/
    if (_engine) {
        NSString *strURL = prod.link;// @"http://liverpool.com.mx/shopping/store/shop.jsp?productDetailID=1001594202";
        [_engine sendUpdate: strURL];
        
        
        UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Twitter"];
        [dialog setMessage:@"Publicación realizada correctamente!"];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        return;
    }
    
	_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
	_engine.consumerKey = kOAuthConsumerKey;
	_engine.consumerSecret = kOAuthConsumerSecret;
	
	UIViewController			*controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _engine delegate: self];
	
	if (controller) 
		[self presentModalViewController: controller animated: YES];
	else {
        NSString *strURL = @"http://liverpool.com.mx/shopping/store/shop.jsp?productDetailID=1001594202";
        [_engine sendUpdate: strURL];
        
        UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Twitter"];
        [dialog setMessage:@"Publicación realizada correctamente!"];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        return;

	}

}


- (IBAction)fbButtonClick:(id)sender {
    if (_fbButton.isLoggedIn) {
        [self logout];
    } else {
        [self login];
    }
}

- (void)login {
    [_facebook authorize:_permissions];
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    [_facebook logout:self];
}

- (IBAction)publishStream:(id)sender {
    
    [_facebook authorize:_permissions];
}

- (void)fbDidLogin {
    
    NSString *strURL = @"http://liverpool.com.mx/shopping/store/shop.jsp?productDetailID=1001594202";

    NSString *strPrecio = prod.price;
    if ([prod.price_with_discount length]>0) {
        strPrecio = prod.price_with_discount;
    }
    
    NSMutableDictionary* params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   strURL, @"link",
                                   prod.imagen, @"picture",
                                   prod.titulo, @"name",
                                   [NSString stringWithFormat:@"$ %@",strPrecio], @"caption",
                                   prod.descripcion, @"description",
                                   @"Compartido desde iPhone App",  @"message",
                                   nil];
    [_facebook dialog:@"feed"
            andParams:params1
          andDelegate:self];

}

- (void)request:(FBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    if ([result objectForKey:@"owner"]) {
//        [self.label setText:@"Photo upload Success"];
    } else {
  //      [self.label setText:[result objectForKey:@"name"]];
    }
};

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
//    [self.label setText:[error localizedDescription]];
};

- (void)dialogDidComplete:(FBDialog *)dialog {
//    [self.label setText:@"publish successfully"];

    UIAlertView *dialog2 = [[[UIAlertView alloc] init] retain];
    [dialog2 setDelegate:self];
    [dialog2 setTitle:@"Facebook"];
    [dialog2 setMessage:@"Publicación realizada correctamente!"];
    [dialog2 addButtonWithTitle:@"OK"];
    [dialog2 show];
    [dialog2 release];	
    return;

}



/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"did not login");
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    _fbButton.isLoggedIn         = NO;
    [_fbButton updateImage];
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

-(void)CierraPantalla{
    [timer invalidate];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] setDetalleProducto:self];



    NSString *strURL;
    if ([strCodigo length]==0) {
        strURL = [NSString stringWithFormat: @"http://dextramedia.com/middleware/liverpool/product/?search=sku&value=%@",self.prod.idr];
    } else {
        strURL = [NSString stringWithFormat: @"http://dextramedia.com/middleware/liverpool/product/?search=barcode&value=%@",strCodigo];
    }
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
   // NSURL *url = [[NSURL alloc] initWithString:strURL];
    NSString *strResultado = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getURLCache:strURL];
   // NSLog(strResultado);
    
    if ([strResultado length]==0) {
        UIAlertView *dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Aviso"];
        [dialog setMessage:@"Lo sentimos. El código de barras buscado no fue localizado en nuestra base de datos."];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
        
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                 target:self
                                               selector:@selector(CierraPantalla)
                                               userInfo:nil
                                                repeats:NO];

        return;
    }
    
    SBJSON *jsonParser = [SBJSON new];
    
    prod = [[Categoria alloc] init];
    
	NSDictionary *results = (NSDictionary *)[jsonParser objectWithString:strResultado error:NULL];
    prod.disponible  = [NSString stringWithFormat:@"%@", [results objectForKey:@"availability"]];
    prod.idr  = (NSString *)[results objectForKey:@"sku"];
    prod.titulo  = (NSString *)[results objectForKey:@"name"];
    prod.imagen  = (NSString *)[results objectForKey:@"thumbnail"];
    prod.price  = (NSString *)[results objectForKey:@"price"];
    prod.price_with_discount  = (NSString *)[results objectForKey:@"price_with_discount"];
    prod.descripcion  = (NSString *)[results objectForKey:@"description"];
    prod.colores  = (NSString *)[results objectForKey:@"colors"];
    prod.link  = (NSString *)[results objectForKey:@"url"];
    
    NSArray *arrImagenes = (NSArray *)[results objectForKey:@"images"];
    arrFotos = [NSMutableArray new];
    for (int i=0; i<[arrImagenes count];i++) {
        
        NSDictionary *dicCampos = (NSDictionary*)[arrImagenes objectAtIndex:i];
        
        Foto *f1 = [[Foto alloc] init];
        f1.foto_idr = [NSString stringWithFormat:@"%@",[dicCampos objectForKey:@"id"]];
        f1.foto_tipo = @"FOTO";
        f1.foto_url =  (NSString *)[dicCampos objectForKey:@"url"];
        [arrFotos addObject:f1];
        
    }

    
    AsyncImageView* asyncImage1 = [[[AsyncImageView alloc] initWithFrame:viewImagen.bounds] autorelease];
	NSURL* url1 = [NSURL URLWithString: prod.imagen];
	[asyncImage1 loadImageFromURL:url1];
	[viewImagen addSubview:asyncImage1];

	
    AsyncImageView* asyncImage2 = [[[AsyncImageView alloc] initWithFrame:viewImagen.bounds] autorelease];
	NSURL* url2 = [NSURL URLWithString: prod.imagen];
	[asyncImage2 loadImageFromURL:url2];
	[viewImagen2 addSubview:asyncImage2];

    if ([prod.disponible isEqualToString:@"1"]) {
        lblDisponible.text = @"Sí";
        lblDisponible2.text = @"Sí";
    } else {
        lblDisponible.text = @"No";
        lblDisponible2.text = @"Sí";
    }
    lblColores.text = prod.colores;
    lblTitulo.text = prod.titulo;
    lblPrecio.text = [NSString stringWithFormat:@"$%@",prod.price];
    lblSKU.text = [NSString stringWithFormat:@"SKU %@",prod.idr];
    txtDescripcion.text = prod.descripcion;

    
    lblColores2.text = prod.colores;
    lblTitulo2.text = prod.titulo;
    lblPrecio2.text = [NSString stringWithFormat:@"$%@",prod.price];
    
    if ([prod.price_with_discount length]>0) {
        lblPrecioDesc2.text = [NSString stringWithFormat:@"$%@",prod.price_with_discount];
        NSString *strRayas = @"";
        for (int i=0; i<[lblPrecio2.text length]; i++) {
            strRayas = [strRayas stringByAppendingString:@"_"];
        }
        lblPrecioTachado2.text = strRayas;
        [sView addSubview:viewContenido2];
        [sView setContentSize:viewContenido2.frame.size];
        [sView setContentOffset:CGPointMake(0,0)];

    } else {
        [sView addSubview:viewContenido];
        [sView setContentSize:viewContenido.frame.size];
        [sView setContentOffset:CGPointMake(0,0)];
    }
    lblSKU2.text = [NSString stringWithFormat:@"SKU %@",prod.idr];
    txtDescripcion2.text = prod.descripcion;


    _permissions =  [[NSArray arrayWithObjects:
                      @"publish_stream",nil] retain];
    _facebook = [[Facebook alloc] initWithAppId:kAppId
                                    andDelegate:self];
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
