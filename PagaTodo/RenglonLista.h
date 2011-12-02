//
//  RenglonLista.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 20/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RenglonListaDelegate;

@interface RenglonLista : UIViewController{
    IBOutlet UILabel *lblNombre;
    id <RenglonListaDelegate> delegate;
    IBOutlet UIImageView *imgFondo;
    IBOutlet UIButton *btnEliminar;
    IBOutlet UILabel *lblTotal;
    NSString *strListaId;
}
@property (nonatomic, retain) IBOutlet UILabel *lblNombre;
@property (nonatomic, retain) IBOutlet UILabel *lblTotal;
@property (nonatomic, retain) IBOutlet UIImageView *imgFondo;
@property (nonatomic, retain) IBOutlet UIButton *btnEliminar;
@property (nonatomic, retain) NSString *strListaId;
@property (nonatomic, assign) id <RenglonListaDelegate> delegate;

-(IBAction)SeleccionLista:(id)sender;
-(IBAction)EliminarLista:(id)sender;

@end

@protocol RenglonListaDelegate
-(void)ListaSeleccionada:(RenglonLista *)controller;
-(void)ListaEliminada:(RenglonLista *)controller;

@end
