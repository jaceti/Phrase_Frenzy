//
//  FinalScoreViewController.h
//  Velveeta
//
//  Created by Alexei Rudak on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatchPhraseGame.h"
#import "BaseAppViewController.h"
#import "CPLabel.h"
#import "MSLabel.h"

@interface ClueViewController : BaseAppViewController <CatchPhraseGameDelegate>
{
	
    UIImageView *bgImage;
    MSLabel *lbQuestion;
    NSInteger dec10;
    BOOL run;
}

@property (nonatomic, retain) IBOutlet MSLabel *lbQuestion;
@property (nonatomic, retain) IBOutlet UIImageView *bgImage;


-(IBAction) onNextWord;
-(IBAction) onPause;

-(IBAction) onResume;
-(IBAction) onCancelRound;
-(void) roundTimerCalled;
-(IBAction) onEndLevel;

@end
