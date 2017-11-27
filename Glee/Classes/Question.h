//
//  Question.h
//  Velveeta
//
//  Created by Alexei Rudak on 09/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Question : NSObject <NSCoding, NSCopying> 
{
	NSString *identifier;
	NSString *text;
	NSNumber *priority;
    NSInteger categoryIndex;
}

@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSNumber *priority;
@property (nonatomic, assign) NSInteger categoryIndex;
- (NSComparisonResult)compare:(Question*) secondObject;
@end
