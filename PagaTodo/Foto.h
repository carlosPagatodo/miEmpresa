//
//  Foto.h
//  SouthAfrica-Fan
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 02/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Foto : NSObject {
	NSString *foto_idr;
	NSString *foto_url;
	NSString *foto_evento;
	NSString *foto_desc;
	NSString *foto_partido;
	NSString *foto_fecha;
	NSString *foto_tipo;	
	NSString *foto_thumb;	
}
@property (nonatomic, copy) NSString *foto_idr;
@property (nonatomic, copy) NSString *foto_url;
@property (nonatomic, copy) NSString *foto_evento;
@property (nonatomic, copy) NSString *foto_desc;
@property (nonatomic, copy) NSString *foto_partido;
@property (nonatomic, copy) NSString *foto_fecha;
@property (nonatomic, copy) NSString *foto_tipo;
@property (nonatomic, copy) NSString *foto_thumb;

-(id) initWithID:(NSString *)idr;

@end
