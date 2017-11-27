//
//  FinalScoreViewController.m
//  Velveeta
//
//  Created by Alexei Rudak on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FinalScoreViewController.h"
#import "CatchPhraseGame.h"
#import "Question.h"
#import "RoundStartViewController.h"
#import "VSUtils.h"

@implementation FinalScoreViewController

@synthesize lbTeam1,lbTeam2;
@synthesize lbScore1,lbScore2;
@synthesize lbWinner;
@synthesize lbFinalScoreTitle;
@synthesize victorySound;

-(IBAction) onPlayAgain
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    
	[[CatchPhraseGame sharedInstance] endGame];
	
    [self.navigationController popToViewController:
        [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[CatchPhraseGame sharedInstance] stopSoundSAE:victorySound];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    if(alertView.tag == 10)
    {
        if(buttonIndex == 0)
        {
            [CatchPhraseGame sharedInstance].reviewed = YES;
            [[CatchPhraseGame sharedInstance] saveUserProperties];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/catch-phrase-party!/id547805285?ls=1&mt=8"]]; 
        }
    }
}

-(void) showRateScreen
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you like the app? Please rate us on iTunes!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: @"No, thanks",nil];
    [alert setTag:10];
    [alert show];
    [alert release];
}

- (void)viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
    
   
    
        if(![CatchPhraseGame sharedInstance].reviewed)
        {
            [CatchPhraseGame sharedInstance].gamePlayedCount++;
            
            
            if([CatchPhraseGame sharedInstance].gamePlayedCount >= 5 && ![CatchPhraseGame sharedInstance].fifthGamePlayed)
            {
                
                
                [CatchPhraseGame sharedInstance].fifthGamePlayed = YES;
                [[CatchPhraseGame sharedInstance] saveUserProperties];
                [self showRateScreen];
                return;
            }
           
            if([CatchPhraseGame sharedInstance].fifthGamePlayed && [CatchPhraseGame sharedInstance].gamePlayedCount>0 && [CatchPhraseGame sharedInstance].gamePlayedCount%10 == 0)
            {
                
                [self showRateScreen];
            }
        }
    
}

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
    victorySound = [[CatchPhraseGame sharedInstance] playSoundSAE:@"sound_victory.mp3"];
    
    
    lbTeam1.text = [CatchPhraseGame sharedInstance].team1Name;
    lbTeam2.text = [CatchPhraseGame sharedInstance].team2Name;
    
    lbScore1.text = [NSString stringWithFormat:@"%i",[CatchPhraseGame sharedInstance].team1Score];
    
    lbScore2.text = [NSString stringWithFormat:@"%i",[CatchPhraseGame sharedInstance].team2Score];
    
    if([[CatchPhraseGame sharedInstance] getWinnerTeamName])
        lbWinner.text = [[CatchPhraseGame sharedInstance] getWinnerTeamName];
    
    
    [CatchPhraseGame sharedInstance].cumulativeGamesPlayedNumber++;
    [[CatchPhraseGame sharedInstance] saveUserProperties];
    
}

-(IBAction) backToMenu
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    [[self navigationController] popToRootViewControllerAnimated:YES];
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
