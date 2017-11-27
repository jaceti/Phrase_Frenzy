//
//  VSUtils.m
//  partySlots
//
//  Created by Alexei Rudak on 18/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VSUtils.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "Reachability.h"
#import "UIView-Expanded.h"

@implementation VSUtils

+(void)fixLabels:(UIView *)theView{
    
    for(UIView *v in [theView allSubViews])
    {
        if([v isKindOfClass:[UILabel class]])
        {
            if( !((UILabel*)v).adjustsFontSizeToFitWidth ){
                ((UILabel*)v).adjustsFontSizeToFitWidth=YES;
                //  NSLog(@"fixed %@", theView);
            }
        }
    }
}


+ (BOOL) isGameCenterAvailable
{
    // Check for presence of GKLocalPlayer API.
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
	
    // The device must be running running iOS 4.1 or later.
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
	
    return (gcClass && osVersionSupported);
}

+ (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine];
    free(machine);
    return platform;
}

+(NSString*) formatScores:(NSInteger) scores
{
	NSString *s_scores = [NSString stringWithFormat:@"%i",scores];
	
	if ([s_scores length] > 3) {
		
		NSString *str1 = [s_scores substringToIndex:[s_scores length]-3];
		NSString *str2 = [s_scores substringFromIndex:[s_scores length]-3];
		
		NSString *commar = @",";
		
		if([s_scores length] == 4 && scores <0)
			commar = @"";
		
		s_scores = [NSString stringWithFormat:@"%@%@%@", str1, commar, str2];
	}
	
	return s_scores;
}

/*
+ (BOOL) isIPad
{
	NSString *pl = [VSUtils platformString];
	return [pl isEqualToString:@"iPad"];
	//return YES;
}*/


+ (BOOL) isIPad {
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        return YES;
    } else {
        return NO;
    }
}

 

+ (NSString *) platformString{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
	
    return platform;
}


+(BOOL) isConnectedToInternet:(BOOL) showMessage{
	static Reachability *internetReach;
	
	if(!internetReach)
	{
		internetReach = [[Reachability reachabilityForInternetConnection] retain];
		[internetReach startNotifier];
	}
	
	switch ([internetReach currentReachabilityStatus]){
        case NotReachable:{
			if(showMessage)
				[VSUtils showMessage:@"Application is having trouble connecting to the server. Please check your internet connection"];
			return NO;
        }
    }
	
	return YES;
}




+(NSString*) trimString:(NSString*) string
{
	return [string stringByTrimmingCharactersInSet:
									  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}




+ (void) showMessage:(NSString*)text
{
	UIAlertView* dialog = [[[UIAlertView alloc] init] autorelease];
	[dialog setTitle:@""];
	[dialog setMessage:text];
	[dialog addButtonWithTitle:@"OK"];
	
	[dialog show];
}
+(void) setTextFieldError:(UITextField*)textField isError:(BOOL)isError type:(NSInteger) type
{
	if(isError)
	{
		if(type == 1)
		{
			textField.placeholder = @"Please fill this field";
			//
			//[textField setText:@"Please fill this field"];
			
			[textField setValue:[UIColor redColor] 
							forKeyPath:@"_placeholderLabel.textColor"];
		}
		//[textField setTextColor:[UIColor redColor]];
	}
	else 
	{
		[textField setTextColor:[UIColor blackColor]];
	}
}

+ (NSString*) optimiseText:(NSString*) text
{
	if([text length] <= 15)
		return text;
	else {
		return [NSString stringWithFormat:@"%@...",[text substringToIndex:15]];
	}

}

+ (NSString*) getPassedTime:(NSDate *) created
{
	NSDate *now = [NSDate date];
	NSDate *old = created;
	
	double nowSec = [now timeIntervalSince1970];
	double oldSec = [old timeIntervalSince1970];
	
	NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
	int timeZoneOffset = [destinationTimeZone secondsFromGMTForDate:now] / 3600;
	
	
	NSInteger passed = nowSec - (oldSec + 3600*timeZoneOffset);
	
	NSString *type;
	
	if(passed < 3600)
	{
		passed = passed/60;
		if(passed == 1)
			type = @"minute";
		else
			type = @"minutes";
	}
	else if (passed < 3600*24)
	{
		passed = passed/3600;
		if(passed == 1)
			type = @"hour";
		else
			type = @"hours";
	}
	else if (passed < 3600*24*7)
	{
		passed = passed/(3600*24);
		if(passed == 1)
			type = @"day";
		else
			type = @"days";
	}
	else if (passed < 3600*24*30)
	{
		passed = passed/(84600*7);
		if(passed == 1)
			type = @"week";
		else
			type = @"weeks";
	}
	else if (passed/(3600*24*30*12) < 1)
	{
		passed = passed/(84600*30);
		if(passed == 1)
			type = @"month";
		else
			type = @"months";
	}
	else 
	{
		passed = passed/(84600*30*12);
		if(passed == 1)
			type = @"year";
		else
			type = @"years";
	}
	
	
	//NSLog(@"%f",passed/(84600*7);
	
	return [[NSString stringWithFormat:@" %i %@ ago",passed,type] retain];
}

+(double) getSystemVersion
{
	return [[UIDevice currentDevice].systemVersion doubleValue];
}

@end
