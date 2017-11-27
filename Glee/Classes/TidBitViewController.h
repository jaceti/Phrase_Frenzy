//
//  TidBitViewController.h
//  HarryPotter
//
//  Created by Alexei Rudak on 25/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "MBProgressHUD.h"

@interface TidBitViewController : UIViewController <GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate>{
	UIAlertView *modalAlertView;
	MBProgressHUD *HUD;
}

-(void) hideLoadingMessage;
-(void) showLoadingMessage:(NSString*) msgText;

-(void) showLoadingHUD;
-(void) hideLoadingHUD;

-(IBAction) onBack;
-(IBAction) onHome;

@end
