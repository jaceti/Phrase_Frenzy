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
#import "SimpleAudioEngine.h"

@interface FinalScoreViewController : BaseAppViewController 
{
	CPLabel *lbTeam1,*lbTeam2;
    CPLabel *lbScore1,*lbScore2;
    CPLabel *lbWinner;
    CPLabel *lbFinalScoreTitle;
    ALuint victorySound;
}

@property (nonatomic, retain) IBOutlet CPLabel *lbTeam1,*lbTeam2;
@property (nonatomic, retain) IBOutlet CPLabel *lbScore1,*lbScore2;
@property (nonatomic, retain) IBOutlet CPLabel *lbWinner;
@property (nonatomic, retain) IBOutlet CPLabel *lbFinalScoreTitle;
@property (nonatomic, assign) ALuint victorySound;

-(IBAction) onPlayAgain;
-(IBAction) backToMenu;

@end
