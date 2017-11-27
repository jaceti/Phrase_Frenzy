//
//  TidBitViewController.h
//  HarryPotter
//
//  Created by Alexei Rudak on 25/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseAppViewController : UIViewController {
	UIAlertView *modalAlertView;
	MBProgressHUD *HUD;
    UIImageView *imInfoMainView;
	UIImageView *imInfoFinalView;
    UIView *resumeView;
    UIView *endGameView;
    BOOL isMainAnimating;
	BOOL isFinalAnimating;
    NSInteger animType;
	CGRect animInRect;
}
@property (nonatomic, retain) IBOutlet UIView *endGameView;
@property (nonatomic, retain) IBOutlet UIView *resumeView;
@property (nonatomic, retain) UIImageView *imInfoMainView;
@property (nonatomic, retain) UIImageView *imInfoFinalView;
@property (nonatomic, assign) BOOL isMainAnimating;
@property (nonatomic, assign) BOOL isFinalAnimating;

-(void) showBackToMenuView;
-(IBAction) backToMenu;
-(IBAction) onReturnToMenu;
-(IBAction) onCancelReturningToMenu;

-(void) hideLoadingMessage;
-(void) showLoadingMessage:(NSString*) msgText;

-(void) showLoadingHUD;
-(void) hideLoadingHUD;

-(void) startInfoImageAnimation:(NSInteger)type inView:(UIView*)inView;
-(void) guessAnimationFinished;
-(void) timerAnimationFinished;
-(void) gameoverAnimationFinished;
-(void) showRateScreen;

-(void) stopAllAnimations;

@end
