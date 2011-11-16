@interface ISLoadingView : UIView

- (void)removeView;
+ (id)loadingView;
+ (id)loadingViewWithMessage:(NSString*) message;
+ (id)loadingViewWithMessage:(NSString*) message cancellable:(BOOL) cancellable;

@end
