//
//  PagaTodoAppDelegate.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 26/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PagaTodoAppDelegate.h"
#import "DetalleProducto.h"

@implementation PagaTodoAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize locationManager;
@synthesize lblActividad;
@synthesize progressView;
@synthesize strAvance;
@synthesize strAvanceLabel;
@synthesize viewPensando;
@synthesize activityView;
@synthesize strListaId;
@synthesize detalleProducto;
@synthesize imgBarcode;
@synthesize strNIP;
@synthesize webAnalytics;

bool blnMensajeAbierto = NO;
int intPensando = 0;

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[detalleProducto facebook] handleOpenURL:url];
}

-(int)MaxLista{
    int maximo=0;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Lista" inManagedObjectContext:context];
    [request setEntity:entity];
    
    // Specify that the request should return dictionaries.
    [request setResultType:NSDictionaryResultType];
    
    // Create an expression for the key path.
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"Id"];
    
    // Create an expression to represent the minimum value at the key path 'creationDate'
    NSExpression *maxExpression = [NSExpression expressionForFunction:@"max:" arguments:[NSArray arrayWithObject:keyPathExpression]];
    
    // Create an expression description using the minExpression and returning a date.
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    
    // The name is the key that will be used in the dictionary for the return value.
    [expressionDescription setName:@"maxCons"];
    [expressionDescription setExpression:maxExpression];
    [expressionDescription setExpressionResultType:NSDecimalAttributeType];
    
    // Set the request's properties to fetch just the property represented by the expressions.
    [request setPropertiesToFetch:[NSArray arrayWithObject:expressionDescription]];
    
    // Execute the fetch.
    NSError *error = nil;
    NSArray *objects = [managedObjectContext executeFetchRequest:request error:&error];
    if (objects == nil) {
        // Handle the error.
    }
    else {
        if ([objects count] > 0) {
            //NSLog(@"Maxima Actualizacion: %@", [[objects objectAtIndex:0] valueForKey:@"maxCons"]);
            NSString *strMaximo = [NSString stringWithFormat:@"%@", [[objects objectAtIndex:0] valueForKey:@"maxCons"]];
            maximo=[strMaximo intValue];
        }
    }
    
    [expressionDescription release];
    [request release];
    
    return maximo;
}

- (void)insertCatalogo:(NSString *)strCatalogo conCampos:(NSDictionary *)dicCampos{
	NSManagedObjectContext *context = [self managedObjectContext];
	NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:strCatalogo inManagedObjectContext:context];
    
	// If appropriate, configure the new managed object.
    NSArray *arrKeys = [dicCampos allKeys];
    for (int i=0; i<[arrKeys count]; i++) {
        NSString *strKey = (NSString *)[arrKeys objectAtIndex:i];
        if ([strKey isEqualToString:@"version"]) {
            NSString *strValor = [NSString stringWithFormat:@"%@",[dicCampos objectForKey:strKey]];
            [newManagedObject setValue:[NSNumber numberWithInt:[strValor intValue]] forKey:strKey];
        } else if ([strKey isEqualToString:@"Cons"]) {
            NSString *strValor = [NSString stringWithFormat:@"%@",[dicCampos objectForKey:strKey]];
            [newManagedObject setValue:[NSNumber numberWithInt:[strValor intValue]] forKey:strKey];
        } else {
            [newManagedObject setValue:[NSString stringWithFormat:@"%@",[dicCampos objectForKey:strKey]]  forKey:strKey];
        }
    }
    
	// Save the context.
	NSError *error = nil;
	if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
	}
}

- (void)deleteCatalogo:(NSString *)strCatalogo conPredicado:(NSString *)strPredicado{
    NSManagedObjectContext *context = [self managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:strCatalogo inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
    NSDictionary *dicCampos =[entity attributesByName];
    NSArray *arrKeys = [dicCampos allKeys];
    NSString *strKey = (NSString *)[arrKeys objectAtIndex:0];
    
    
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:strKey ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
    if ([strPredicado length]>0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:strPredicado];
        [fetchRequest setPredicate:predicate];
    }
	
	
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
	
	NSError *error = nil;
	if (![aFetchedResultsController performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
	}
	
	NSArray *items = [aFetchedResultsController fetchedObjects];
	int intTotal = [items count];
	
	for (int i=intTotal-1; i>=0; i--) {
		NSManagedObject *managedObject = [items objectAtIndex:i];
        [context deleteObject:managedObject];
	}
	
	error = nil;
	if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
	}
	
	//[aFetchedResultsController release];
	//[fetchRequest release];
	//[sortDescriptor release];
	//[sortDescriptors release];
	//[context release];
	
    
}

- (NSMutableArray *)getRegistros:(NSString *)strCatalogo conPredicado:(NSString *)strPredicado conOrden:(NSString *)strOrden{
    
    NSMutableArray *arrRegreso = [[NSMutableArray alloc] init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:strCatalogo inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Edit the sort key as appropriate.
    if ([strOrden length]>0) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:strOrden ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
    } else {
        NSDictionary *dicCampos =[entity attributesByName];
        NSArray *arrKeys = [dicCampos allKeys];
        NSString *strKey = (NSString *)[arrKeys objectAtIndex:0];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:strKey ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
    
    if ([strPredicado length]>0 ) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:strPredicado];
        [fetchRequest setPredicate:predicate];
    }
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //abort();
    }
    
    NSArray *items = [aFetchedResultsController fetchedObjects];
    for (int i=0; i<[items count]; i++) {
        
        NSDictionary *dicCampos =[entity attributesByName];
        NSArray *arrKeys = [dicCampos allKeys];
        
        NSManagedObject *managedObject = [items objectAtIndex:i];
        
        NSMutableDictionary *registro = [[NSMutableDictionary alloc] init];
        for (int j=0; j<[arrKeys count]; j++) {
            NSString *strKey = (NSString *)[arrKeys objectAtIndex:j];
            NSString *strValor = [managedObject valueForKey:strKey];
            
            [registro setObject:[NSString stringWithFormat:@"%@",strValor] forKey:strKey];
        }
        
        [arrRegreso addObject:registro];
        
    }
    
    return arrRegreso;	
}

- (NSDictionary *)getRegistro:(NSString *)strCatalogo conPredicado:(NSString *)strPredicado{
    NSMutableDictionary *registro = [[NSMutableDictionary alloc] init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:strCatalogo inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Edit the sort key as appropriate.
    NSDictionary *dicCampos =[entity attributesByName];
    NSArray *arrKeys = [dicCampos allKeys];
    NSString *strKey = (NSString *)[arrKeys objectAtIndex:0];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:strKey ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    if ([strPredicado length]>0 ) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:strPredicado];
        [fetchRequest setPredicate:predicate];
    }
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //abort();
    }
    
    NSArray *items = [aFetchedResultsController fetchedObjects];
    for (int i=0; i<[items count]; i++) {
        
        NSDictionary *dicCampos =[entity attributesByName];
        NSArray *arrKeys = [dicCampos allKeys];
        
        NSManagedObject *managedObject = [items objectAtIndex:i];
        
        for (int j=0; j<[arrKeys count]; j++) {
            NSString *strKey = (NSString *)[arrKeys objectAtIndex:j];
            NSString *strValor = [managedObject valueForKey:strKey];
            
            [registro setObject:[NSString stringWithFormat:@"%@",strValor] forKey:strKey];
        }
        break;
        
    }
    
    return registro;	
}


- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
	//const void *devTokenBytes = [devToken bytes];
	//    self.registered = YES;
	//NSLog(@"deviceToken: %@", devToken);
	//NSString *deviceType = [UIDevice currentDevice].model;
    

    
	NSString *strToken = [NSString stringWithFormat:@"%@", devToken];
	
	strToken = [strToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
	strToken = [strToken stringByReplacingOccurrencesOfString:@">" withString:@""];
	strToken = [strToken stringByReplacingOccurrencesOfString:@" " withString:@""];
	
	//NSLog([[UIDevice currentDevice] uniqueIdentifier]);
	NSString *strTokenURL = [NSString stringWithFormat:@"http://dextramedia.com/middleware/liverpool/registerDevice/"];
    
    
    NSString *udid = [[UIDevice currentDevice] uniqueIdentifier];
    NSString *modelo = [UIDevice currentDevice].model;
    NSString *os = [[UIDevice currentDevice] systemVersion];
    NSString *version_app = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    NSString *token_notification = strToken;
    
    
    
   // NSLog(strTokenURL);
	//strTokenURL = [strTokenURL  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	//NSURL *url = [[NSURL alloc] initWithString:strTokenURL];
	//NSString *strResultado = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:strTokenURL]];
    [request setHTTPMethod:@"POST"];

    NSString *postString = [NSString stringWithFormat: @"udid=%@&modelo=%@&os=%@&version_app=%@&token_notification=%@" , udid, modelo, os, version_app, token_notification];
    NSData *postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:postData];
    
    
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
   // NSLog(returnString);

    
}


-(void)CambiarAnalytics:(NSString *)strURL{
    
	NSURL *urla = [[NSURL alloc] initWithString:strURL];
	NSURLRequest *req = [[NSURLRequest alloc] initWithURL:urla];
	[webAnalytics loadRequest:req];
    
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
	NSLog(@"Error in registration. Error: %@", err);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
	
	NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
	if (!apsInfo){return;}
	if ([apsInfo count]==0){ return;}
	
	UIApplication *app = [UIApplication sharedApplication];
	app.applicationIconBadgeNumber = 0;//[[apsInfo objectForKey:@"badge"] integerValue];;
	
	UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
	[dialog setDelegate:self];
	[dialog setTitle:@"Mensaje"];
	[dialog setMessage:[[apsInfo objectForKey:@"alert"] objectForKey:@"loc-key"] ];
	[dialog addButtonWithTitle:@"OK"];
	[dialog show];
	[dialog release];	
	
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    

    webAnalytics = [[UIWebView alloc] init];

    
    locationManager = [[CLLocationManager alloc] init];
	[locationManager startUpdatingLocation];

    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
	application.applicationIconBadgeNumber = 0;
    
    imgBarcode = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    imgBarcode.image = [UIImage imageNamed:@"barcodelayer.png"];
    imgBarcode.hidden=YES;
	[self.window addSubview:imgBarcode];

    UILabel *lblPensando = [[UILabel alloc] initWithFrame:CGRectMake(89, 250, 142, 20)];
	lblPensando.text = @"Descargando";
	lblPensando.textAlignment=UITextAlignmentCenter;
	lblPensando.textColor = [UIColor whiteColor];
	UIFont *myFont = [UIFont boldSystemFontOfSize:16];
	lblPensando.font = myFont;	
	lblPensando.numberOfLines = 1;
	lblPensando.backgroundColor = [UIColor clearColor];
	//ProgressView no se usa
    progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 34, 270, 16)];
    [progressView setProgressViewStyle: UIProgressViewStyleDefault];
	[progressView setProgress:0];
	progressView.hidden=YES;
	viewPensando = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	//[viewPensando setBackgroundColor:[UIColor colorWithRed:((float) 0 / 255.0f) green:((float) 0 / 255.0f) blue:((float) 0 / 255.0f) alpha:0.70]];
	[viewPensando setBackgroundColor:[UIColor clearColor]];
    UIImageView *imgFondo = [[UIImageView alloc] initWithFrame:CGRectMake(89, 179, 142, 122)];
    imgFondo.image = [UIImage imageNamed:@"reloj.png"];
    activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(144, 200, 32, 32)];
	activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	[activityView startAnimating];
	//[viewPensando addSubview:progressView];
	//[viewPensando addSubview:lblActividad];
	[viewPensando addSubview:imgFondo];
	[viewPensando addSubview:lblPensando];
	[viewPensando addSubview:activityView];
	
	viewPensando.hidden=YES;
	[self.window addSubview:viewPensando];

    return YES;
}

-(void)Pensando{
	[self performSelectorOnMainThread:@selector(PensandoMain) withObject:nil waitUntilDone:false];
}

-(void)NoPensando{
	[self performSelectorOnMainThread:@selector(NoPensandoMain) withObject:nil waitUntilDone:false];
}

-(void)PensandoBack{
	//NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    //id object = [NSNumber numberWithInt:1];
	[self performSelectorInBackground:@selector(PensandoMain) withObject:nil];
	
	//[pool drain];
}

-(void)NoPensandoBack{
	//NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	// id object = [NSNumber numberWithInt:1];
    
	[self performSelectorInBackground:@selector(NoPensandoMain) withObject:nil];
	//[pool drain];
}

-(void)PensandoMain{
    
	UIApplication* app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = YES;
	
	viewPensando.hidden=NO;
	progressView.hidden=YES;
	lblActividad.hidden=YES;
	lblActividad.text=@"";
	[progressView setProgress:0];
	
	
}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex{
	blnMensajeAbierto=NO;
}


-(bool)ValidaConexion{
	
	//NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
	/*[self PensandoBack];
	 NSURL *url = [[NSURL alloc] initWithString:@"http://www.smartthinking.com.mx/clientes/mercadoi/validacion.txt"];
	 NSString *strValidacion = [[NSString alloc] initWithContentsOfURL:url];
	 
	 if ([strValidacion isEqualToString:@"0"]) {
	 UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
	 [dialog setDelegate:self];
	 [dialog setTitle:@"Mercadoi"];
	 [dialog setMessage:@"Lo sentimos Esta aplicación está temporalmente en mantenimiento. Reintente más tarde."];
	 [dialog addButtonWithTitle:@"OK"];
	 [dialog show];
	 [dialog release];	
	 return NO;
	 }
	 [self NoPensandoBack];
	 */
	
	bool blnOK = NO;
	Reachability *reach = [[Reachability alloc] init];
	
	//[[Reachability sharedReachability] setHostName:@"www.southafrica-fan.com"];
	NetworkStatus remoteHostStatus  = [reach internetConnectionStatus];//[[Reachability sharedReachability] remoteHostStatus];
	if (remoteHostStatus == NotReachable) {
		if (blnMensajeAbierto==NO){
			blnMensajeAbierto=YES;
			UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
			[dialog setDelegate:self];
			[dialog setTitle:@"Sin conexión"];
			[dialog setMessage:@"No se ha logrado una conexión correcta a intenet. Por favor reintente."];
			[dialog addButtonWithTitle:@"OK"];
			[dialog show];
			[dialog release];	
		}
	}  else {
		blnOK=YES;
	}
	[reach release];
	//[pool drain];
	return blnOK;
}

-(NSString *)getURLCache:(NSString *)strURL{
    
    [self deleteCache];
    NSString *strResultado;

    strResultado = [self getURL:strURL];
    if ([strResultado length]==0) {
        [self PensandoBack];

        if ([self ValidaConexion]) {
            NSURL *url = [[NSURL alloc] initWithString:strURL];
            strResultado = [NSString stringWithContentsOfURL:url encoding:NSISOLatin1StringEncoding error:nil];
            if ([strResultado length]>0) {
                [self insertURL:strURL conResult:strResultado];
            }
        } 
        
        [self NoPensandoBack];

    }
    
    return strResultado;
}

- (void)insertURL:(NSString *)strURL conResult:(NSString *)strResultado{
    if ([strResultado length]==0) {
        return;
    }
    [self deleteURL:strURL];
    
	NSManagedObjectContext *context = [self managedObjectContext];
	NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"URL" inManagedObjectContext:context];
	
	// If appropriate, configure the new managed object.
	[newManagedObject setValue:strURL  forKey:@"url"];
	[newManagedObject setValue:strResultado  forKey:@"result"];
    NSDate *now = [[NSDate alloc] init];
	[newManagedObject setValue:now  forKey:@"fecha"];
    
	// Save the context.
	NSError *error = nil;
	if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
	}
}

- (void)deleteURL:(NSString *)strURL{
    NSManagedObjectContext *context = [self managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"URL" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"url" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url =%@",strURL];
    [fetchRequest setPredicate:predicate];
	
	NSError *error = nil;
	if (![aFetchedResultsController performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
	}
	
	NSArray *items = [aFetchedResultsController fetchedObjects];
	int intTotal = [items count];
	
	for (int i=intTotal-1; i>=0; i--) {
		NSManagedObject *managedObject = [items objectAtIndex:i];
		[context deleteObject:managedObject];
	}
	
	error = nil;
	if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
	}
}

- (void)deleteCache{
    NSManagedObjectContext *context = [self managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"URL" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"url" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    NSDate *today = [[NSDate alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:-1]; // note that I'm setting it to -1
    NSDate *ayer = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];

    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fecha <=%@",ayer];
    [fetchRequest setPredicate:predicate];
	
	NSError *error = nil;
	if (![aFetchedResultsController performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
	}
	
	NSArray *items = [aFetchedResultsController fetchedObjects];
	int intTotal = [items count];
	
	for (int i=intTotal-1; i>=0; i--) {
		NSManagedObject *managedObject = [items objectAtIndex:i];
		[context deleteObject:managedObject];
	}
	
	error = nil;
	if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
	}
}


- (NSString *)getURL:(NSString *)strURL{
    NSString *strResult = @"";
	NSManagedObjectContext *context = [self managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"URL" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"url" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url =%@",strURL];
    [fetchRequest setPredicate:predicate];
    
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
	
	NSError *error = nil;
	if (![aFetchedResultsController performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
	}
	
	NSArray *items = [aFetchedResultsController fetchedObjects];
	for (int i=0; i<[items count]; i++) {
        NSManagedObject *managedObject = [items objectAtIndex:i];
		strResult = [managedObject valueForKey:@"result"];
	}
	
	return strResult;	
}


-(bool)ValidaConexion2{
	
	//NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
	/*[self PensandoBack];
	 NSURL *url = [[NSURL alloc] initWithString:@"http://www.smartthinking.com.mx/clientes/mercadoi/validacion.txt"];
	 NSString *strValidacion = [[NSString alloc] initWithContentsOfURL:url];
	 
	 if ([strValidacion isEqualToString:@"0"]) {
	 UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
	 [dialog setDelegate:self];
	 [dialog setTitle:@"Mercadoi"];
	 [dialog setMessage:@"Lo sentimos Esta aplicación está temporalmente en mantenimiento. Reintente más tarde."];
	 [dialog addButtonWithTitle:@"OK"];
	 [dialog show];
	 [dialog release];	
	 return NO;
	 }
	 [self NoPensandoBack];
	 */
	
	bool blnOK = NO;
	Reachability *reach = [[Reachability alloc] init];
	
	//[[Reachability sharedReachability] setHostName:@"www.southafrica-fan.com"];
	NetworkStatus remoteHostStatus  = [reach internetConnectionStatus];//[[Reachability sharedReachability] remoteHostStatus];
	if (remoteHostStatus == NotReachable) {
	}  else {
		blnOK=YES;
	}
	[reach release];
	//[pool drain];
	return blnOK;
}


-(void)NoPensandoMain{
	
	UIApplication* app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = NO;
	viewPensando.hidden=YES;
	
	
}


-(void)Progreso{
	float avance = [strAvance floatValue];
	int avanceporcentaje = avance*100;
	strAvanceLabel = [[NSString stringWithFormat:@"%i",avanceporcentaje]stringByAppendingString:@"%"];
	[self performSelectorOnMainThread:@selector(ProgresoMain) withObject:nil waitUntilDone:false];
}

-(void)ProgresoBack{
	float avance = [strAvance floatValue];
	int avanceporcentaje = avance*100;
	strAvanceLabel = [[NSString stringWithFormat:@"%i",avanceporcentaje]stringByAppendingString:@"%"];
	[self performSelectorInBackground:@selector(ProgresoMain) withObject:nil];
}

-(void)ProgresoMain{
	progressView.hidden=NO;
	lblActividad.hidden=NO;
	
	float avance = [strAvance floatValue];
	[progressView setProgress:avance];
	
	//lblActividad.text = strAvanceLabel;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    strNIP = @"";
    if (self.tabBarController.selectedIndex==4) {
        [self.tabBarController setSelectedIndex:0];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    
    [locationManager stopUpdatingLocation];
    [locationManager release];
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PagaTodo" ofType:@"momd"];
    NSURL *momURL = [NSURL fileURLWithPath:path];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
    
    //    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;

    
    //managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    //return managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
	NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"PagaTodo.xcdatamodel"]];
	
	NSError *error = nil;
    
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];

    
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
