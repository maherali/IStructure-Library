#import "NewMessageViewerView.h"
#import "NewMessageViewerPresenter.h"

@implementation NewMessageViewerView

@synthesize presenter;

- (id)initWithPresenter:(id) _presenter{
	self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
	self.presenter = _presenter;
	self.delegate = self;
	self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    self.scalesPageToFit = !((NewMessageViewerPresenter *)self.presenter).donotScale;
	return self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	[((NewMessageViewerPresenter *)self.presenter) setupWebViewNavButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if ([error code] != -999) {
        NSString *formatStr = 
        @"<meta name=\"viewport\" content=\"width=320\"/>" 
        @"<html>"
        @"<body>"
        @"%@"
        @"</body>"
        @"</html>";
        NSString *msg = nil;
        if([UIApplication hasNetworkConnection]){
            msg = [NSString stringWithFormat:formatStr, [[error userInfo] objectForKey:NSLocalizedDescriptionKey]?[[error userInfo] objectForKey:NSLocalizedDescriptionKey]:error];
        }
        else{
            msg = [NSString stringWithFormat:formatStr, @"No Connectivity! Please try again!"];
        }
        [self loadHTMLString:msg baseURL:nil];
    }
}

@end
