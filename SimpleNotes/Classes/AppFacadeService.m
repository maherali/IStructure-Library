#import "AppFacadeService.h"
#import "Notes.h"

static AppFacadeService    *singleton  = nil;

@implementation AppFacadeService

@synthesize navigationController;
@synthesize observers;

- (id) intWithOptions:(NSDictionary*) options{
    self = [super init];
    self.observers = $marray();
    NSString *baseURL = [[NSBundle mainBundle]  objectForInfoDictionaryKey:@"APP_URL"];
    [ISCollection   setBaseUrl:baseURL];
    [ISModel        setBaseUrl:baseURL];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:[[[UIViewController alloc] init] autorelease]] autorelease];
    UIWindow *window = [options objectForKey:@"window"];
	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    __block AppFacadeService *this = self;
    $start(@"net_state");
    $navigate(@"/notes", $dict(@"title", @"Simple Notes"));
    return self;
}

+ (void) startWithOptions:(NSDictionary*) options{
    singleton = singleton ? singleton : [[self alloc] intWithOptions:options];
}

+ (void) load{
    __block Class this = self;
    $register(@"app");
}

- (void) dealloc{
    __block AppFacadeService *this = self;
    $unwatch();
    self.observers              =   nil;
    self.navigationController   =   nil;
    [super dealloc];
}

@end
