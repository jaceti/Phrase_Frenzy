//
//  FinalScoreViewController.m
//  Velveeta
//
//  Created by Alexei Rudak on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EndRoundViewController.h"
#import "FinalScoreViewController.h"
#import "CatchPhraseGame.h"
#import "Question.h"
#import "RoundStartViewController.h"
#import "VSUtils.h"

@implementation EndRoundViewController

@synthesize btContinue,teamSelected,guessSelected;
@synthesize btTeam1,btTeam2,lbQuestion,btYes,btNo;
@synthesize imTimeUp;
@synthesize team1Sel;
@synthesize team2Sel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    // never do this stuff in production code

    // make sure you didn't fat finger Xib name
    if (nibNameOrNil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:nibNameOrNil ofType:@"nib"];
        NSAssert(path, @"Nib %@ does not exist", nibNameOrNil);
    }
    
    // make sure there's no problems with the Xib
    UINib *nib = [UINib nibWithNibName:nibNameOrNil bundle:nibBundleOrNil ];
    NSArray *instantiatedObjects = [nib instantiateWithOwner:nil options:nil];
    NSAssert(instantiatedObjects && [instantiatedObjects count] > 0, @"Not well formed Xib");
       return self;
}


-(void) checkForSelectedButtons
{
    if(teamSelected && guessSelected)
        btContinue.enabled = YES;
}

-(IBAction) onTeam1
{
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

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
    teamSelected = guessSelected = NO;
    btContinue.enabled = NO;
    
    team1Sel = team2Sel = NO;
    
    lbQuestion.text = [CatchPhraseGame sharedInstance].currentQuestion.text;
    
    [btTeam1 setTitle:[CatchPhraseGame sharedInstance].team1Name forState:UIControlStateNormal];
    [btTeam2 setTitle:[CatchPhraseGame sharedInstance].team2Name forState:UIControlStateNormal];
    
    
    if(![imTimeUp superview])
        [self.view addSubview:imTimeUp];
    
    [self performSelector:@selector(part1) withObject:nil afterDelay:1.0f];
    
    
    
    
    //[self startInfoImageAnimation:2 inView:self.view];
}

-(IBAction) backToMenu
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
	[[CatchPhraseGame sharedInstance] endGame];
	[self.navigationController popToRootViewControllerAnimated:NO];
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
