#import "TCCheckBoxView.h"

@implementation TCCheckBoxView

@synthesize checked, delegate, context;

- (id)initWithFrame:(CGRect)frame delegate:(id<TCCheckBoxViewDelegate>)_delegate andContext:(id)_context{
    if ((self = [super initWithFrame:frame])) {
        UIImage *image = (checked) ? [UIImage imageNamed:@"chk_box_selected.png"] : [UIImage imageNamed:@"chk_box.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 101;
        CGRect buttonFrame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
        button.frame = buttonFrame;	
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(checkButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        [self addSubview:button];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, button.frame.size.width, button.frame.size.height); 
        self.delegate = _delegate;
        self.context = _context;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setChecked:(BOOL)_checked{
    checked = _checked;
    [self setNeedsDisplay];
}

-(void)checkButtonTapped{
    checked = !checked;
    [self setNeedsDisplay];
    [self.delegate stateChanged:checked forContext:context];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIButton *button = (UIButton*)[self viewWithTag:101];
    UIImage *newImage = (!checked) ? [UIImage imageNamed:@"chk_box.png"] : [UIImage imageNamed:@"chk_box_selected.png"];
	[button setBackgroundImage:newImage forState:UIControlStateNormal];
}

- (void) disableButton{
    UIButton *button = (UIButton*)[self viewWithTag:101];
    button.enabled = NO;
}

- (void)dealloc {
    self.context = nil;
    [super dealloc];
}

@end
