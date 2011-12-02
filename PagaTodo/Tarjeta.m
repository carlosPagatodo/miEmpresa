//
//  Tarjeta.m
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 19/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Tarjeta.h"


@implementation Tarjeta

@synthesize strNumero;
@synthesize strSaldo;
@synthesize strFecha;
@synthesize strTipo;

-(id) init{
	strNumero = @"";
	strSaldo = @"";
	strTipo = @"";
	strFecha = @"";
	return self;
}

@end
