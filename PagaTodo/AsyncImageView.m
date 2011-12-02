//
//  AsyncImageView.m
//  IphoneEEEM
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 04/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AsyncImageView.h"


// This class demonstrates how the URL loading system can be used to make a UIView subclass
// that can download and display an image asynchronously so that the app doesn't block or freeze
// while the image is downloading. It works fine in a UITableView or other cases where there
// are multiple images being downloaded and displayed all at the same time. 

@implementation AsyncImageView

@synthesize viewCargando;
@synthesize activityView;
@synthesize miURL;
@synthesize strForzarNoCache;
@synthesize fetchedResultsController;
@synthesize managedObjectContext;

- (void)dealloc {
	
	[fetchedResultsController release];
	[managedObjectContext release];

	[connection cancel]; //in case the URL is still downloading
	[connection release];
	[data release]; 
    [super dealloc];
}

- (void)loadImageFromURLMain{
	[self loadImageFromURL:miURL];
}

- (void)loadImageFromURL:(NSURL*)url {
	
	@try {
		NSString *urlString = [url absoluteString];
		if ([urlString length]==0){return;}
		//UIApplication* app = [UIApplication sharedApplication];
		//app.networkActivityIndicatorVisible = YES;
		miURL = url;
		
		self.managedObjectContext = [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
		
		NSError *error = nil;
		if (![[self fetchedResultsController] performFetch:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			//abort();
		}
		//[self insertNewObject];
		//[self insertNewImage:@"http://www.estoyenelmapa.com"  conImagen:[UIImage imageNamed:@"coach2.png"]];
		
		NSArray *items = [self.fetchedResultsController fetchedObjects];
		int intTotal = [items count];
		
		if (intTotal>0){
			if ([strForzarNoCache isEqualToString:@"SI"]){
				//delete
			} else {
				NSManagedObject *managedObject = [items objectAtIndex:0];
				NSData *dataimagen= [managedObject valueForKey:@"imagenBinario"];
				//NSLog([@"encontrada:" stringByAppendingString:[managedObject valueForKey:@"imagenRuta"]]);
				UIImageView* imageView = [[[UIImageView alloc] initWithImage:[UIImage imageWithData:dataimagen]] autorelease];
				//make sizing choices based on your needs, experiment with these. maybe not all the calls below are needed.
				imageView.contentMode = UIViewContentModeScaleAspectFit;
				//imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth || UIViewAutoresizingFlexibleHeight );
				[self addSubview:imageView];
				imageView.frame = self.bounds;
				[imageView setNeedsLayout];
				[self setNeedsLayout];
				
				
				return;
			}
		}
		
		
		
		if (connection!=nil) { [connection release]; } //in case we are downloading a 2nd image
		if (data!=nil) { [data release]; }
		
		NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
		connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; //notice how delegate set to self object
		//TODO error handling, what if connection is nil?
		
		viewCargando = [[UIView alloc] initWithFrame:self.bounds];
		
		[viewCargando setBackgroundColor:[UIColor colorWithRed:((float) 250 / 255.0f) green:((float) 250 / 255.0f) blue:((float) 250 / 255.0f) alpha:0.9]];
		int left = (self.frame.size.width - 16)/2;
		if (left < 0){
			left=20;
		}
		int top = (self.frame.size.height - 16)/2;
		if (top < 0){
			top=20;
		}
		activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(left, top, 16, 16)];
		activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
		[activityView startAnimating];
		activityView.hidesWhenStopped=YES;
		[viewCargando addSubview:activityView];
		[self addSubview:viewCargando];
		
	} @catch (NSException* ex) {
		NSLog(@"error: %@",ex);
		[activityView stopAnimating];
		activityView.hidesWhenStopped=YES;

		UIApplication* app2 = [UIApplication sharedApplication];
		app2.networkActivityIndicatorVisible = NO;
		
		UIAlertView* dialogErr = [[[UIAlertView alloc] init] retain];
		[dialogErr setDelegate:self];
		[dialogErr setTitle:@"Error de conexión"];
		[dialogErr setMessage:@"No se ha logrado establecer una conexión correcta. Por favor reintente nuevamente la última operación."];
		[dialogErr addButtonWithTitle:@"OK"];
		[dialogErr show];
		[dialogErr release];			
		
	}		
}

- (void)insertNewImage:(NSString *)strRuta conImagen:(UIImage *)imgGuardar {
	
	// Create a new instance of the entity managed by the fetched results controller.
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	//NSEntityDescription *entity = [[fetchedResultsController fetchRequest] entity];
	NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Imagenes" inManagedObjectContext:context];
	NSData *imageData = UIImagePNGRepresentation(imgGuardar);
	
	// If appropriate, configure the new managed object.
	[newManagedObject setValue:strRuta forKey:@"imagenRuta"];
	[newManagedObject setValue:imageData forKey:@"imagenBinario"];
	
	// Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
}
 
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// In the simplest, most efficient, case, reload the table view.
	//[self.tableView reloadData];
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    /*
	 Set up the fetched results controller.
	 */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Imagenes" inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"imagenRuta like[c] %@",[miURL absoluteString]];
	//NSLog([miURL absoluteString]);
	[fetchRequest setPredicate:predicate];
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"imagenRuta" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];//@"Root"
    aFetchedResultsController.delegate = self;
	self.fetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	return fetchedResultsController;
}  

//the URL connection calls this repeatedly as data arrives
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	@try {
		
		if (data==nil) { data = [[NSMutableData alloc] initWithCapacity:2048]; } 
		[data appendData:incrementalData];
		
	} @catch (NSException* ex) {
		NSLog(@"error: %@",ex);
		[activityView stopAnimating];
		activityView.hidesWhenStopped=YES;

		UIApplication* app2 = [UIApplication sharedApplication];
		app2.networkActivityIndicatorVisible = NO;
		
		/* UIAlertView* dialogErr = [[[UIAlertView alloc] init] retain];
		[dialogErr setDelegate:self];
		[dialogErr setTitle:@"Error de conexión"];
		[dialogErr setMessage:@"No se ha logrado establecer una conexión correcta. Por favor reintente nuevamente la última operación."];
		[dialogErr addButtonWithTitle:@"OK"];
		[dialogErr show];
		[dialogErr release];			
		*/
	}		
}

//the URL connection calls this once all the data has downloaded
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	
	@try {
		
		//so self data now has the complete image 
		[connection release];
		connection=nil;
		if ([[self subviews] count]>0) {
			//then this must be another image, the old one is still in subviews
			[[[self subviews] objectAtIndex:0] removeFromSuperview]; //so remove it (releases it also)
		}
		
		[viewCargando removeFromSuperview];
		
		
		if ([strForzarNoCache isEqualToString:@"SI"]){
			//nada
		} else {
			[self insertNewImage:[miURL absoluteString]  conImagen:[UIImage imageWithData:data]];
		}
		
		//make an image view for the image
		UIImageView* imageView = [[[UIImageView alloc] initWithImage:[UIImage imageWithData:data]] autorelease];
		//make sizing choices based on your needs, experiment with these. maybe not all the calls below are needed.
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		//imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth || UIViewAutoresizingFlexibleHeight );
		[self addSubview:imageView];
		imageView.frame = self.bounds;
		[imageView setNeedsLayout];
		[self setNeedsLayout];
		
		[data release]; //don't need this any more, its in the UIImageView now
		data=nil;
		
	} @catch (NSException* ex) {
		NSLog(@"error: %@",ex);
		[activityView stopAnimating];
		activityView.hidesWhenStopped=YES;
	
		UIApplication* app2 = [UIApplication sharedApplication];
		app2.networkActivityIndicatorVisible = NO;
		
		UIAlertView* dialogErr = [[[UIAlertView alloc] init] retain];
		[dialogErr setDelegate:self];
		[dialogErr setTitle:@"Error de conexión"];
		[dialogErr setMessage:@"No se ha logrado establecer una conexión correcta. Por favor reintente nuevamente la última operación."];
		[dialogErr addButtonWithTitle:@"OK"];
		[dialogErr show];
		[dialogErr release];			
		
	}		
	//UIApplication* app = [UIApplication sharedApplication];
	//app.networkActivityIndicatorVisible = NO;
	
}

//just in case you want to get the image directly, here it is in subviews
- (UIImage*) image {
	UIImageView* iv = [[self subviews] objectAtIndex:0];
	return [iv image];
}

@end