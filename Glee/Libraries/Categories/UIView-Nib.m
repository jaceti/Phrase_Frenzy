
#import "UIView-Nib.h"

@implementation UIView (Nib)

+ (UIView *)loadFromNib
{
	NSArray *topLevelObjects = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] retain];
	for(id currentObject in topLevelObjects)
	{
		if([currentObject isKindOfClass:[self class]])
		{
			[currentObject retain];
			[topLevelObjects release];
			return [currentObject autorelease];
		}
	}
	return nil;
}

@end
