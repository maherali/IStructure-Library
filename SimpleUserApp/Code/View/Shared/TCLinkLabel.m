#import "TCLinkLabel.h"

@implementation TCLinkLabel

@synthesize underline, underlineWidth;

-(id) init{
	if((self = [super init])){
		self.underlineWidth = 2.0;
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
    if (underline) {
		CGContextRef context = UIGraphicsGetCurrentContext();			
		const CGFloat *components = CGColorGetComponents(self.textColor.CGColor);
		CGContextSetRGBStrokeColor(context, components[0], components[1], components[2], components[3]);
		CGContextSetLineWidth(context, underlineWidth);
		
		CGSize dynamicSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(99999, 99999) lineBreakMode:self.lineBreakMode];
		CGContextMoveToPoint(context, 0, dynamicSize.height);
		CGContextAddLineToPoint(context, dynamicSize.width, dynamicSize.height);	
		CGContextStrokePath(context);
	}
}

@end
