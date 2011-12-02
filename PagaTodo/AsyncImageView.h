//
//  AsyncImageView.h
//  IphoneEEEM
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 04/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagaTodoAppDelegate.h"

@interface AsyncImageView : UIView <NSFetchedResultsControllerDelegate> {
	//could instead be a subclass of UIImageView instead of UIView, depending on what other features you want to 
	// to build into this class?
	
	NSURLConnection* connection; //keep a reference to the connection so we can cancel download in dealloc
	NSMutableData* data; //keep reference to the data so we can collect it as it downloads
	//but where is the UIImage reference? We keep it in self.subviews - no need to re-code what we have in the parent class
	UIView *viewCargando;
	UIActivityIndicatorView *activityView ;
	NSURL *miURL;
	
	 NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
	NSString *strForzarNoCache;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property(nonatomic,retain) NSString *strForzarNoCache;
@property(nonatomic,retain) NSURL *miURL;
@property(nonatomic,retain) UIView *viewCargando;
@property(nonatomic,retain) UIActivityIndicatorView *activityView;

- (void)loadImageFromURLMain;
- (void)loadImageFromURL:(NSURL*)url;
- (UIImage*) image;

@end