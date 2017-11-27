//
//  TidbitView.m
//  Jack
//
//  Created by testbest on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TidbitView.h"
#import "UIView-Expanded.h"

@implementation TidbitView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)didAddSubview:(UIView *)subview
{
    [self changeViewFont:[UIFont fontWithName: @"FranklinGothic LT Condensed" size: 18]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
