//
//  Configuracion.h
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RenglonLista.h"
#import "Ayuda.h"
#import "TecleaCodigo.h"

@protocol ConfiguracionDelegate;

@interface Configuracion : UIViewController <RenglonListaDelegate, TecleaCodigoDelegate>{
    IBOutlet UIScrollView *sView;
    id <ConfiguracionDelegate> delegate;
}
@property (nonatomic,retain) IBOutlet UIScrollView *sView;
@property (nonatomic,assign) id <ConfiguracionDelegate> delegate;

-(IBAction)Atras:(id)sender;
@end

@protocol ConfiguracionDelegate
-(void)MonederoEliminado;
@end