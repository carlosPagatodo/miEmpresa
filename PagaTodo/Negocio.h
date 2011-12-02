//
//  Negocio.h
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 23/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Negocio : NSObject {
	NSString *idr;
	NSString *nombre;
	NSString *direccion;
	NSString *colonia;
	NSString *cp;
	NSString *delegacion;
	NSString *estado;
	NSString *distancia;
	NSString *lat;
	NSString *lng;
	NSString *tel1;
	NSString *tel2;
	NSString *fax;
	NSString *mail;
	NSString *www;
	NSString *foto;
	NSString *tipo;
    NSString *horarios;
}
@property (nonatomic, retain) NSString *idr;
@property (nonatomic, retain) NSString *nombre;
@property (nonatomic, retain) NSString *direccion;
@property (nonatomic, retain) NSString *colonia;
@property (nonatomic, retain) NSString *cp;
@property (nonatomic, retain) NSString *delegacion;
@property (nonatomic, retain) NSString *estado;
@property (nonatomic, retain) NSString *distancia;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lng;
@property (nonatomic, retain) NSString *tel1;
@property (nonatomic, retain) NSString *tel2;
@property (nonatomic, retain) NSString *fax;
@property (nonatomic, retain) NSString *mail;
@property (nonatomic, retain) NSString *www;
@property (nonatomic, retain) NSString *foto;
@property (nonatomic, retain) NSString *tipo;
@property (nonatomic, retain) NSString *horarios;

-(id) init;


@end
