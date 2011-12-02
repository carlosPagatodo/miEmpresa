//
//  MonederoRenglon.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 20/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MonederoRenglon.h"

@implementation MonederoRenglon

@synthesize lblNumero;
@synthesize lblSaldo;
@synthesize viewCodigo;
@synthesize strTarjeta;
@synthesize delegate;
@synthesize lblFecha;
@synthesize strDigito;

-(IBAction)Movimientos:(id)sender{
    [self.delegate VerMovimientos:self];
}

-(IBAction)Saldo:(id)sender{

    
    
    NSString *strURL;
    strURL = @"http://dextramedia.com/middleware/liverpool/balance";
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *strResultado;
    if (   [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] ValidaConexion2]==NO) {
        strResultado = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getURLCache:strURL];
    } else {
        NSURL *url = [[NSURL alloc] initWithString:strURL];
        strResultado = [NSString stringWithContentsOfURL:url encoding:NSISOLatin1StringEncoding error:nil];
    }

    
   // NSLog(strResultado);
    
    SBJSON *jsonParser = [SBJSON new];
    
    
	NSDictionary *results = (NSDictionary *)[jsonParser objectWithString:strResultado error:NULL];
    
    lblSaldo.text = [NSString  stringWithFormat:@"%@",[results objectForKey:@"balance"]];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd/MMM/yyyy HH:mm"];
    NSString *strFecha = [format stringFromDate:[[NSDate alloc] init]];

    lblFecha.text = strFecha;
    
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
    lblFecha.text = @"";
    
    NKDEAN13Barcode *barcode = [[[NKDEAN13Barcode alloc] initWithContent:strTarjeta printsCaption:NO] autorelease];
    [barcode setCaptionHeight:0.05]; // fix for barcode library caption bug
    
    //;
    const char cstyleString = [barcode checkDigit];
    strDigito= [ NSString stringWithFormat:@"%c",cstyleString ] ;

    //strDigito = [[NSString stringWithFormat:@"%@",[barcode checkDigit] ] retain];;
    
    UIImage *image = [UIImage imageFromBarcode:barcode];
    UIImageView *imgBC = [[UIImageView alloc] initWithFrame:viewCodigo.bounds];
    imgBC.image = image;
    [viewCodigo addSubview:imgBC];

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
