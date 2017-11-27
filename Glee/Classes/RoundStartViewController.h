//
//  GameViewController.h
//  Velveeta
//
//  Created by Alexei Rudak on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAppViewController.h"
#import "CPLabel.h"

@interface RoundStartViewController : BaseAppViewController 
{
    UIView *scoreWarnView;
	CPLabel *lbTeam1Name,*lbTeam2Name;
    CPLabel *lbScore1,*lbScore2;
    CPLabel *lbWinScoreTitle,*lbWinScore;
}

@property (nonatomic, retain) IBOutlet UIView *scoreWarnView;
@property (nonatomic, retain) IBOutlet CPLabel *lbTeam1Name,*lbTeam2Name;
@property (nonatomic, retain) IBOutlet CPLabel *lbScore1,*lbScore2;
@property (nonatomic, retain) IBOutlet CPLabel *lbWinScoreTitle,*lbWinScore;

-(IBAction) onGO;
-(IBAction) onHome;

-(IBAction) onTeam1Plus;
-(IBAction) onTeam2Plus;
-(IBAction) onTeam1Minus;
-(IBAction) onTeam2Minus;

-(IBAction) onSituationYES;
-(IBAction) onSituationNO;

@end
