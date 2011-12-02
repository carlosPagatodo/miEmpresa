//
//  NegocioAnnotation.h
//  IphoneEEEM
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 06/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Negocio.h"


@interface NegocioAnnotation : NSObject <MKAnnotation>{
	
	CLLocationCoordinate2D coordinate;
	
	NSString *currentSubTitle;
	NSString *currentTitle;
	Negocio *neg;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *currentTitle;
@property (nonatomic, retain) NSString *currentSubTitle;
@property (nonatomic, retain) Negocio *neg;

- (NSString *)title;
- (NSString *)subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c;


@end