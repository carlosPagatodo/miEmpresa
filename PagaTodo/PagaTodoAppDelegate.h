//
//  PagaTodoAppDelegate.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 26/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Reachability.h"
#import <CoreData/CoreData.h>

@interface PagaTodoAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, NSFetchedResultsControllerDelegate> {
    CLLocationManager *locationManager;
	UILabel *lblActividad;
	UIProgressView *progressView;
	NSString *strAvance;
	NSString *strAvanceLabel;
	IBOutlet UIView *viewPensando;
	IBOutlet UIActivityIndicatorView *activityView;
    
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

    NSString *strListaId;
    id detalleProducto;
    
    UIImageView *imgBarcode;
    NSString *strNIP;
    
    UIWebView *webAnalytics;
}
@property (nonatomic, retain) id detalleProducto;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) CLLocationManager *locationManager;

@property (nonatomic, retain) UIImageView *imgBarcode;

@property (nonatomic, retain) UILabel *lblActividad;
@property (nonatomic, retain) UIProgressView *progressView;
@property (nonatomic, retain) NSString *strListaId;
@property (nonatomic, retain) NSString *strAvance;
@property (nonatomic, retain) NSString *strAvanceLabel;
@property (nonatomic, retain) IBOutlet UIView *viewPensando;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;

@property (nonatomic, retain) NSString *strNIP;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain)     UIWebView *webAnalytics;


- (void)insertCatalogo:(NSString *)strCatalogo conCampos:(NSDictionary *)dicCampos;
- (void)deleteCatalogo:(NSString *)strCatalogo conPredicado:(NSString *)strPredicado;
- (NSMutableArray *)getRegistros:(NSString *)strCatalogo conPredicado:(NSString *)strPredicado conOrden:(NSString *)strOrden;
- (id)getRegistro:(NSString *)strCatalogo conPredicado:(NSString *)strPredicado;
-(int)MaxLista;
-(void)CambiarAnalytics:(NSString *)strURL;


- (void)deleteCache;
- (void)deleteURL:(NSString *)strURL;
- (void)insertURL:(NSString *)strURL conResult:(NSString *)strResultado;
- (NSString *)getURL:(NSString *)strURL;

-(NSString *)getURLCache:(NSString*)strURL;

-(void)Pensando;
-(void)NoPensando;
-(void)PensandoMain;
-(void)NoPensandoMain;
-(void)PensandoBack;
-(void)NoPensandoBack;
-(void)Progreso;
-(void)ProgresoBack;
-(void)ProgresoMain;

-(bool)ValidaConexion;
-(bool)ValidaConexion2;
- (NSString *)applicationDocumentsDirectory;

@end
