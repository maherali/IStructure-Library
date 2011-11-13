#import "NewMessageViewerPresenter.h"
#import "NewMessageViewerView.h"
#import "SimpleTextAndTableAlertView.h"
#import "ServerProxy.h"
#import "MainPresenter.h"

@implementation NewMessageViewerPresenter

@synthesize mainView, url, delegate, donotScale, messageIndex, hasAContinueFunctionality;

-(id)initWithTheUrl:(NSString *)_url{
	if((self = [super init])){
		self.url            = _url;
        okToShowContinue    = YES;
	}
    return self;
}

- (void) tellDelegate{
    [self.delegate postShowingPreCondition:messageIndex withWebView:self.mainView from:self];
}

- (void)loadView {
	self.navigationItem.titleView = [UIFactory logo];
	UIView  *contentView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)] autorelease];
    contentView.backgroundColor = [UIColor clearColor];
	contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.mainView = [[[NewMessageViewerView alloc] initWithPresenter:self] autorelease];
	[contentView addSubview:mainView];
  	self.view = contentView;
    [self.mainView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

-(void) viewDidLoad{
    [super viewDidLoad];
    self.toolbarItems = nil;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupToolbarAppearance];
    if(hasAContinueFunctionality){
        [self assignAContinueButton];
    }
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    okToShowContinue = NO;
    self.navigationItem.rightBarButtonItem  = nil;
    [self.navigationController setToolbarHidden:YES animated:NO];
}
 
- (void) setupToolbarAppearance{
    if([self needAToolBar]){
        [self.navigationController setToolbarHidden:NO animated:NO];
        mainView.frame = CGRectMake(0, 0, 320, 328);
    }else{
        [self.navigationController setToolbarHidden:YES animated:NO];
        mainView.frame = CGRectMake(0, 0, 320, 368);
    }    
}

- (void) bkwd{
    [self.mainView goBack];
}

- (void) fwd{
    [self.mainView goForward];
}

- (BOOL) needAToolBar{
    return [mainView canGoBack] || [mainView canGoForward];
}

- (void)setupWebViewNavButtons{
	BOOL bkEnabled;
    BOOL fwdEnabled;
    if([mainView canGoBack]){
        bkEnabled = YES;
    }else{
        bkEnabled = NO;
    }
    if([mainView canGoForward]){
        fwdEnabled = YES;
    }else{
        fwdEnabled = NO;
    }
    UIBarButtonItem *space2 = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL] autorelease];
    UIBarButtonItem *space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL] autorelease];
    space.width = 170;
    space2.width = 30;
    
    UIBarButtonItem *bkButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(bkwd)] autorelease];
    UIBarButtonItem *fwdButton  = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"next.png"] style:UIBarButtonItemStylePlain target:self action:@selector(fwd)] autorelease];
    
    if(bkEnabled && fwdEnabled){
        self.toolbarItems = [NSArray arrayWithObjects:
                             space2,
                             bkButton,
                             space,
                             fwdButton,
                             space,
                             nil
                             ];
    }else if (bkEnabled && !fwdEnabled){
        self.toolbarItems = [NSArray arrayWithObjects:
                             space2,
                             bkButton, space, space2,
                             nil
                             ];        
    }else if (!bkEnabled && fwdEnabled){
        self.toolbarItems = [NSArray arrayWithObjects:
                             space2, space2, space, 
                             fwdButton,
                             nil
                             ];     
    }
    else{
        self.toolbarItems = nil;
    }
    [self setupToolbarAppearance];
    if(!bkEnabled && hasAContinueFunctionality){
        [self assignAContinueButton];
    }	
}

- (void) assignAContinueButton{
    self.navigationItem.rightBarButtonItem  = [[[UIBarButtonItem alloc] initWithTitle:@"Continue" style:UIBarButtonItemStyleDone target:self action:@selector(tellDelegate)] autorelease];
}

- (void) hideContinueButton{
    self.navigationItem.rightBarButtonItem  = nil;
}

- (void)dealloc {
    self.delegate               = nil;
    self.mainView.delegate      = nil;
    self.mainView               = nil;
	self.url                    = nil;
	[super dealloc];
}


@end
