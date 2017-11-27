//
//  FinalScoreViewController.h
//  Velveeta
//
//  Created by Alexei Rudak on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAppViewController.h"
#import "CPLabel.h"

@interface EndRoundViewController : BaseAppViewController 
{
	UIButton *btContinue,*btTeam1,*btTeam2,*btYes,*btNo;
    CPLabel *lbQuestion;
    BOOL teamSelected;
    BOOL team1Sel;
    BOOL team2Sel;
    BOOL quessCorrect;
    BOOL guessSelected;
    UIImageView *imTimeUp;
}

@property (nonatomic, retain) IBOutlet UIButton *btContinue,*btTeam1,*btTeam2,*btYes,*btNo;
@property (nonatomic, retain) IBOutlet CPLabel *lbQuestion;
@property (nonatomic, assign) BOOL teamSelected;
@property (nonatomic, assign) BOOL guessSelected;
@property (nonatomic, assign) BOOL team1Sel;
@property (nonatomic, assign) BOOL team2Sel;
@property (nonatomic, retain) IBOutlet UIImageView *imTimeUp;

-(IBAction) onTeam1;
-(IBAction) onTeam2;

-(IBAction) onGuessCorrect;
-(IBAction) onGuessFalse;

-(IBAction) onContinue;

-(IBAction) onPlayAgain;


-(void) checkForSelectedButtons;

@end
