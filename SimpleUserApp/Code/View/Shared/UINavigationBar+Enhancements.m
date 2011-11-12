#import "UINavigationBar+Enhancements.h"

@interface MyNavigationBar : UINavigationBar

@end

@implementation MyNavigationBar

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"titlebar_bg.png"];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end

@implementation UINavigationBar (TripCase)

+ (Class)class {
    return NSClassFromString(@"MyNavigationBar");
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    [self applyDefaultStyle];
}

- (void)applyDefaultStyle {
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0.0, 3);
    self.layer.shadowOpacity = 0.25;
    self.layer.masksToBounds = NO;
    self.layer.shouldRasterize = YES;
}

@end
