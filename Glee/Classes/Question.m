//
//  Question.m
//  Velveeta
//
//  Created by Alexei Rudak on 09/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Question.h"


@implementation Question

@synthesize identifier,text,priority,categoryIndex;

- (NSComparisonResult)compare:(Question*) secondObject
{
 if (self.text < secondObject.text)
     return NSOrderedAscending;
     else if (self.text == secondObject.text)
     return NSOrderedSame;
 else
     return NSOrderedDescending;
}



#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder 
{
	[encoder encodeObject:identifier forKey:@"identifier"];
	[encoder encodeObject:text forKey:@"text"];
	[encoder encodeObject:priority forKey:@"priority"];
    //[encoder encodeObject:category forKey:@"category"];
}

- (id)initWithCoder:(NSCoder *)decoder {
	if(self = [super init]) 
	{
		self.identifier = [decoder decodeObjectForKey:@"identifier"];
		self.text = [decoder decodeObjectForKey:@"text"];
		self.priority = [decoder decodeObjectForKey:@"priority"];
        //self.category = [decoder decodeObjectForKey:@"category"];
	}
	return self;
}

@end
