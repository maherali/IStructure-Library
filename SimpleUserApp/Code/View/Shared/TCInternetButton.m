#import "TCInternetButton.h"

@implementation TCInternetButton

@synthesize observers;

+ (TCInternetButton*) buttonForObservable:(id) observable target:(id) target action:(SEL) action frame:(CGRect) frame andLabel:(NSString*) label {
    return [[[TCInternetButton alloc] initWithObservable:observable target:target action:action frame:frame andLabel:label] autorelease];
}

- (id) initWithObservable:(id) observable target:(id) target action:(SEL) action frame:(CGRect) frame andLabel:(NSString*) label {
	self = [super initWithFrame:frame];
	self.tag = label.hash;
	[self setTitle:label forState:UIControlStateNormal];
	[self setTitleColor:[UIColor colorWithRed:37/255.0f green:45/255.0f blue:52/255.0f alpha:1.0f] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
	[self setBackgroundImage:[[UIImage imageNamed:@"btn_light_blue_lg.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [self setBackgroundImage:[[UIImage imageNamed:@"btn_light_blue_lg_press.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    self.backgroundColor = [UIColor clearColor];
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.observers = $marray();
    __block TCInternetButton *this = self;
    $unwatch();
    $watch(@"internet:begin",   ^(NSNotification *notif){
        [this setEnabled:NO];
    });
    $watch(@"internet:end", ^(NSNotification *notif){
        [this setEnabled:YES];
    });
	return self;	
}

- (void) dealloc{
    __block TCInternetButton *this = self;
    $unwatch();
    self.observers = nil;
    [super dealloc];
}

@end
