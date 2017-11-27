//
//  EndLevelViewController.h
//  CatchPhrase
//
//  Created by testbest on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPLabel.h"
#import "BaseAppViewController.h"

@interface EndLevelViewController : BaseAppViewController
{
    UIButton *btContinue,*btTeam1,*btTeam2,*btYes,*btNo;
    CPLabel *lbQuestion;
    BOOL teamSelected;
    BOOL team1Sel;
    BOOL team2Sel;
    BOOL quessCorrect;
    BOOL guessSelected;
    UIImageView *imTimeUp;
    UIView *vOverlay;
}

@property (nonatomic, retain) IBOutlet UIButton *btContinue,*btTeam1,*btTeam2,*btYes,*btNo;
@property (nonatomic, retain) IBOutlet CPLabel *lbQuestion;
@property (nonatomic, assign) BOOL teamSelected;
@property (nonatomic, assign) BOOL guessSelected;
@property (nonatomic, assign) BOOL team1Sel;
@property (nonatomic, assign) BOOL team2Sel;
@property (nonatomic, retain) IBOutlet UIImageView *imTimeUp;
@property (nonatomic, retain) IBOutlet  UIView *vOverlay;

-(IBAction) onTeam1;
-(IBAction) onTeam2;

-(IBAction) onGuessCorrect;
-(IBAction) onGuessFalse;

-(IBAction) onContinue;

-(IBAction) onPlayAgain;
-(void) runAnimations;
-(void) part1;
-(void) part2;

-(void) checkForSelectedButtons;

-(IBAction) onPause;
-(IBAction) onResume;
-(IBAction) onCancelRound;

@end
