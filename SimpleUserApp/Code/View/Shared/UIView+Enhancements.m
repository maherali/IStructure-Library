#import "UIView+Enhancements.h"

@implementation UIView(Enhancements)

- (UIView*) findFirstResponder{
    if (self.isFirstResponder) {
        return self;     
    }
    for (UIView *subView in self.subviews) {
        UIView *x = [subView findFirstResponder];
        if(x){
            return x;
        }
    }
    return nil;
}

- (BOOL) hasView:(UIView*) v{
    if (self == v) {
        return YES;     
    }
    for (UIView *subView in self.subviews) {
        if([subView hasView:v]){
            return YES;
        }
    }
    return NO;
}


@end
