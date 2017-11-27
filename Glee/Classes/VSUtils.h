//
//  VSUtils.h
//  partySlots
//
//  Created by Alexei Rudak on 18/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface VSUtils : NSObject {

}
+ (BOOL) isIPad;
+ (NSString *) platform;
+ (NSString *) platformString;
+ (BOOL) isGameCenterAvailable;
+ (void) showMessage:(NSString*)text;
+ (BOOL) isConnectedToInternet:(BOOL) showMessage;
+ (BOOL) isGPSEnable:(BOOL)showMessage;
+ (NSString*) getPassedTime:(NSDate *) created;
+ (void) setTextFieldError:(UITextField*)textField isError:(BOOL)isError type:(NSInteger) type;
+(double) getSystemVersion;
+ (NSString*) optimiseText:(NSString*) text;
+ (NSString*) trimString:(NSString*) string;
+(NSString*) formatScores:(NSInteger) scores;
+(void)fixLabels:(UIView *)theView;

@end
