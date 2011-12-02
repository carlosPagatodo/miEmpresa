//
//  Categoria.m
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 14/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Categoria.h"


@implementation Categoria

@synthesize idr;
@synthesize imagen;
@synthesize titulo;
@synthesize total;
@synthesize price;
@synthesize price_with_discount;
@synthesize descripcion;
@synthesize disponible;
@synthesize colores;
@synthesize final;
@synthesize link;


-(id) init{
    self.idr=@"";
    self.imagen=@"";
    self.titulo=@"";
    self.total=@"";
    self.price = @"";
    self.price_with_discount = @"";
    self.descripcion = @"";
    self.disponible = @"";
    self.colores = @"";
    self.final = @"";
    self.link = @"";
    return  self;
    
}



@end
