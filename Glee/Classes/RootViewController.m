//
//  RootViewController.m
//  Velveeta
//
//  Created by Alexei Rudak on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "HTPViewController.h"
#import "GameSetupViewController.h"
#import "CatchPhraseGame.h"
#import "VSUtils.h"

@implementation RootViewController

#pragma mark -
#pragma mark View lifecycle

-(IBAction) showRateScreen
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=547805285&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id547805285"]];
    
    [CatchPhraseGame sharedInstance].reviewed = YES;
    [[CatchPhraseGame sharedInstance] saveUserProperties];
    
}

-(IBAction) showHTPController
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    NSString *nibName = [VSUtils isIPad] ? @"HTPViewControllerIPad":@"HTPViewController";
	
	HTPViewController *gameViewController = [[HTPViewController alloc] initWithNibName:nibName bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:gameViewController animated:NO];
	[gameViewController release];
}

-(IBAction) showGameSetupController
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    
    [[CatchPhraseGame sharedInstance] initGame];
    
    NSString *nibName = [VSUtils isIPad] ? @"GameSetupViewControllerIPad":@"GameSetupViewController";
	
	GameSetupViewController *gameViewController = [[GameSetupViewController alloc] initWithNibName:nibName bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:gameViewController animated:NO];
	[gameViewController release];
}

-(IBAction) showFacebook
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/home.php#!/pages/Tidbit-Trivia/176036872458113"]]; 
}

-(IBAction) showOtherGames
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.brainricegames.com/products"]]; 	
}

- (void)viewDidLoad {
    [super viewDidLoad];

	//[[SexCityGame sharedInstance] startGlobalTimer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc {
    [super dealloc];
}


@end

