//
//  Promocion.h
//  Accor
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 27/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Promocion : NSObject {
    NSString *idr;
    NSString *imagen;
    NSString *url;
    NSString *tipo;
}
@property (nonatomic, retain) NSString *idr;
@property (nonatomic, retain) NSString *imagen;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *tipo;

-(id) init;


@end
