//
//  RenglonCategoria.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 31/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categoria.h"
#import "AsyncImageView.h"

@protocol RenglonCategoriaDelegate;

@interface RenglonCategoria : UIViewController{
    IBOutlet UIView *viewImagen;
    IBOutlet UILabel *lblTitulo;
    IBOutlet UILabel *lblTotal;
    Categoria *cat;
    id <RenglonCategoriaDelegate> delegate;
}
@property (nonatomic, retain) IBOutlet UIView *viewImagen;
@property (nonatomic, retain) IBOutlet UILabel *lblTitulo;
@property (nonatomic, retain) IBOutlet UILabel *lblTotal;
@property (nonatomic, retain) Categoria *cat;
@property (nonatomic, assign) id <RenglonCategoriaDelegate> delegate;

-(IBAction)AbrirCategoria:(id)sender;

@end


@protocol RenglonCategoriaDelegate
-(void)CategoriaSelected:(RenglonCategoria *)controller;
@end