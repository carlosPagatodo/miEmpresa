//
//  TecleaCodigo.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TecleaCodigoDelegate;

@interface TecleaCodigo : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *txtSaldo;
    IBOutlet UILabel *lblLabel;
    id <TecleaCodigoDelegate> delegate;
    NSString *strFuncion;
    
    IBOutlet UIImageView *imgNIP1;
    IBOutlet UIImageView *imgNIP2;
    IBOutlet UIImageView *imgNIP3;
    IBOutlet UIImageView *imgNIP4;
    IBOutlet UITextField *txtNIP1;
    IBOutlet UITextField *txtNIP2;
    IBOutlet UITextField *txtNIP3;
    IBOutlet UITextField *txtNIP4;

    NSString *strNIP1;
    NSString *strNIP2;
    NSString *strNIP3;
    NSString *strNIP4;

    
}
@property (nonatomic, retain) IBOutlet UILabel *lblLabel;
@property (nonatomic, retain) IBOutlet UITextField *txtSaldo;
@property (nonatomic, retain) id <TecleaCodigoDelegate> delegate;
@property (nonatomic, retain) NSString *strFuncion;
@property (nonatomic, retain) IBOutlet UIImageView *imgNIP1;
@property (nonatomic, retain) IBOutlet UIImageView *imgNIP2;
@property (nonatomic, retain) IBOutlet UIImageView *imgNIP3;
@property (nonatomic, retain) IBOutlet UIImageView *imgNIP4;
@property (nonatomic, retain) IBOutlet UITextField *txtNIP1;
@property (nonatomic, retain) IBOutlet UITextField *txtNIP2;
@property (nonatomic, retain) IBOutlet UITextField *txtNIP3;
@property (nonatomic, retain) IBOutlet UITextField *txtNIP4;
@property (nonatomic, retain) NSString *strNIP1;
@property (nonatomic, retain) NSString *strNIP2;
@property (nonatomic, retain) NSString *strNIP3;
@property (nonatomic, retain) NSString *strNIP4;


-(IBAction)Aceptar:(id)sender;
-(IBAction)Cancelar:(id)sender;
-(void)AgregaSaldo:(NSString *)strCodigo;

@end

@protocol TecleaCodigoDelegate
-(void)FormularioCancelado;
-(void)TarjetaAgregada:(NSString *)strTarjeta;
@end