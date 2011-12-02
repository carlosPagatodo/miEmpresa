//
//  Felicidades.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 20/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Felicidades.h"

@implementation Felicidades

@synthesize delegate;
@synthesize viewContenido;
@synthesize sView;

@synthesize toolTeclado;
@synthesize pickerSexo;
@synthesize pickerFecha;

@synthesize txtNombre;
@synthesize txtApellidos;
@synthesize txtCorreo;

@synthesize lblFecha;
@synthesize lblSexo;
@synthesize arrSexo;

-(IBAction)Sexo:(id)sender{
    [pickerSexo setHidden:NO];
    [self AbreTeclado:nil];
}
-(IBAction)FecNac:(id)sender{
    [pickerFecha setHidden:NO];
    [self AbreTeclado:nil];
}
-(IBAction)CierraTeclado:(id)sender{
    sView.frame = CGRectMake(0, 44, 320, 416) ;
    toolTeclado.hidden=YES;
    pickerSexo.hidden=YES;
    pickerFecha.hidden=YES;
    [txtNombre resignFirstResponder];
    [txtApellidos resignFirstResponder];
    [txtCorreo resignFirstResponder];
}
-(IBAction)AbreTeclado:(id)sender{
    sView.frame = CGRectMake(0, 44, 320, 156) ;

    toolTeclado.hidden=NO;
}
-(IBAction)AceptaValor:(id)sender{

    if (pickerFecha.hidden==NO) {
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"dd/MMM/yyyy"];
        NSString *strFecha = [format stringFromDate:pickerFecha.date];

        lblFecha.text = strFecha;
    } else {
        lblSexo.text = [arrSexo objectAtIndex:[pickerSexo selectedRowInComponent:0]];
    }
    [self CierraTeclado:nil];
}

-(IBAction)Enviar:(id)sender{
    
    if (   [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] ValidaConexion]==NO) {
        return;
    }
    
    
    NSString *strURL;
    strURL = @"http://dextramedia.com/middleware/liverpool/register";
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
   // NSURL *url = [[NSURL alloc] initWithString:strURL];
    NSString *strResultado = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] getURLCache:strURL];
   // NSLog(strResultado);
    
    SBJSON *jsonParser = [SBJSON new];
    
	NSDictionary *results = (NSDictionary *)[jsonParser objectWithString:strResultado error:NULL];
    NSString *total = [NSString stringWithFormat:@"%@", [results objectForKey:@"result"]];
    NSString *barcode = [NSString stringWithFormat:@"%@", [results objectForKey:@"barcode"]];
    NSString *error_message = [NSString stringWithFormat:@"%@", [results objectForKey:@"error_message"]];


    if ([total isEqualToString:@"1"]){
        UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
        [dialog setDelegate:self];
        [dialog setTitle:@"Felicidades"];
        [dialog setMessage:[NSString stringWithFormat: @"Monedero registrado correctamente con Número: %@",barcode]];
        [dialog addButtonWithTitle:@"OK"];
        [dialog show];
        [dialog release];	
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
    [self.delegate MonederoRegistrado:barcode];
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

-(IBAction)Atras:(id)sender{
    //[self.navigationController popViewControllerAnimated:YES];
    [self.parentViewController dismissModalViewControllerAnimated:YES];
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
	return 40;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [arrSexo count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSString *strTitulo=@"";
	
	strTitulo = (NSString *)[arrSexo objectAtIndex:row];
	
	return strTitulo;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrSexo = [NSMutableArray new];
    
    [arrSexo addObject:@"Hombre"];
    [arrSexo addObject:@"Mujer"];
    
    // Do any additional setup after loading the view from its nib.
    [sView addSubview:viewContenido];
    [sView setContentSize:viewContenido.frame.size];
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
