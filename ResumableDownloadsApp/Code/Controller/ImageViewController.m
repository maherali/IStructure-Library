#import "ImageViewController.h"
#import "MyModel.h"

@implementation ImageViewController

@synthesize imageView;

- (id) initWithValues:(NSDictionary*) _passedIn{
    self = [super initWithNibName:@"ImageViewController" bundle:nil andValues:_passedIn];
    return self;
}

- (void) viewDidLoad{
    [super viewDidLoad];
    MyModel *m = (MyModel*)[self.options objectForKey:MODEL_KEY];
    imageView.image = m.image;
    __block ImageViewController *this = self;
    $watch(@"change", m, ^(NSNotification *notif){
        this.imageView.image = m.image;
    });
}

- (void)dealloc {
    self.imageView  =   nil;
    [super dealloc];
}

+ (void) load{
    __block Class this = self;
    $routec(@"/show_image");
}

@end
