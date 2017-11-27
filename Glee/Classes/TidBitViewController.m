    //
//  TidBitViewController.m
//  HarryPotter
//
//  Created by Alexei Rudak on 25/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TidBitViewController.h"
#import "UIView-Expanded.h"

@implementation TidBitViewController

-(void) hideLoadingHUD
{
	//	[HUD hide:YES];
	if(HUD!=nil)
	{
		[HUD removeFromSuperview];
		[HUD release];
		HUD = nil;
	}
	
}



-(void) showLoadingHUD
{
	// The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
	if(HUD == nil)
	{
		HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
		
		//HUD.graceTime = 0.5;
		//HUD.minShowTime = 5.0;
		
		// Add HUD to screen
		[self.navigationController.view addSubview:HUD];
		
		// Regisete for HUD callbacks so we can remove it from the window at the right time
		HUD.delegate = self;
		
		// Show the HUD while the provided method executes in a new thread
		//[HUD showWhileExecuting:selector onTarget:self withObject:nil animated:YES];
		[HUD show:YES];
	}
	
}

-(void) showLoadingMessage:(NSString*) msgText
{
	UIActivityIndicatorView* indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
										   UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	
	indicator.center = CGPointMake(142, 70 );
	
	if(!modalAlertView)
	{
		modalAlertView = [[UIAlertView alloc] initWithTitle:msgText
													message:nil
												   delegate:self
										  cancelButtonTitle:nil 
										  otherButtonTitles:nil];
	}
	
	
	[modalAlertView addSubview:indicator];
	[modalAlertView show];
	
	[indicator startAnimating];
	
}

-(void) hideLoadingMessage
{
	if(modalAlertView)
	{
		[modalAlertView dismissWithClickedButtonIndex:0 animated:NO];
		[modalAlertView release];
		modalAlertView  = nil;
	}
}

-(IBAction) onBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) onHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    [self.view changeViewFont:[UIFont fontWithName:@"FranklinGothic LT Condensed" size: 18]];
    
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
