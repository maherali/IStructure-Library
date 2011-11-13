#import "TCToggleFieldCell.h"

@implementation TCToggleFieldCell

@synthesize checked;

- (id) init{
    self = [super init];
    UILabel *lbl = [[[UILabel alloc] initWithFrame:CGRectMake(10, 11, 150, 20)] autorelease];
    lbl.text = @"Remember me";
    lbl.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:lbl];
    
    UISwitch *rm = [[[UISwitch alloc] initWithFrame:CGRectMake(220, 9, 0, 0)] autorelease];
    [rm addTarget:self action:@selector(switchOnOff:) forControlEvents:UIControlEventValueChanged];
    rm.tag = 12345;
    [self.contentView addSubview:rm];
    return self;
}

- (void) switchOnOff:(UISwitch*) toggle{
    checked = toggle.on; 
}

- (void) setChecked:(BOOL) _checked{
    UISwitch *rm =  (UISwitch*)[self.contentView viewWithTag:12345];
    rm.on = _checked;
}

@end
