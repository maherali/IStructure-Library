@interface TCUIFactory : NSObject

+ (UIImageView*) backgroundImageView;
+ (UIBarButtonItem*) backButtonForTarget:(id) target andAction:(SEL) action;
+ (UIBarButtonItem*) editRefreshButtonsForTarget:(id) target editAction:(SEL) editAction refreshAction:(SEL) refreshAction;
+ (ValidationErrorHandler) commonValidationErrorHandler;
+ (NSDictionary*) commonSetOptions;

@end
