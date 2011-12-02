//
//  EstadoCuenta.m
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 28/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EstadoCuenta.h"

@implementation EstadoCuenta
@synthesize sView;

-(IBAction)Atras{
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
    // Do any additional setup after loading the view from its nib.
    NSMutableArray *arrResultados = [[NSMutableArray alloc] init];
    Movimiento *m;
   /* 
    for (int j=0; j<[arrRes count]; j++) {
        NSString *strRenglon = (NSString *)[arrRes objectAtIndex:j];
        NSArray *arrCampos = [strRenglon componentsSeparatedByString:@"@@@"];

        if ([arrCampos count]>5) {
            m = [[Movimiento alloc] init];
            m.titulo = (NSString *)[arrCampos objectAtIndex:3];
            m.fecha = (NSString *)[arrCampos objectAtIndex:0];
            NSString * strEstatus = (NSString *)[arrCampos objectAtIndex:1];
            if ([strEstatus isEqualToString:@"TR"]) {
                m.imagen = @"aceptada.png";
            } else if ([strEstatus isEqualToString:@"RC"]) {
                m.imagen = @"rechazada.png";
            } else if ([strEstatus isEqualToString:@"CR"]) {
                m.imagen = @"deposito.png";
            }
            m.monto = [NSString stringWithFormat:@"Monto: $%@", (NSString *)[arrCampos objectAtIndex:4]];
            m.saldo = [NSString stringWithFormat:@"Saldo: $%@", (NSString *)[arrCampos objectAtIndex:5]];
            [arrResultados addObject:m];
        }
    }
    
    */


    NSString *strURL = @"http://dextramedia.com/middleware/liverpool/account";
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *strResultado;
    if (   [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] ValidaConexion2]==NO) {
        strResultado = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getURLCache:strURL];
    } else {
        NSURL *url = [[NSURL alloc] initWithString:strURL];
        strResultado = [NSString stringWithContentsOfURL:url encoding:NSISOLatin1StringEncoding error:nil];
    }

    //NSLog(strResultado);
    
    SBJSON *jsonParser = [SBJSON new];
    
	NSDictionary *results = (NSDictionary *)[jsonParser objectWithString:strResultado error:NULL];
    //NSString *total = [NSString stringWithFormat:@"%@", [results objectForKey:@"total"]];
    
    NSArray *stores = (NSArray *)[results objectForKey:@"transactions"];
    
    for (int i=0; i<[stores count]; i++) {
        NSDictionary *dicCampos = (NSDictionary *)[stores objectAtIndex:i];
        
        m = [[Movimiento alloc] init];

        //nuevo neg
        m.idr = (NSString *)[dicCampos objectForKey:@"id"];
        m.titulo = (NSString *)[dicCampos objectForKey:@"business_name"];
        m.descripcion = (NSString *)[dicCampos objectForKey:@"description"];
        m.monto = (NSString *)[dicCampos objectForKey:@"charge"];
        if ([m.monto length]==0) {
            m.monto = (NSString *)[dicCampos objectForKey:@"payment"];
        }
        m.fecha = (NSString *)[dicCampos objectForKey:@"date"];
        m.ticket = (NSString *)[dicCampos objectForKey:@"ticket"];        
        [arrResultados addObject:m];
        
    }

    
    int intTop = 0;
    for (int i = 0; i<[arrResultados count]; i++) {
        
        Movimiento *m1 = (Movimiento *)[arrResultados objectAtIndex:i];
        RenglonEdoCta *r = [[RenglonEdoCta alloc] initWithNibName:@"RenglonEdoCta" bundle:[NSBundle mainBundle]];
        r.view.frame = CGRectMake(0, intTop, 320, 101);
        r.lblFecha.text = m1.fecha;
        r.lblMonto.text = m1.monto;
        r.lblNombre.text = m1.titulo;
        r.lblSaldo.text = m1.saldo;
        r.lblDescripcion.text = m1.descripcion;
        UIImageView *imagen = [[UIImageView alloc] initWithImage:[UIImage imageNamed:m1.imagen]];
        [r.viewImagen addSubview:imagen];
        
        [sView addSubview:r.view];
        [r release];
        intTop = intTop + 101;
    }
    [sView setContentSize:CGSizeMake(320, intTop)];
 

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
