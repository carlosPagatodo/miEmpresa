    //
//  BeneficiosController.m
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 28/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BeneficiosController.h"


@implementation BeneficiosController

@synthesize sViewPromociones;
@synthesize sView;
@synthesize viewLogin;
@synthesize paginacion;
@synthesize txtUsuario;
@synthesize txtPassword;
@synthesize toolTeclado;
@synthesize viewTopBanner1;
@synthesize viewTopBanner2;
@synthesize timer;

int intActual = 1;
int intTotal=0;

NSString *strTopBanner1;
NSString *strTopBanner2;


-(IBAction)AbrirTopBanner1{
  //  [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:strTopBanner1]];

    Ayuda *ay = [[Ayuda alloc] initWithNibName:@"Ayuda" bundle:[NSBundle mainBundle]];
    ay.strWWW = strTopBanner1;
    [self.navigationController pushViewController:ay animated:YES];

}
-(IBAction)AbrirTopBanner2{
    Ayuda *ay = [[Ayuda alloc] initWithNibName:@"Ayuda" bundle:[NSBundle mainBundle]];
    ay.strWWW = strTopBanner2;
    [self.navigationController pushViewController:ay animated:YES];
}

-(IBAction)AbreTeclado{
    toolTeclado.hidden=NO;
    [sView scrollRectToVisible:CGRectMake(0, sView.contentSize.height-1, 1, 1) animated:YES];
}

-(IBAction)CierraTeclado{
    toolTeclado.hidden=YES;
    [txtUsuario resignFirstResponder];
    [txtPassword resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger nearestNumber = lround(fractionalPage);
    paginacion.currentPage = nearestNumber;
    intActual = paginacion.currentPage;

}

-(IBAction)VerDetalle{
    
	
}

-(IBAction)Entrar{
    
    
    
}

-(IBAction)Registrarse{

}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)Promo2Selected:(PromocionGrande2 *)controller{
    
    if ([controller.promocion.tipo isEqualToString:@"url"]) {
       // [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:controller.promocion.url]];
        
        Ayuda *ay = [[Ayuda alloc] initWithNibName:@"Ayuda" bundle:[NSBundle mainBundle]];
        ay.strWWW = controller.promocion.url;
        [self.navigationController pushViewController:ay animated:YES];

    } else if ([controller.promocion.tipo isEqualToString:@"category"]) {
        
        
        Categoria *cat;
        
        //nuevo neg
        cat = [[Categoria alloc] init];
        cat.idr = controller.promocion.url;
        cat.titulo = @"Promoción";//(NSString *)[dicCampos objectForKey:@"name"];
        cat.imagen = @"";//(NSString *)[dicCampos objectForKey:@"image"];
        cat.total = @"";//[NSString stringWithFormat:@"%@",[dicCampos objectForKey:@"products_total"]];
        cat.final = @"";//[NSString stringWithFormat:@"%@",[dicCampos objectForKey:@"final"]];

        
        ListadoProductos *prod = [[ListadoProductos alloc] initWithNibName:@"ListadoProductos" bundle:[NSBundle mainBundle]];
        prod.categoria = cat;
        [self.navigationController pushViewController:prod animated:YES];
    } else if ([controller.promocion.tipo isEqualToString:@"product_list"]) {
        ListadoProductos *prod = [[ListadoProductos alloc] initWithNibName:@"ListadoProductos" bundle:[NSBundle mainBundle]];
        prod.strPromo = controller.promocion.url;
        [self.navigationController pushViewController:prod animated:YES];
    }
    
}

- (void)PromoSelected:(PromocionGrandeController *)controller{
   // [self VerDetalle];
    if ([controller.promocion.tipo isEqualToString:@"url"]) {
        [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:controller.promocion.url]];
    } else if ([controller.promocion.tipo isEqualToString:@"category"]) {
        Categoria *cat;
        
        //nuevo neg
        cat = [[Categoria alloc] init];
        cat.idr = controller.promocion.url;
        cat.titulo = @"Promoción";//(NSString *)[dicCampos objectForKey:@"name"];
        cat.imagen = @"";//(NSString *)[dicCampos objectForKey:@"image"];
        cat.total = @"";//[NSString stringWithFormat:@"%@",[dicCampos objectForKey:@"products_total"]];
        cat.final = @"";//[NSString stringWithFormat:@"%@",[dicCampos objectForKey:@"final"]];
        
        
        ListadoProductos *prod = [[ListadoProductos alloc] initWithNibName:@"ListadoProductos" bundle:[NSBundle mainBundle]];
        prod.categoria = cat;
        [self.navigationController pushViewController:prod animated:YES];
     } else if ([controller.promocion.tipo isEqualToString:@"product_list"]) {
         ListadoProductos *prod = [[ListadoProductos alloc] initWithNibName:@"ListadoProductos" bundle:[NSBundle mainBundle]];
         prod.strPromo = controller.promocion.url;
         [self.navigationController pushViewController:prod animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    int intLeft=0;
    
    //Google Analytics
    [(PagaTodoAppDelegate *) [[UIApplication sharedApplication] delegate] CambiarAnalytics:@"http://www.pagatodo.com/analytics/promociones.php"];
    
    NSString *strURL = @"http://dextramedia.com/middleware/liverpool/promotions";
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *strResultado;// = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getURLCache:strURL];
    //NSURL *url = [[NSURL alloc] initWithString:strURL];
    
    //---------------------------------------
    
    [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] deleteCache];
    strResultado = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getURL:strURL];
    if ([strResultado length]==0) {
        
        for (UIView *v in [sViewPromociones subviews]){
            [v removeFromSuperview];
        }	
        for (UIView *v in [viewTopBanner1 subviews]){
            [v removeFromSuperview];
        }	
        for (UIView *v in [viewTopBanner2 subviews]){
            [v removeFromSuperview];
        }	
        
        
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] PensandoBack];
        
        if ([(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] ValidaConexion]) {
            NSURL *url = [[NSURL alloc] initWithString:strURL];
            strResultado = [NSString stringWithContentsOfURL:url encoding:NSISOLatin1StringEncoding error:nil];
            if ([strResultado length]>0) {
                [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] insertURL:strURL conResult:strResultado];
            }
        } 
        
        [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] NoPensandoBack];
        
    } else {
        
        if ([[viewTopBanner2 subviews] count]>0) {
            //ya mostró las de caché
            return;
        }
    }
    
    
    //---------------------------------------
    
    SBJSON *jsonParser = [SBJSON new];
    
	NSDictionary *results = (NSDictionary *)[jsonParser objectWithString:strResultado error:NULL];
    
    NSArray *top_banners = (NSArray *)[results objectForKey:@"top_banners"];
    
    for (int i=0; i<[top_banners count]; i++) {
        NSDictionary *dicCampos = (NSDictionary *)[top_banners objectAtIndex:i];
        //NSString *idr = (NSString *)[dicCampos objectForKey:@"id"];
        NSString *image = (NSString *)[dicCampos objectForKey:@"image"];
        NSString *url = (NSString *)[dicCampos objectForKey:@"value"];
        //NSString *type = (NSString *)[dicCampos objectForKey:@"type"];
        
        if (i==0) {
            AsyncImageView* asyncImage1 = [[[AsyncImageView alloc] initWithFrame:viewTopBanner1.bounds] autorelease];
            NSURL* url1 = [NSURL URLWithString: image];
            [asyncImage1 loadImageFromURL:url1];
            [viewTopBanner1 addSubview:asyncImage1];
            
            strTopBanner1 = [url retain];
            
        } else {
            AsyncImageView* asyncImage1 = [[[AsyncImageView alloc] initWithFrame:viewTopBanner2.bounds] autorelease];
            NSURL* url1 = [NSURL URLWithString: image];
            [asyncImage1 loadImageFromURL:url1];
            [viewTopBanner2 addSubview:asyncImage1];
            
            strTopBanner2 = [url retain];
        }
    }
    
    
    NSArray *bottom_banners = (NSArray *)[results objectForKey:@"bottom_banners"];
    for (int i=0; i<[bottom_banners count]; i++) {
        NSDictionary *dicCampos = (NSDictionary *)[bottom_banners objectAtIndex:i];
        NSString *idr = (NSString *)[dicCampos objectForKey:@"id"];
        NSString *image = (NSString *)[dicCampos objectForKey:@"image"];
        NSString *url = (NSString *)[dicCampos objectForKey:@"value"];
        NSString *type = (NSString *)[dicCampos objectForKey:@"type"];
        
        
        Promocion *promo;
        PromocionGrande2 *pController;
        
        promo = [[Promocion alloc] init];
        promo.idr = idr;
        promo.imagen = image;
        promo.url = url;
        promo.tipo = type;
        
        pController = [[PromocionGrande2 alloc] initWithNibName:@"PromocionGrande2" bundle:[NSBundle mainBundle]];
        pController.promocion = promo;
        pController.delegate=self;
        pController.view.frame = CGRectMake(intLeft, 0, 320, 206);
        intLeft = intLeft + 320;
        [sViewPromociones addSubview:pController.view];
        intTotal++;
        
    }
    
    
    paginacion.numberOfPages = intTotal;
    
    sViewPromociones.delegate = self;
    paginacion.currentPage=0;
    
    
    [sViewPromociones setContentSize:CGSizeMake(intLeft, 206)];
    
    [sView setContentSize:CGSizeMake(320, 530)];
    
    intActual = 1;
    
    if (intTotal>0) {
        [timer invalidate];
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(Avanza)
                                       userInfo:nil
                                        repeats:YES];
    }    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    

}


-(void)Avanza{
    
    
    if (intActual<intTotal) {
        intActual++;
    } else {
        intActual = 1;
    }
    [sViewPromociones scrollRectToVisible:CGRectMake((intActual-1)*320, 0, 320, 206) animated:YES];


}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
