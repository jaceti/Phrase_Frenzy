//
//  UIView.m
//  Jack
//
//  Created by testbest on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIView-Expanded.h"
#import "CPLabel.h"

@implementation UIView (Expanded)

-(void)changeViewFont:(UIFont*) font
{
    //NSLog(@"%@", self);
    for (UIView *subview in self.subviews)
    {
        if([subview isKindOfClass:[UILabel class]])
        {
            CPLabel *tempLabel = (CPLabel*)subview;
            [tempLabel setFont: [UIFont fontWithName:font.fontName size: tempLabel.font.pointSize]];
            
            
        }
        
        if([subview isKindOfClass:[UIButton class]])
        {
            UIButton *tempButton = (UIButton*)subview;
            [tempButton.titleLabel setFont:[UIFont fontWithName:font.fontName size: tempButton.titleLabel.font.pointSize]];
        }
        
        [subview changeViewFont:font];
    }
}

-(void)changeViewFontWithSize:(UIFont*) font
{
    //NSLog(@"%@", self);
    for (UIView *subview in self.subviews)
    {
        if([subview isKindOfClass:[UILabel class]])
        {
            CPLabel *tempLabel = (CPLabel*)subview;
            [tempLabel setFont: [UIFont fontWithName:font.fontName size: font.pointSize]];
            
            
        }
        
        if([subview isKindOfClass:[UIButton class]])
        {
            UIButton *tempButton = (UIButton*)subview;
            [tempButton.titleLabel setFont:[UIFont fontWithName:font.fontName size: font.pointSize]];
        }
        
        [subview changeViewFont:font];
    }
}

- (NSMutableArray*)allSubViews
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:self];
    for (UIView *subview in self.subviews)
    {
        [arr addObjectsFromArray:(NSArray*)[subview allSubViews]];
    }
    return arr;
}



@end
