#import "TCLink.h"

NSString* const  TCLinkEventMame = @"TCLinkEventMame";

@implementation TCLink

+ (TCLink*) linkWithLabel:(NSString*) lbl{
    TCLink *link = [[[TCLink alloc] init] autorelease];
    link.text = lbl;
    return link;
}

-(id) init{
	if ((self = [super init])) {
		self.userInteractionEnabled = YES;
		self.numberOfLines = 0;
		self.underlineWidth = 0.75;
		self.underline = YES;
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
    TCLink *this = self;
    $trigger(TCLinkEventMame);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = tempColor;
	[tempColor release];
}

@end
