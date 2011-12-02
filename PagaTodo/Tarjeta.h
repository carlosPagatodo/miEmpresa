//
//  Tarjeta.h
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 19/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Tarjeta : NSObject {
	NSString *strNumero;
	NSString *strSaldo;
	NSString *strFecha;
	NSString *strTipo;
}
@property (nonatomic, retain) NSString *strNumero;
@property (nonatomic, retain) NSString *strSaldo;
@property (nonatomic, retain) NSString *strFecha;
@property (nonatomic, retain) NSString *strTipo;

-(id) init;

@end
