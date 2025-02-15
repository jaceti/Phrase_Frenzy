//
//  MSLabel.m
//  Miso
//
//  Created by Joshua Wu on 11/15/11.
//  Copyright (c) 2011 Miso. All rights reserved.
//

#import "MSLabel.h"

@interface MSLabel ()

- (NSArray *)stringsFromText:(NSString *)string;

@end

@implementation MSLabel
@synthesize lineHeight=_lineHeight;
@synthesize anchorBottom=_anchorBottom;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _lineHeight = 45;
    }
    
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    NSArray *slicedStrings = [self stringsFromText:self.text];
    [self.textColor set];
    
    for (int i = 0; i < slicedStrings.count; i++) {
        if (i + 1 > self.numberOfLines && self.numberOfLines != 0)
            break;
        
        NSString *line = [slicedStrings objectAtIndex:i];
        
        // calculate drawHeight based on anchor
        int drawHeight = _anchorBottom ? (self.frame.size.height - (slicedStrings.count - i) * _lineHeight) : i * _lineHeight;        
        
        // calculate drawWidth based on textAlignment
        int drawWidth = 0;
        if (self.textAlignment == UITextAlignmentCenter) {
            drawWidth = floorf((self.frame.size.width - [line sizeWithFont:self.font].width) / 2);
        } else if (self.textAlignment == UITextAlignmentRight) {
            drawWidth = (self.frame.size.width - [line sizeWithFont:self.font].width);
        }
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetRGBFillColor(context, 2/255.0f, 82/255.0f, 143/255.0f, 1.0);
        //CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
       // CGContextSetTextDrawingMode(context, kCGTextFillStroke);
        CGContextSaveGState(context);

        
        [line drawAtPoint:CGPointMake(drawWidth, drawHeight) forWidth:self.frame.size.width withFont:self.font fontSize:self.font.pointSize lineBreakMode:UILineBreakModeClip baselineAdjustment:UIBaselineAdjustmentNone];
        
        CGContextRestoreGState(context);

        
        /*
        CGSize shadowOffset = self.shadowOffset;
        UIColor *textColor = self.textColor;
        
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(c, 1);
        CGContextSetLineJoin(c, kCGLineJoinRound);
        
        CGContextSetTextDrawingMode(c, kCGTextStroke);
        self.textColor = [UIColor blackColor];
        
       // [super drawTextInRect:rect];
        [line drawAtPoint:CGPointMake(drawWidth, drawHeight) forWidth:self.frame.size.width withFont:self.font fontSize:self.font.pointSize lineBreakMode:UILineBreakModeClip baselineAdjustment:UIBaselineAdjustmentNone];
        
        CGContextSetTextDrawingMode(c, kCGTextFill);
        self.textColor = textColor;
        self.shadowOffset = CGSizeMake(0, 0);
        //[super drawTextInRect:rect];
        [line drawAtPoint:CGPointMake(drawWidth, drawHeight) forWidth:self.frame.size.width withFont:self.font fontSize:self.font.pointSize lineBreakMode:UILineBreakModeClip baselineAdjustment:UIBaselineAdjustmentNone];
        
        self.shadowOffset = shadowOffset;*/
    }
}

#pragma mark - Properties

- (void)setLineHeight:(int)lineHeight {
    if (_lineHeight == lineHeight) { return; }
    _lineHeight = lineHeight;
    [self setNeedsDisplay];
}

#pragma mark - Private Methods

- (NSArray *)stringsFromText:(NSString *)string {
    NSMutableArray *stringsArray = [[[string componentsSeparatedByString:@" "] mutableCopy] autorelease];
    NSMutableArray *slicedString = [NSMutableArray array];
    
    while (stringsArray.count != 0) {
        NSString *line = [NSString stringWithString:@""];
        NSMutableIndexSet *wordsToRemove = [NSMutableIndexSet indexSet];
        
        for (int i = 0; i < [stringsArray count]; i++) {
            NSString *word = [stringsArray objectAtIndex:i];
            
            if ([[line stringByAppendingFormat:@"%@ ", word] sizeWithFont:self.font].width <= self.frame.size.width) {
                line = [line stringByAppendingFormat:@"%@ ", word];
                [wordsToRemove addIndex:i];
            } else {
                if (line.length == 0) {
                    line = [line stringByAppendingFormat:@"%@ ", word];
                    [wordsToRemove addIndex:i];
                }
                break;
            }
        }
        [slicedString addObject:[line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        [stringsArray removeObjectsAtIndexes:wordsToRemove];
    }
    
    if (slicedString.count > self.numberOfLines && self.numberOfLines != 0) {
        NSString *line = [slicedString objectAtIndex:(self.numberOfLines - 1)];
        line = [line stringByReplacingCharactersInRange:NSMakeRange(line.length - 3, 3) withString:@"..."];
        [slicedString removeObjectAtIndex:(self.numberOfLines - 1)];
        [slicedString insertObject:line atIndex:(self.numberOfLines - 1)];
    }
    
    return slicedString;
}

@end
