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
    [self.contentView addSubview:rm];
    return self;
}

- (void) switchOnOff:(UISwitch*) toggle{
    self.checked = toggle.on; 
}

@end
