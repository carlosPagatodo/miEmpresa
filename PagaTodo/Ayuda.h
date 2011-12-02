//
//  Ayuda.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagaTodoAppDelegate.h"

@interface Ayuda : UIViewController <UIWebViewDelegate>{
    IBOutlet UIWebView *web;
    NSString *strWWW;
}
@property (nonatomic, retain) IBOutlet UIWebView *web;
@property (nonatomic, retain) NSString *strWWW;

-(IBAction)Atras:(id)sender;
@end
