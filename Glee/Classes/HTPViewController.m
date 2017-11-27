//
//  ActorSceneViewController.m
//  Velveeta
//
//  Created by Alexei Rudak on 14/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//  ActorFilms

#import "HTPViewController.h"
#import "VSUtils.h"
#import "Question.h"
#import "CatchPhraseGame.h"
#import "UIView-Expanded.h"

@implementation HTPViewController

@synthesize scrollView;
@synthesize  lbText1,lbText2,lbText3;

- (void)viewWillAppear:(BOOL)animated 
{
	[super viewWillAppear:animated];
	
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([VSUtils isIPad])
        scrollView.contentSize = CGSizeMake(900, 2000);
    else
        scrollView.contentSize = CGSizeMake(430, 1150);
    
    /*
    [lbText1 setFont:[UIFont fontWithName: @"Rockwell" size: 12]];
    [lbText2 setFont:[UIFont fontWithName: @"Rockwell" size: 12]];
    [lbText3 setFont:[UIFont fontWithName: @"Rockwell" size: 12]];*/
     
    [self.view changeViewFontWithSize:[UIFont fontWithName: @"FranklinGothic LT Condensed" size:12]];
    
}


-(IBAction) onBack
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
	[self.navigationController popViewControllerAnimated:YES];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (void)dealloc {
    [super dealloc];
}


@end
