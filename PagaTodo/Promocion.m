//
//  Promocion.m
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 27/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Promocion.h"


@implementation Promocion

@synthesize idr;
@synthesize imagen;
@synthesize url;
@synthesize tipo;

-(id) init{
    self.idr=@"";
    self.imagen=@"";
    self.url=@"";
    self.tipo=@"";
    return  self;
}

@end
