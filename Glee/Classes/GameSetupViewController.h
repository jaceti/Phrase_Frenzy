//
//  ScenesTableViewController.h
//  Velveeta
//
//  Created by Alexei Rudak on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPLabel.h"


@interface GameSetupViewController : UIViewController <UITextFieldDelegate>
{
	UITextField *txTeam1;
    UITextField *txTeam2;
    CPLabel *lbPointsToWin;
    CPLabel *lbCategory;
    CPLabel *lbBuzzerSound;
    
    UIButton *btPointsLeft,*btPointsRight;
    UIButton *btCategoryLeft,*btCategoryRight;
    UIButton *btSoundsLeft,*btSoundsRight;
}

@property (nonatomic, retain) IBOutlet UITextField *txTeam1;
@property (nonatomic, retain) IBOutlet UITextField *txTeam2;
@property (nonatomic, retain) IBOutlet CPLabel *lbPointsToWin;
@property (nonatomic, retain) IBOutlet CPLabel *lbCategory;
@property (nonatomic, retain) IBOutlet CPLabel *lbBuzzerSound;

@property (nonatomic, retain) IBOutlet  UIButton *btPointsLeft,*btPointsRight;
@property (nonatomic, retain) IBOutlet  UIButton *btCategoryLeft,*btCategoryRight;
@property (nonatomic, retain) IBOutlet  UIButton *btSoundsLeft,*btSoundsRight;

-(IBAction) backToMenu;
-(IBAction) onStartGame;

-(IBAction) onPointsLeft;
-(IBAction) onPointsRight;

-(IBAction) onCategoryLeft;
-(IBAction) onCategoryRight;

-(IBAction) onSoundLeft;
-(IBAction) onSoundRight;



@end
