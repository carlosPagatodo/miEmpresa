//
//  Negocio.m
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 23/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Negocio.h"


@implementation Negocio

@synthesize idr;
@synthesize nombre;
@synthesize direccion;
@synthesize colonia;
@synthesize cp;
@synthesize delegacion;
@synthesize estado;
@synthesize distancia;
@synthesize lat;
@synthesize lng;
@synthesize tel1;
@synthesize tel2;
@synthesize fax;
@synthesize mail;
@synthesize www;
@synthesize foto;
@synthesize tipo;
@synthesize horarios;

-(id) init{
	idr = @"";
	nombre = @"";
	direccion = @"";
	colonia = @"";
	cp = @"";
	delegacion = @"";
	estado = @"";
	distancia = @"";
	lat = @"";
	lng = @"";
	tel1 = @"";
	tel2 = @"";
	fax = @"";
	mail = @"";
	www = @"";
	foto = @"";
    horarios = @"";
	return self;
}

@end
