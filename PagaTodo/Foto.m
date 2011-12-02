//
//  Foto.m
//  SouthAfrica-Fan
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 02/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Foto.h"


@implementation Foto

@synthesize foto_idr;
@synthesize foto_url;
@synthesize foto_evento;
@synthesize foto_desc;
@synthesize foto_partido;
@synthesize foto_fecha;
@synthesize foto_tipo;	
@synthesize foto_thumb;

-(id) initWithID:(NSString *)idr{
	self.foto_url=@"";
	self.foto_evento=@"";
	self.foto_desc=@"";
	self.foto_partido=@"";
	self.foto_fecha=@"";
	self.foto_tipo=@"";	
	self.foto_idr=idr;
	self.foto_thumb=@"";
	return self;
}


@end
