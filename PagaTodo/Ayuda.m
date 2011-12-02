//
//  Ayuda.m
//  PagaTodo
//
//  Created by Juan Pablo  Gonzalez Hermosillo Cires on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Ayuda.h"

@implementation Ayuda
@synthesize web;
@synthesize strWWW;

-(IBAction)Atras:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] NoPensandoBack];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
    [dialog setDelegate:self];
    [dialog setTitle:@"Aviso"];
    [dialog setMessage:@"Hubo un error en la conexión. Por favor reintente."];
    [dialog addButtonWithTitle:@"OK"];
    [dialog show];
    [dialog release];	

    [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] NoPensandoBack];

}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [(PagaTodoAppDelegate *)[[UIApplication sharedApplication] delegate] PensandoBack];
    
    // Do any additional setup after loading the view from its nib.
    NSURL *url = [[NSURL alloc] initWithString:strWWW];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    [web loadRequest:req];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
