@interface NewMessageViewerView : UIWebView<UIWebViewDelegate> {
	id          presenter;
}

@property (nonatomic, assign) id presenter;

@end
