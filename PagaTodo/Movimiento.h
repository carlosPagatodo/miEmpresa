//
//  Movimiento.h
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 28/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movimiento : NSObject {
    NSString *titulo;
    NSString *saldo;
    NSString *monto;
    NSString *imagen;
    NSString *fecha;
    NSString *idr;
    NSString *descripcion;
    NSString *ticket;

}
@property (nonatomic, retain) NSString *titulo;
@property (nonatomic, retain) NSString *saldo;
@property (nonatomic, retain) NSString *monto;
@property (nonatomic, retain) NSString *imagen;
@property (nonatomic, retain) NSString *fecha;
@property (nonatomic, retain) NSString *idr;
@property (nonatomic, retain) NSString *descripcion;
@property (nonatomic, retain) NSString *ticket;

-(id) init;

@end
