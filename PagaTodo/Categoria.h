//
//  Categoria.h
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 14/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Categoria : NSObject {
    NSString *idr;
    NSString *imagen;
    NSString *titulo;
    NSString *total;
    NSString *price;
    NSString *price_with_discount;
    NSString *descripcion;
    NSString *disponible;
    NSString *colores;
    NSString *final;
    NSString *link;
}
@property (nonatomic, retain) NSString *idr;
@property (nonatomic, retain) NSString *imagen;
@property (nonatomic, retain) NSString *titulo;
@property (nonatomic, retain) NSString *total;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *price_with_discount;
@property (nonatomic, retain) NSString *descripcion;
@property (nonatomic, retain) NSString *disponible;
@property (nonatomic, retain) NSString *colores;
@property (nonatomic, retain) NSString *final;
@property (nonatomic, retain) NSString *link;
    
-(id) init;


@end
