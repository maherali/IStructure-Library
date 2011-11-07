#import "NotesStatsService.h"

static NotesStatsService   *singleton = nil;

@implementation NotesStatsService

@synthesize observers;

- (id) intWithOptions:(NSDictionary*) options{
    self = [super initWithFrame:CGRectMake(0, 460, 320, 20)];
    self.observers = $marray();
    ISCollection *collection = [options objectForKey:COLLECTION_KEY];
    self.backgroundColor = [UIColor cyanColor];
    __block NotesStatsService *this = self;
    $watch(@"fetching:begin", collection, ^(NSNotification *notif){
        UILabel *lbl = (UILabel*)[this viewWithTag:1234];
        lbl.text = @"Fetching notes...";
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1f];
        this.transform = CGAffineTransformMakeTranslation(0, 0);
        [UIView commitAnimations];
    });
    $watch(@"fetching:end", collection, ^(NSNotification *notif){
        UILabel *lbl = (UILabel*)[this viewWithTag:1234];
        lbl.text = $sprintf(@"You have %d notes!", [collection length]);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:10.0f];
        this.transform = CGAffineTransformMakeTranslation(0, 480);
        [UIView commitAnimations];
    });
    UILabel *lbl = [[[UILabel alloc] initWithFrame:CGRectMake(20, 1, 200, 20)] autorelease];
    lbl.text = @"Fetching notes...";
    lbl.font = [UIFont boldSystemFontOfSize:14];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor redColor];
    lbl.tag = 1234;
    [self addSubview:lbl];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    
    lbl = (UILabel*)[this viewWithTag:1234];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    this.transform = CGAffineTransformMakeTranslation(0, 480);
    [UIView commitAnimations];
    
    return self;
}

+ (void) startWithOptions:(NSDictionary*) options{
    singleton = singleton ? singleton : [[self alloc] intWithOptions:options];
}

+ (void) stopWithOptions:(NSDictionary*) options{
    [singleton removeFromSuperview];
    [singleton release];
    singleton = nil;
}

+ (void) load{
    __block Class this = self;
    $register(@"stats");
}

- (void) dealloc{
    __block NotesStatsService *this = self;
    $unwatch();
    self.observers = nil;
    [super dealloc];
}

@end
