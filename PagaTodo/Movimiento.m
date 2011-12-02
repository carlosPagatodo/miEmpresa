//
//  Movimiento.m
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 28/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Movimiento.h"

@implementation Movimiento

@synthesize titulo;
@synthesize saldo;
@synthesize monto;
@synthesize imagen;
@synthesize fecha;
@synthesize descripcion;
@synthesize idr;
@synthesize ticket;

- (id)init
{
    self = [super init];
    if (self) {
        self.titulo=@"";
        self.saldo=@"";
        self.monto=@"";
        self.imagen=@"";
        self.fecha=@"";
        self.idr=@"";
        self.descripcion=@"";
        self.ticket=@"";
    }
    
    return self;
}

@end
