@interface TCWebHostView : UIWebView<UIWebViewDelegate>{    
    NSMutableArray          *observers;
}

@property (nonatomic, retain) NSMutableArray    *observers;

- (id) initWithOptions:(NSDictionary *) _options;

@end
