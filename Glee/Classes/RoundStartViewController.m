//
//  GameViewController.m
//  Velveeta
//
//  Created by Alexei Rudak on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RoundStartViewController.h"
#import "CatchPhraseGame.h"
#import "Question.h"
#import "ClueViewController.h"
#import "FinalScoreViewController.h"
#import "VSUtils.h"

@implementation RoundStartViewController

@synthesize scoreWarnView;
@synthesize lbTeam1Name,lbTeam2Name;
@synthesize lbScore1,lbScore2;
@synthesize lbWinScoreTitle,lbWinScore;

-(void) teamScoreUpdateAndCheckForWarn
{
    [lbScore1 setText:[NSString stringWithFormat:@"%i",[CatchPhraseGame sharedInstance].team1Score]];
    [lbScore2 setText:[NSString stringWithFormat:@"%i",[CatchPhraseGame sharedInstance].team2Score]];
    
    int t1 = [CatchPhraseGame sharedInstance].team1Score;
    int t2 = [CatchPhraseGame sharedInstance].team2Score;
    int fScore = [CatchPhraseGame sharedInstance].pointsToWin;
    
    if((t1 == fScore) || (t2 == fScore)) {
        scoreWarnView.frame = AVMakeRectWithAspectRatioInsideRect(self.view.bounds.size, self.view.bounds);
        [self.view addSubview:scoreWarnView];
    }
}


-(IBAction) onSituationYES
{
    [scoreWarnView removeFromSuperview];
    
    FinalScoreViewController *gameViewController = [[FinalScoreViewController alloc] initWithNibName:[VSUtils isIPad]?@"FinalScoreViewControllerIPad":@"FinalScoreViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:gameViewController animated:YES];
    [gameViewController release];
}

-(IBAction) onSituationNO
{
    int t1 = [CatchPhraseGame sharedInstance].team1Score;
    int t2 = [CatchPhraseGame sharedInstance].team2Score;
    int fScore = [CatchPhraseGame sharedInstance].pointsToWin;
    
    if(t1 == fScore)
        [CatchPhraseGame sharedInstance].team1Score--;
    
    if(t2 == fScore)
        [CatchPhraseGame sharedInstance].team2Score--;
    
    
    [self teamScoreUpdateAndCheckForWarn];
    
    
    [scoreWarnView removeFromSuperview];
}

-(IBAction) onTeam1Plus
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    [CatchPhraseGame sharedInstance].team1Score++;
    [self teamScoreUpdateAndCheckForWarn];
}

-(IBAction) onTeam2Plus
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    [CatchPhraseGame sharedInstance].team2Score++;
    [self teamScoreUpdateAndCheckForWarn];
}

-(IBAction) onTeam1Minus
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    [CatchPhraseGame sharedInstance].team1Score--;
    [self teamScoreUpdateAndCheckForWarn];
}

-(IBAction) onTeam2Minus
{
     [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    [CatchPhraseGame sharedInstance].team2Score--;
    [self teamScoreUpdateAndCheckForWarn];
}

-(IBAction) onGO
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    
    [[CatchPhraseGame sharedInstance] startNewGame];
    
    NSString *nibName = [VSUtils isIPad] ? @"ClueViewControllerIPad":@"ClueViewController";
	
	ClueViewController *gameViewController = [[ClueViewController alloc] initWithNibName:nibName bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:gameViewController animated:NO];
	[gameViewController release];
}

-(IBAction) onHome
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

 - (void)viewWillAppear:(BOOL)animated {
	 [super viewWillAppear:animated];
	 
     [lbTeam1Name setText:[CatchPhraseGame sharedInstance].team1Name];
     [lbTeam2Name setText:[CatchPhraseGame sharedInstance].team2Name];
     
     [self teamScoreUpdateAndCheckForWarn];
     
    [lbWinScore setText:[NSString stringWithFormat:@"%i",[CatchPhraseGame sharedInstance].pointsToWin]];
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
