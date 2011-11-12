@interface TCUIFactory : NSObject

+ (UIImageView*) backgroundImageView;
+ (UIBarButtonItem*) backButtonForTarget:(id) target andAction:(SEL) action;
+ (UIButton *) buttonWithLabel:(NSString *)label frame:(CGRect)frame;
+ (UIBarButtonItem*) editRefreshButtonsForTarget:(id) target editAction:(SEL) editAction refreshAction:(SEL) refreshAction;

@end
