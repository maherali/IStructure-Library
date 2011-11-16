@interface ISLoadingView : UIView{
    id delegate;
}

@property (nonatomic, assign) id delegate;

- (void)removeView;
+ (id)loadingView;
+ (id)loadingViewWithMessage:(NSString*) message;
+ (id)loadingViewWithMessage:(NSString*) message delegate:(id) delegate;

@end
