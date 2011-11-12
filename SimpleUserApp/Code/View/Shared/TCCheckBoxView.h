@protocol TCCheckBoxViewDelegate
- (void) stateChanged:(BOOL) checked forContext:(id) context;
@end

@interface TCCheckBoxView : UIView {
    BOOL                            checked;
    id<TCCheckBoxViewDelegate>        delegate;
    id                              context;
}

@property(nonatomic, assign)  BOOL                           checked;
@property(nonatomic, assign)  id<TCCheckBoxViewDelegate>       delegate;
@property(nonatomic, retain)  id                             context;

- (id)   initWithFrame:(CGRect)frame delegate:(id<TCCheckBoxViewDelegate>)_delegate andContext:(id)_context;
- (void) setChecked:(BOOL)_checked;
- (void) checkButtonTapped;
- (void) disableButton;

@end
