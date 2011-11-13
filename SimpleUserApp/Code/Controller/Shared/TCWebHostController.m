#import "TCWebHostController.h"
#import "TCWebHostView.h"


@interface TCWebHostController ()

- (void) setupWebViewNavButtons;
- (void) setupToolbarAppearance;
- (BOOL) needAToolBar;

@end

@implementation TCWebHostController

@synthesize mainView, url, donotScale;

- (id)initWithValues:(NSDictionary*) _passedInValues{
    self = [super initWithValues:_passedInValues];
    if(self){
        self.url    = [self.options objectForKey:@"URL"];
    }
    return self;
}

- (void)loadView {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
	UIView  *contentView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)] autorelease];
    contentView.backgroundColor = [UIColor clearColor];
	contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.mainView = [[[TCWebHostView alloc] initWithOptions:$dict()] autorelease];
	[contentView addSubview:mainView];
  	self.view = contentView;
    
    __block TCWebHostController *this = self;
    $unwatch(@"web_finished_loading");
    $watch(@"web_finished_loading", this.mainView, ^(NSNotification *notif) {
        [this setupWebViewNavButtons];
    });
    
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
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationItem.rightBarButtonItem  = nil;
    [self.navigationController setToolbarHidden:YES animated:NO];
}
 
- (void) setupToolbarAppearance{
    if([self needAToolBar]){
        [self.navigationController setToolbarHidden:NO animated:NO];
        mainView.frame = CGRectMake(0, 0, 320, 375);
    }else{
        [self.navigationController setToolbarHidden:YES animated:NO];
        mainView.frame = CGRectMake(0, 0, 320, 415);
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
        self.toolbarItems = $array(space2, bkButton, space, fwdButton, space);
    }else if (bkEnabled && !fwdEnabled){
        self.toolbarItems = $array(space2, bkButton, space, space2);
    }else if (!bkEnabled && fwdEnabled){
        self.toolbarItems = $array(space2, space2, space, fwdButton);
    }else{
        self.toolbarItems = nil;
    }
    [self setupToolbarAppearance];
}


- (void)dealloc {
    self.mainView.delegate      =   nil;
    self.mainView               =   nil;
	self.url                    =   nil;
 	[super dealloc];
}

+ (void) load{
    __block Class this = self;
    $routec(@"/www");
}

@end
