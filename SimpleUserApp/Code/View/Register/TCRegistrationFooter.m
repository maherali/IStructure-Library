#import "TCRegistrationFooter.h"
#import "TCTermsAndConditionsLabel.h"
#import "TCUIFactory.h"

@implementation TCRegistrationFooter

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self addSubview:[TCUIFactory buttonWithLabel:@"Sign Up" frame:CGRectMake(5, 7, 310, 50)]];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 60, 320, 20)] autorelease];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"By registering you agree to the";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:label];    
    
    self.backgroundColor = [UIColor clearColor];
    TCTermsAndConditionsLabel *tncLabel = [[[TCTermsAndConditionsLabel alloc] init] autorelease];	
    tncLabel.frame = CGRectMake(100, 75, 125, 20);
    [self addSubview:tncLabel]; 
    
    return self;
}

@end
