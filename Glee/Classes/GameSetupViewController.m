//
//  ScenesTableViewController.m
//  Velveeta
//
//  Created by Alexei Rudak on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameSetupViewController.h"
#import "CatchPhraseGame.h"
#import "Question.h"
#import "RoundStartViewController.h"
#import "VSUtils.h"

@implementation GameSetupViewController

@synthesize txTeam1,txTeam2;
@synthesize lbPointsToWin,lbCategory,lbBuzzerSound;
@synthesize btPointsLeft,btPointsRight;
@synthesize btCategoryLeft,btCategoryRight;
@synthesize btSoundsLeft,btSoundsRight;

#define MAX_LENGTH 18

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length >= MAX_LENGTH && range.length == 0)
    {
        return NO; // return NO to not change text
    }
    else
    {
        if(textField == txTeam1)
            [CatchPhraseGame sharedInstance].team1Name = textField.text;
        
        if(textField == txTeam2)
            [CatchPhraseGame sharedInstance].team2Name = textField.text;
        
        return YES;
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
 
-(void) setupControls
{
    if([CatchPhraseGame sharedInstance].pointsToWin > 3 && [CatchPhraseGame sharedInstance].pointsToWin < 15)
    {
        btPointsLeft.enabled = YES;
        btPointsRight.enabled = YES;
        btPointsLeft.alpha = 1;
        btPointsRight.alpha = 1;
    }
    else if ([CatchPhraseGame sharedInstance].pointsToWin == 3)
    {
        btPointsLeft.enabled = NO;
        btPointsLeft.alpha = 0.5f;
    }
    else if ([CatchPhraseGame sharedInstance].pointsToWin == 15)
    {
        btPointsRight.enabled = NO;
        btPointsRight.alpha = 0.5f;
    }
    
    if([CatchPhraseGame sharedInstance].selectedCategoryIndex > 0 && [CatchPhraseGame sharedInstance].selectedCategoryIndex < [[CatchPhraseGame sharedInstance].categoriesArray count] - 1)
    {
        btCategoryLeft.enabled = YES;
        btCategoryRight.enabled = YES;
        btCategoryLeft.alpha = 1;
        btCategoryRight.alpha = 1;
    }
    else if ([CatchPhraseGame sharedInstance].selectedCategoryIndex == 0)
    {
        btCategoryLeft.enabled = NO;
        btCategoryLeft.alpha = 0.5f;
    }
    else if ([CatchPhraseGame sharedInstance].selectedCategoryIndex == [[CatchPhraseGame sharedInstance].categoriesArray count] - 1)
    {
        btCategoryRight.enabled = NO;
        btCategoryRight.alpha = 0.5f;
    }
    
    if([CatchPhraseGame sharedInstance].buzzerSoundIndex > 0 && [CatchPhraseGame sharedInstance].buzzerSoundIndex < [[CatchPhraseGame sharedInstance].buzzerSoundsArray count] - 1)
    {
        btSoundsLeft.enabled = YES;
        btSoundsRight.enabled = YES;
        btSoundsLeft.alpha = 1;
        btSoundsRight.alpha = 1;
    }
    else if ([CatchPhraseGame sharedInstance].buzzerSoundIndex == 0)
    {
        btSoundsLeft.enabled = NO;
        btSoundsLeft.alpha = 0.5f;
    }
    else if ([CatchPhraseGame sharedInstance].buzzerSoundIndex == [[CatchPhraseGame sharedInstance].buzzerSoundsArray count] - 1)
    {
        btSoundsRight.enabled = NO;
        btSoundsRight.alpha = 0.5f;
    }

}

- (void)viewWillAppear:(BOOL)animated 
{
	[super viewWillAppear:animated];
    
    [txTeam1 setText:[[CatchPhraseGame sharedInstance] getTeamDefaultName:1]];
    [txTeam2 setText:[[CatchPhraseGame sharedInstance] getTeamDefaultName:2]];
    
    [lbPointsToWin setText:[NSString stringWithFormat:@"%i",[CatchPhraseGame sharedInstance].pointsToWin]];
    [lbCategory setText:[[CatchPhraseGame sharedInstance] getCategoryNameByCurrentIndex]];
    [lbBuzzerSound setText:[[CatchPhraseGame sharedInstance] getBuzzerSoundByCurrentIndex]];
    
    [self setupControls];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[CatchPhraseGame sharedInstance] saveUserProperties];
}


-(IBAction) onStartGame
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    
    [CatchPhraseGame sharedInstance].team1Name = txTeam1.text;
    [CatchPhraseGame sharedInstance].team2Name = txTeam2.text;
    
    NSString *nibName = [VSUtils isIPad] ? @"RoundStartViewControllerIPad":@"RoundStartViewController";
	
	RoundStartViewController *gameViewController = [[RoundStartViewController alloc] initWithNibName:nibName bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:gameViewController animated:NO];
	[gameViewController release];
}

-(IBAction) backToMenu
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) onPointsLeft
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    
    if([CatchPhraseGame sharedInstance].pointsToWin > 3)
    {
        [CatchPhraseGame sharedInstance].pointsToWin--;
    }
    
    [self setupControls];
    
    [lbPointsToWin setText:[NSString stringWithFormat:@"%i",[CatchPhraseGame sharedInstance].pointsToWin]];
    
    [[CatchPhraseGame sharedInstance] saveUserProperties];
}

-(IBAction) onPointsRight
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    
    if([CatchPhraseGame sharedInstance].pointsToWin < 15)
    {
        [CatchPhraseGame sharedInstance].pointsToWin++;
       
    }
    
    [self setupControls];
   
    
    [lbPointsToWin setText:[NSString stringWithFormat:@"%i",[CatchPhraseGame sharedInstance].pointsToWin]];
    
    [[CatchPhraseGame sharedInstance] saveUserProperties];
}

-(IBAction) onCategoryLeft
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    
    if([CatchPhraseGame sharedInstance].selectedCategoryIndex > 0)
        [CatchPhraseGame sharedInstance].selectedCategoryIndex--;
    
     [self setupControls];
    
    [lbCategory setText:[[CatchPhraseGame sharedInstance] getCategoryNameByCurrentIndex]];
    
    [[CatchPhraseGame sharedInstance] saveUserProperties];
}

-(IBAction) onCategoryRight
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    
    if([CatchPhraseGame sharedInstance].selectedCategoryIndex < [[CatchPhraseGame sharedInstance].categoriesArray count] - 1)
        [CatchPhraseGame sharedInstance].selectedCategoryIndex++;
    
     [self setupControls];
    
    [lbCategory setText:[[CatchPhraseGame sharedInstance] getCategoryNameByCurrentIndex]];
    
    [[CatchPhraseGame sharedInstance] saveUserProperties];
}
 
-(IBAction) onSoundLeft
{
    //[[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    
    if([CatchPhraseGame sharedInstance].buzzerSoundIndex > 0)
    {
        [CatchPhraseGame sharedInstance].buzzerSoundIndex--;
        
        [[CatchPhraseGame sharedInstance] playSoundByIndex:[CatchPhraseGame sharedInstance].buzzerSoundIndex];
    }else
        [[CatchPhraseGame sharedInstance] stopSoundsSAE];
    
     [self setupControls];
    
    [lbBuzzerSound setText:[[CatchPhraseGame sharedInstance] getBuzzerSoundByCurrentIndex]];
    
    
    
    
    [[CatchPhraseGame sharedInstance] saveUserProperties];
}

-(IBAction) onSoundRight
{
    //[[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    
    if([CatchPhraseGame sharedInstance].buzzerSoundIndex < [[CatchPhraseGame sharedInstance].buzzerSoundsArray count] - 1)
    {
        [CatchPhraseGame sharedInstance].buzzerSoundIndex++;
        
        if([CatchPhraseGame sharedInstance].buzzerSoundIndex < [[CatchPhraseGame sharedInstance].buzzerSoundsArray count] - 1)
            [[CatchPhraseGame sharedInstance] playSoundByIndex:[CatchPhraseGame sharedInstance].buzzerSoundIndex];
        else
            [[CatchPhraseGame sharedInstance] stopSoundsSAE];
        
        
    }
    
    [self setupControls];
    
    [lbBuzzerSound setText:[[CatchPhraseGame sharedInstance] getBuzzerSoundByCurrentIndex]];
    
    
    
    [[CatchPhraseGame sharedInstance] saveUserProperties];
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
