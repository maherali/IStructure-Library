#import "AppFacadeService.h"
#import "PlacesController.h"

static AppFacadeService    *singleton  = nil;

@implementation AppFacadeService

@synthesize observers, navigationController;

- (id) intWithOptions:(NSDictionary*) options{
    self = [super init];
    self.observers      = $marray();
    UIWindow *window    = [options objectForKey:@"window"];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:
                                  [[[PlacesController alloc] initWithValues:$dict()] autorelease]]autorelease];
	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
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
    __block AppFacadeService *this  = self;
    $unwatch();
    self.observers                  =   nil;
    self.navigationController       =   nil;
    [super dealloc];
}

@end
