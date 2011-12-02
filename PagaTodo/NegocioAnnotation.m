#import "NegocioAnnotation.h"
#import <MapKit/MapKit.h>


@implementation NegocioAnnotation

@synthesize coordinate;
@synthesize currentTitle;
@synthesize currentSubTitle;
@synthesize neg;


- (NSString *)subtitle{
	return currentSubTitle;
}

- (NSString *)title{
	//	NSLog(@"currenttitle: %@",currentTitle);
	return currentTitle;//  @"Marker Annotation";
}


-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	
	//NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

@end