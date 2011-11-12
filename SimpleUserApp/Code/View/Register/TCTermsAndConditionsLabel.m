#import "TCTermsAndConditionsLabel.h"

@implementation TCTermsAndConditionsLabel

-(id) init{
	if ((self = [super init])) {
		self.userInteractionEnabled = YES;
		self.numberOfLines = 0;
		self.underlineWidth = 0.75;
		self.underline = YES;
		self.text = @"Terms and Conditions.";
		self.textColor = [[[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1] autorelease];
		self.font = [UIFont systemFontOfSize:12.0];
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	tempColor = [self.backgroundColor retain];
	self.backgroundColor = [UIColor lightGrayColor];	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	self.backgroundColor = tempColor;
	[tempColor release];
    //show TNC
}

@end
