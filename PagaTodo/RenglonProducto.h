//
//  RenglonProducto.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categoria.h"
#import "AsyncImageView.h"

@protocol RenglonProductoDelegate;

@interface RenglonProducto : UIViewController{
    IBOutlet UIView *viewImagen;
    IBOutlet UILabel *lblTitulo;
    IBOutlet UILabel *lblPrecio;
    IBOutlet UILabel *lblPrecioDescuento;
    IBOutlet UILabel *imgTachado;
    IBOutlet UIButton *btnEliminar;
    Categoria *cat;
    Categoria *sub;
    Categoria *prod;
    id <RenglonProductoDelegate> delegate;
}
@property (nonatomic, retain) IBOutlet UIView *viewImagen;
@property (nonatomic, retain) IBOutlet UILabel *lblTitulo;
@property (nonatomic, retain) IBOutlet UILabel *lblPrecio;
@property (nonatomic, retain) IBOutlet UILabel *lblPrecioDescuento;
@property (nonatomic, retain) IBOutlet UILabel *imgTachado;
@property (nonatomic, retain) IBOutlet UIButton *btnEliminar;
@property (nonatomic, retain) Categoria *cat;
@property (nonatomic, retain) Categoria *sub;
@property (nonatomic, retain) Categoria *prod;
@property (nonatomic, assign) id <RenglonProductoDelegate> delegate;

-(IBAction)AbrirProducto:(id)sender;
-(IBAction)EliminarProducto:(id)sender;

@end


@protocol RenglonProductoDelegate
-(void)ProductoSelected:(RenglonProducto *)controller;
-(void)ProductoEliminado:(RenglonProducto *)controller;
@end