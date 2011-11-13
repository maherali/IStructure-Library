#import "TCWebHostView.h"
#import "UIApplication+Extensions.h"
@implementation TCWebHostView

@synthesize observers;

- (id) initWithOptions:(NSDictionary *) _options{
	self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.observers = $marray();
	self.delegate = self;
	self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
	return self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    __block TCWebHostView *this = self;
    $trigger(@"web_finished_loading");
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

- (void) dealloc{
    __block TCWebHostView *this = self;
    $unwatch()
    self.observers = nil;
    [super dealloc];
}


@end
