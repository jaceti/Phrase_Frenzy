//
//  RootViewController.h
//  Velveeta
//
//  Created by Alexei Rudak on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatchPhraseGame.h"
#import "BaseAppViewController.h"

@interface RootViewController : BaseAppViewController 
{
	
}

-(IBAction) showHTPController;
-(IBAction) showGameSetupController;

-(IBAction) showFacebook;
-(IBAction) showOtherGames;
-(IBAction) showRateScreen;

@end
