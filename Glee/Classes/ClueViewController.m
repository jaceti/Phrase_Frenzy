//
//  FinalScoreViewController.m
//  Velveeta
//
//  Created by Alexei Rudak on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClueViewController.h"
#import "Question.h"
#import "RoundStartViewController.h"
#import "VSUtils.h"
#import "UIImage+Tint.h"
#import "FinalScoreViewController.h"
#import "EndLevelViewController.h"

@implementation ClueViewController

@synthesize bgImage,lbQuestion;



- (void) questionWasGenerated:(Question*)question
{
    lbQuestion.text = question.text;
    
    //NSLog(@"%@", lbQuestion.text);
    
    if([VSUtils isIPad])
    {
        if([lbQuestion.text length] >= 32)
            [lbQuestion setFont:[UIFont fontWithName:@"FranklinGothic LT Condensed" size: 76]];
        else if([lbQuestion.text length] >= 24 && [lbQuestion.text length] < 32)
            [lbQuestion setFont:[UIFont fontWithName:@"FranklinGothic LT Condensed" size: 96]];
        else if ([lbQuestion.text length] < 24)
            [lbQuestion setFont:[UIFont fontWithName:@"FranklinGothic LT Condensed" size: 114]];
    }
    else 
    {
        if([lbQuestion.text length] >= 32)
            [lbQuestion setFont:[UIFont fontWithName:@"FranklinGothic LT Condensed" size: 38]];
        else if([lbQuestion.text length] >= 24 && [lbQuestion.text length] < 32)
            [lbQuestion setFont:[UIFont fontWithName:@"FranklinGothic LT Condensed" size: 48]];
        else if ([lbQuestion.text length] < 24)
            [lbQuestion setFont:[UIFont fontWithName:@"FranklinGothic LT Condensed" size: 57]];
    }
}



- (void) roundTimerCalled:(NSInteger) dec
{
    /*
    if(bgImage.alpha > 0.8f)
        bgImage.alpha-=(0.2/60);*/
    
   
}

-(void) timeIsUp
{
    
    NSString *nibName = [VSUtils isIPad] ? @"EndLevelViewControllerIPad":@"EndLevelViewController";
	
	EndLevelViewController *gameViewController = [[EndLevelViewController alloc] initWithNibName:nibName bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:gameViewController animated:NO];
	[gameViewController release];
}

-(IBAction) onNextWord
{
    [[CatchPhraseGame sharedInstance] playSound:MCsoundButtonClick];
    
    //for(int a = 0; a< 2000;a++)
        [[CatchPhraseGame sharedInstance] nextClue];
    
    
    //NSArray *sortedArray = [[CatchPhraseGame sharedInstance].repeatedArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    /*
    NSMutableArray *test = [[NSMutableArray alloc] init];
    for(Question *q in [CatchPhraseGame sharedInstance].repeatedArray)
    {
        [test addObject:q.text];
    }*/
    
    /*
    id mySort = ^(NSString * key1, NSString * key2){
        return [key1 compare:key2];
    };
    
    
    NSArray * sortedKeys = [[CatchPhraseGame sharedInstance].repeatedArray sortedArrayUsingComparator:mySort];
    
    NSLog(@"game count = %i",[[CatchPhraseGame sharedInstance].gameQuestions count]);
    NSLog(@"rep count = %i",[[CatchPhraseGame sharedInstance].repeatedArray count]);
    NSLog(@"---------------");
    for(NSString *q in sortedKeys)
    {
        NSLog(@"%@",q);
    }*/
    
    
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
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
    [bgImage.image imageTintedWithColor:[UIColor blackColor]];
    
    
    if([VSUtils isIPad])
        [lbQuestion setLineHeight:110];
    else
        [lbQuestion setLineHeight:60];
    
    //[lbQuestion setFont:[UIFont fontWithName:@"Rockwell-Bold" size: lbQuestion.font.pointSize]];
    
    
    
    [[CatchPhraseGame sharedInstance] setDelegate:self];
    [[CatchPhraseGame sharedInstance] nextRound];
    
    
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
    [lbQuestion release];
    [resumeView release];
    [super dealloc];
}


@end
