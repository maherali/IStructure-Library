#import "TCLoginFooter.h"
#import "TCUIFactory.h"
#import "TCTermsAndConditionsLabel.h"

@implementation TCLoginFooter

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    UIButton *signinButton = [TCUIFactory buttonWithLabel:@"Sign In" frame:CGRectMake(5, 7, 310, 50)];
    [signinButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    TCTermsAndConditionsLabel *tncLabel = [[[TCTermsAndConditionsLabel alloc] init] autorelease];	
    tncLabel.frame = CGRectMake(100, 75, 125, 20);
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:signinButton];
    [self addSubview:tncLabel]; 
    return self;
}

- (void) signIn{
    //trigger button:signin
}

@end
