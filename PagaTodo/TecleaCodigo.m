//
//  TecleaCodigo.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TecleaCodigo.h"

@implementation TecleaCodigo

@synthesize txtSaldo;
@synthesize delegate;
@synthesize lblLabel;
@synthesize strFuncion;

@synthesize imgNIP1;
@synthesize imgNIP2;
@synthesize imgNIP3;
@synthesize imgNIP4;
@synthesize txtNIP1;
@synthesize txtNIP2;
@synthesize txtNIP3;
@synthesize txtNIP4;

@synthesize strNIP1;
@synthesize strNIP2;
@synthesize strNIP3;
@synthesize strNIP4;

NSString *strNIPNuevo;


-(IBAction)Aceptar:(id)sender{
    
    
    
    if ([strFuncion length]==0) {
        if ([txtSaldo.text length]==0) {
            
            UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
            [dialog setDelegate:self];
            [dialog setTitle:@"Alerta"];
            [dialog setMessage:@"Debe ingresar un número válido."];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];	
            
            return;
            
        }
    } else {
        if ([strNIP1 length]==0) {
            
            UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
            [dialog setDelegate:self];
            [dialog setTitle:@"Alerta"];
            [dialog setMessage:@"Debe ingresar un número válido."];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];	
            
            return;
            
        }
        if ([strNIP2 length]==0) {
            
            UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
            [dialog setDelegate:self];
            [dialog setTitle:@"Alerta"];
            [dialog setMessage:@"Debe ingresar un número válido."];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];	
            
            return;
            
        }
        if ([strNIP3 length]==0) {
            
            UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
            [dialog setDelegate:self];
            [dialog setTitle:@"Alerta"];
            [dialog setMessage:@"Debe ingresar un número válido."];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];	
            
            return;
            
        }
        if ([strNIP4 length]==0) {
            
            UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
            [dialog setDelegate:self];
            [dialog setTitle:@"Alerta"];
            [dialog setMessage:@"Debe ingresar un número válido."];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];	
            
            return;
            
        }
    }

    
    
    if ([strFuncion isEqualToString:@"ActivarNIP"]) {
        //JPGHC
        
        if ([strNIPNuevo length]==0) {
            
            NSString *strNIPConf = [NSString stringWithFormat:@"%@%@%@%@",strNIP1,strNIP2,strNIP3,strNIP4];
            strNIPConf = [strNIPConf stringByReplacingOccurrencesOfString:@"\u200B" withString:@""];

            strNIPNuevo = [strNIPConf retain];
            
            txtNIP1.text = @"\u200B";//
            txtNIP2.text = @"\u200B";
            txtNIP3.text = @"\u200B";
            txtNIP4.text = @"\u200B";
            
            strNIP1 =@"";
            strNIP2 =@"";
            strNIP3 =@"";
            strNIP4 =@"";
            
            lblLabel.text = @"Ingresa nuevamente el NIP deseado:";
            [txtNIP1 becomeFirstResponder];
            return;
            
        } else {
            
            NSString *strNIPConf = [NSString stringWithFormat:@"%@%@%@%@",strNIP1,strNIP2,strNIP3,strNIP4];
            strNIPConf = [strNIPConf stringByReplacingOccurrencesOfString:@"\u200B" withString:@""];
            
            if ([strNIPConf isEqualToString:strNIPNuevo]==NO) {
                
                strNIPNuevo = @"";
                
                txtNIP1.text = @"\u200B";//
                txtNIP2.text = @"\u200B";
                txtNIP3.text = @"\u200B";
                txtNIP4.text = @"\u200B";
                
                strNIP1 =@"";
                strNIP2 =@"";
                strNIP3 =@"";
                strNIP4 =@"";
                
                lblLabel.text = @"Ingresa el NIP que deseas (4 dígitos)";
                [txtNIP1 becomeFirstResponder];
                
                
                UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
                [dialog setDelegate:self];
                [dialog setTitle:@"Error"];
                [dialog setMessage:@"El NIP no coincide. Por favor ingrese nuevamente."];
                [dialog addButtonWithTitle:@"OK"];
                [dialog show];
                [dialog release];	
                return;

            }
        }
    }

    if ([strFuncion isEqualToString:@"NuevoNIP"]) {
        //JPGHC
        
        if ([strNIPNuevo length]==0) {
            
            NSString *strNIPConf = [NSString stringWithFormat:@"%@%@%@%@",strNIP1,strNIP2,strNIP3,strNIP4];
            strNIPConf = [strNIPConf stringByReplacingOccurrencesOfString:@"\u200B" withString:@""];
            
            strNIPNuevo = [strNIPConf retain];
            
            txtNIP1.text = @"\u200B";//
            txtNIP2.text = @"\u200B";
            txtNIP3.text = @"\u200B";
            txtNIP4.text = @"\u200B";
            
            strNIP1 =@"";
            strNIP2 =@"";
            strNIP3 =@"";
            strNIP4 =@"";
            
            lblLabel.text = @"Ingresa nuevamente el NIP deseado:";
            [txtNIP1 becomeFirstResponder];
            return;
            
        } else {
            
            NSString *strNIPConf = [NSString stringWithFormat:@"%@%@%@%@",strNIP1,strNIP2,strNIP3,strNIP4];
            strNIPConf = [strNIPConf stringByReplacingOccurrencesOfString:@"\u200B" withString:@""];
            
            if ([strNIPConf isEqualToString:strNIPNuevo]==NO) {
                
                strNIPNuevo = @"";
                
                txtNIP1.text = @"\u200B";//
                txtNIP2.text = @"\u200B";
                txtNIP3.text = @"\u200B";
                txtNIP4.text = @"\u200B";
                
                strNIP1 =@"";
                strNIP2 =@"";
                strNIP3 =@"";
                strNIP4 =@"";
                
                lblLabel.text = @"Ingresa el NIP que deseas (4 dígitos)";
                [txtNIP1 becomeFirstResponder];
                
                
                UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
                [dialog setDelegate:self];
                [dialog setTitle:@"Error"];
                [dialog setMessage:@"El NIP no coincide. Por favor ingrese nuevamente."];
                [dialog addButtonWithTitle:@"OK"];
                [dialog show];
                [dialog release];	
                return;
                
            }
        }
    }

    
    
    if ([strFuncion isEqualToString:@"CambiarNIP"]) {
        [self dismissModalViewControllerAnimated:NO];
    } else if ([strFuncion isEqualToString:@"VerificarNIP"]) {
        [self dismissModalViewControllerAnimated:NO];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
    if ([strFuncion length]==0) {
        [self AgregaSaldo:txtSaldo.text];
    } else {
        NSString *strNIP = [NSString stringWithFormat:@"%@%@%@%@",strNIP1,strNIP2,strNIP3,strNIP4];
        strNIP = [strNIP stringByReplacingOccurrencesOfString:@"\u200B" withString:@""];
        [self AgregaSaldo:strNIP];
    }
}

-(IBAction)Cancelar:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate FormularioCancelado];

}

-(void)AgregaSaldo:(NSString *)strCodigo{
    
    [self.delegate TarjetaAgregada:strCodigo];
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

-(void)viewWillAppear:(BOOL)animated{
    strNIPNuevo=@"";
    if ([strFuncion length]==0) {
        imgNIP1.hidden=YES;
        imgNIP2.hidden=YES;
        imgNIP3.hidden=YES;
        imgNIP4.hidden=YES;
        txtNIP1.hidden=YES;
        txtNIP2.hidden=YES;
        txtNIP3.hidden=YES;
        txtNIP4.hidden=YES;
        txtSaldo.hidden=NO;
        [txtSaldo becomeFirstResponder];
        
    } else  {
        
        imgNIP1.hidden=NO;
        imgNIP2.hidden=NO;
        imgNIP3.hidden=NO;
        imgNIP4.hidden=NO;
        txtNIP1.hidden=NO;
        txtNIP2.hidden=NO;
        txtNIP3.hidden=NO;
        txtNIP4.hidden=NO;
        
        txtNIP1.text = @"\u200B";//
        txtNIP2.text = @"\u200B";
        txtNIP3.text = @"\u200B";
        txtNIP4.text = @"\u200B";
        
        strNIP1 =@"";
        strNIP2 =@"";
        strNIP3 =@"";
        strNIP4 =@"";
        
        txtSaldo.hidden=YES;
        [txtNIP1 becomeFirstResponder];
        
    }
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string length]==0) {
        if (textField == txtNIP1){
            if ([txtNIP1.text isEqualToString:@"\u200B"]) {
                strNIP1 = @"";
                txtNIP1.text = @"\u200B";
                return NO;
            } else {
                strNIP1 = @"";
                txtNIP1.text = @"\u200B";
                return NO;
            }
        } else if (textField == txtNIP2) {
            if ([txtNIP2.text isEqualToString:@"\u200B"]) {
                strNIP1 = @"";
                strNIP2 = @"";
                txtNIP2.text = @"\u200B";
                txtNIP1.text = @"\u200B";
                [txtNIP1 becomeFirstResponder];
                return NO;
            } else {
                strNIP2 = @"";
                txtNIP2.text = @"\u200B";
                return NO;
            }
        } else if (textField == txtNIP3) {
            if ([txtNIP3.text isEqualToString:@"\u200B"]) {
                strNIP3 = @"";
                strNIP2 = @"";
                txtNIP3.text = @"\u200B";
                txtNIP2.text = @"\u200B";
                [txtNIP2 becomeFirstResponder];
                return NO;
            } else {
                strNIP3 = @"";
                txtNIP3.text = @"\u200B";
                return NO;
            }
        } else if (textField == txtNIP4) {
            if ([txtNIP4.text isEqualToString:@"\u200B"]) {
                strNIP4 = @"";
                strNIP3 = @"";
                txtNIP4.text = @"\u200B";
                txtNIP3.text = @"\u200B";
                [txtNIP3 becomeFirstResponder];
                return NO;
            } else {
                strNIP4 = @"";
                txtNIP4.text = @"\u200B";
                return NO;
            }
        } else {
            return YES;
        }
    }
    
    if (textField == txtNIP1){
        strNIP1 = [string retain];
        txtNIP1.text = [NSString stringWithFormat:@"\u200B%@", @"*"];
        [txtNIP2 becomeFirstResponder];
        return NO; // return NO to not change text 
    } else if (textField == txtNIP2) {
        strNIP2 = [string retain];
        txtNIP2.text = [NSString stringWithFormat:@"\u200B%@", @"*"];
        [txtNIP3 becomeFirstResponder];
        return NO; // return NO to not change text 
    } else if (textField == txtNIP3) {
        strNIP3 = [string retain];
        txtNIP3.text = [NSString stringWithFormat:@"\u200B%@", @"*"];
        [txtNIP4 becomeFirstResponder];
        return NO; // return NO to not change text 
    } else if (textField == txtNIP4) {
        strNIP4 = [string retain];
        txtNIP4.text = [NSString stringWithFormat:@"\u200B%@", @"*"];
        [txtNIP3 becomeFirstResponder];
        [txtNIP4 becomeFirstResponder];
        [self Aceptar:nil];
        return NO; // return NO to not change text 
    } else {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 4) ? NO : YES;
    }
}
/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if ([strFuncion length]==0) {
        return YES;
    }

    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 4) ? NO : YES;
}*/


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
