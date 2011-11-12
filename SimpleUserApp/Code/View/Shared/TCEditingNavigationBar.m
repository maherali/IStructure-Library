#import "TCEditingNavigationBar.h"

@implementation TCEditingNavigationBar

@synthesize keyboardToolbar, nextPreviousControl, delegate;

- (id) init{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)];
 
    self.keyboardToolbar        = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    keyboardToolbar.barStyle    = UIBarStyleBlackTranslucent;
    keyboardToolbar.tintColor   = [UIColor darkGrayColor];
    
    UIBarButtonItem *barButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard:)] autorelease];
    barButtonItem.tintColor        = [UIColor blueColor];
    UIBarButtonItem *flex          = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    
    self.nextPreviousControl = [[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Previous", @"Next", nil]] autorelease];
    nextPreviousControl.segmentedControlStyle = UISegmentedControlStyleBar;
    nextPreviousControl.tintColor = [UIColor darkGrayColor];
    nextPreviousControl.momentary = YES;
    [nextPreviousControl addTarget:self action:@selector(nextPrevious:) forControlEvents:UIControlEventValueChanged];     
    
    UIBarButtonItem *controlItem = [[[UIBarButtonItem alloc] initWithCustomView:nextPreviousControl] autorelease];
    NSArray *items = [[[NSArray alloc] initWithObjects:controlItem, flex, barButtonItem, nil] autorelease];
    [keyboardToolbar setItems:items];
    [self addSubview:keyboardToolbar];
    return self;
}

- (void) dismissKeyboard:(id) v{
    [self.delegate done];
}

- (void) nextPrevious:(UISegmentedControl*) sender{
    (sender.selectedSegmentIndex == 0) ? [self moveToPrevious] : [self moveToNext];
}

- (void) moveToNext{
    [self.delegate moveToNext];
}

- (void) moveToPrevious{
    [self.delegate moveToPrevious];
}

- (void) dealloc{
    self.keyboardToolbar        =   nil;
    self.nextPreviousControl    =   nil;
    [super dealloc];
}

@end
