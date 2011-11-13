#import "NewMessageViewerView.h"
#import "MainPresenter.h"

@interface NewMessageViewerPresenter :  UIViewController {
    NewMessageViewerView                *mainView;
	NSString                            *url;
    MainPresenter                       *delegate;
    BOOL                                donotScale;
    NSInteger                           messageIndex;
    BOOL                                okToShowContinue;
    BOOL                                hasAContinueFunctionality;
}

@property(nonatomic, retain) NewMessageViewerView           *mainView;
@property(nonatomic, copy)   NSString                       *url;
@property(nonatomic, assign) MainPresenter                  *delegate;
@property(nonatomic, assign) BOOL                           donotScale;
@property(nonatomic, assign) NSInteger                      messageIndex;
@property(nonatomic, assign) BOOL                           hasAContinueFunctionality;

- (id) initWithTheUrl:(NSString*)_url;
- (void)setupWebViewNavButtons;
- (void) setupToolbarAppearance;
- (void) assignAContinueButton;
- (BOOL) needAToolBar;
- (void) assignAContinueButton;
- (void) hideContinueButton;

@end

