//
//  EndLevelViewController.m
//  CatchPhrase
//
//  Created by testbest on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EndLevelViewController.h"
#import "FinalScoreViewController.h"
#import "CatchPhraseGame.h"
#import "Question.h"
#import "RoundStartViewController.h"
#import "VSUtils.h"

@interface EndLevelViewController ()

@end

@implementation EndLevelViewController

@synthesize btContinue,teamSelected,guessSelected;
@synthesize btTeam1,btTeam2,lbQuestion,btYes,btNo;
@synthesize imTimeUp;
@synthesize team1Sel;
@synthesize team2Sel;
@synthesize vOverlay;

-(void) checkForSelectedButtons
{
    if(teamSelected && guessSelected)
        btContinue.enabled = YES;
}

-(IBAction) onTeam1
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    teamSelected = YES;
    
    team1Sel = YES;
    team2Sel = NO;
    
    if([VSUtils isIPad])
    {
        [btTeam1 setBackgroundImage:[UIImage imageNamed:@"endround_green_team_ipad@2x.png"] forState:UIControlStateNormal];
        [btTeam2 setBackgroundImage:nil forState:UIControlStateNormal];
    }
    else 
    {
        [btTeam1 setBackgroundImage:[UIImage imageNamed:@"endround_green_team@2x.png"] forState:UIControlStateNormal];
        [btTeam2 setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
    //btTeam1.selected = YES;
    //btTeam2.selected = NO;
    
    [self checkForSelectedButtons];
}

-(IBAction) onTeam2
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    teamSelected = YES;
    
    team2Sel = YES;
    team1Sel = NO;
    
    if([VSUtils isIPad])
    {
        [btTeam1 setBackgroundImage:nil forState:UIControlStateNormal];
        [btTeam2 setBackgroundImage:[UIImage imageNamed:@"endround_green_team_ipad@2x.png"] forState:UIControlStateNormal];
    }
    else 
    {
        [btTeam1 setBackgroundImage:nil forState:UIControlStateNormal];
        [btTeam2 setBackgroundImage:[UIImage imageNamed:@"endround_green_team@2x.png"] forState:UIControlStateNormal];
    }
    
    //btTeam2.selected = YES;
    //btTeam1.selected = NO;
    
    [self checkForSelectedButtons];
}

-(IBAction) onGuessCorrect
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    guessSelected = YES;
    quessCorrect = YES;
    
    if([VSUtils isIPad])
    {
        [btNo setBackgroundImage:nil forState:UIControlStateNormal];
        [btYes setBackgroundImage:[UIImage imageNamed:@"endround_green_yesno_ipad@2x.png"] forState:UIControlStateNormal];
    }
    else 
    {
        [btNo setBackgroundImage:nil forState:UIControlStateNormal];
        [btYes setBackgroundImage:[UIImage imageNamed:@"endround_green_yesno@2x.png"] forState:UIControlStateNormal];
    }
    
    // btYes.selected = YES;
    // btNo.selected = NO;
    
    [self checkForSelectedButtons];
}

-(IBAction) onGuessFalse
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    guessSelected = YES;
    quessCorrect = NO;
    
    if([VSUtils isIPad])
    {
        [btYes setBackgroundImage:nil forState:UIControlStateNormal];
        [btNo setBackgroundImage:[UIImage imageNamed:@"endround_green_yesno_ipad@2x.png"] forState:UIControlStateNormal];
    }
    else 
    {
        [btYes setBackgroundImage:nil forState:UIControlStateNormal];
        [btNo setBackgroundImage:[UIImage imageNamed:@"endround_green_yesno@2x.png"] forState:UIControlStateNormal];
    }
    
    // btNo.selected = YES;
    //  btYes.selected = NO;
    
    [self checkForSelectedButtons];
}

-(IBAction) onContinue
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    
    if(team1Sel)
    {
        [CatchPhraseGame sharedInstance].team1Score++;
        if(quessCorrect)
            [CatchPhraseGame sharedInstance].team1Score++;
    }
    else if(team2Sel)
    {
        [CatchPhraseGame sharedInstance].team2Score++;
        if(quessCorrect)
            [CatchPhraseGame sharedInstance].team2Score++;
    }
    
    if([[CatchPhraseGame sharedInstance] isGameWon])
    {
        FinalScoreViewController *gameViewController = [[FinalScoreViewController alloc] initWithNibName:[VSUtils isIPad]?@"FinalScoreViewControllerIPad":@"FinalScoreViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:gameViewController animated:YES];
        [gameViewController release];
    }
    else
    {
        [self.navigationController popToViewController:
         [self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }
}

-(IBAction) onPlayAgain
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    [[CatchPhraseGame sharedInstance] startNewGame];
	
	RoundStartViewController *gameViewController = [[RoundStartViewController alloc] initWithNibName:[VSUtils isIPad]?@"GameViewControllerIPad":@"GameViewController" bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:gameViewController animated:YES];
	[gameViewController release];
}

-(void) part2
{
    [imTimeUp removeFromSuperview];
    
    self.view.userInteractionEnabled = YES;

}

-(void) part1
{

    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [imTimeUp setAlpha:0];
    
    [UIView commitAnimations]; 
    
    [self performSelector:@selector(part2) withObject:nil afterDelay:2.0f];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
    teamSelected = guessSelected = NO;
    btContinue.enabled = NO;
    
    team1Sel = team2Sel = NO;
    
    
    lbQuestion.text = [CatchPhraseGame sharedInstance].currentQuestion.text;
    
    //lbQuestion.text = @"mix business with pleasure";
    
    

    if([VSUtils isIPad])
    {
        if([lbQuestion.text length] >= 32)
            [lbQuestion setFont:[UIFont fontWithName:@"FranklinGothic LT Condensed" size: 50]];
        else if([lbQuestion.text length] >= 24 && [lbQuestion.text length] < 32)
            [lbQuestion setFont:[UIFont fontWithName:@"FranklinGothic LT Condensed" size: 70]];
        else if ([lbQuestion.text length] < 24)
            [lbQuestion setFont:[UIFont fontWithName:@"FranklinGothic LT Condensed" size: 90]];
    }
    else 
    {
        if([lbQuestion.text length] >= 32)
            [lbQuestion setFont:[UIFont fontWithName:@"FranklinGothic LT Condensed" size: 20]];
        else if([lbQuestion.text length] >= 24 && [lbQuestion.text length] < 32)
            [lbQuestion setFont:[UIFont fontWithName:@"FranklinGothic LT Condensed" size: 30]];
        else if ([lbQuestion.text length] < 24)
            [lbQuestion setFont:[UIFont fontWithName:@"FranklinGothic LT Condensed" size: 40]];
    }



    
    [btTeam1 setTitle:[CatchPhraseGame sharedInstance].team1Name forState:UIControlStateNormal];
    [btTeam2 setTitle:[CatchPhraseGame sharedInstance].team2Name forState:UIControlStateNormal];
    
    
    if(![imTimeUp superview])
        imTimeUp.frame = AVMakeRectWithAspectRatioInsideRect(self.view.bounds.size, self.view.bounds);
        [self.view addSubview:imTimeUp];
    
    self.view.userInteractionEnabled = NO;
    
    [self performSelector:@selector(part1) withObject:nil afterDelay:1.0f];
    
    
    
    
    
    //[self startInfoImageAnimation:2 inView:self.view];
}

-(IBAction) onPause
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    [CatchPhraseGame sharedInstance].isPause = YES;
    
    if(![resumeView superview])
        resumeView.frame = AVMakeRectWithAspectRatioInsideRect(self.view.bounds.size, self.view.bounds);
        [self.view addSubview:resumeView];
}

-(IBAction) onResume
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    [CatchPhraseGame sharedInstance].isPause = NO;
    
    if([resumeView superview])
        [resumeView removeFromSuperview];
}

-(IBAction) onCancelRound
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    [CatchPhraseGame sharedInstance].isPause = NO;
    
    [[CatchPhraseGame sharedInstance] endRound];
    
    if([resumeView superview])
        [resumeView removeFromSuperview];
    
    NSArray *array = [self.navigationController viewControllers];
    
    [self.navigationController popToViewController:[array objectAtIndex:2] animated:YES];
    
    //[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) backToMenu
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    if(![endGameView superview]) {
        endGameView.frame = AVMakeRectWithAspectRatioInsideRect(self.view.bounds.size, self.view.bounds);
        [self.view addSubview:endGameView];
    }
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

- (void)dealloc 
{
    [lbQuestion release];
    [btContinue release];
    [super dealloc];
}

@end
