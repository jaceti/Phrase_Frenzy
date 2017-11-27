//
//  ActorSceneViewController.h
//  Velveeta
//
//  Created by Alexei Rudak on 14/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAppViewController.h"


@interface HTPViewController : BaseAppViewController 
{
	UIScrollView *scrollView;
    UILabel *lbText1,*lbText2,*lbText3;
    
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *lbText1,*lbText2,*lbText3;

-(IBAction) onBack;

@end
