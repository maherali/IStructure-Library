#import "TCCheckedFieldCell.h"

@implementation TCCheckedFieldCell

- (id) initWithText:(NSString*) text{
    self = [super init];
    TCCheckBoxView  *checkBoxView = [[[TCCheckBoxView alloc] initWithFrame:CGRectMake(10, 7, 0, 0) delegate:self andContext:nil] autorelease];
    [self.contentView addSubview:checkBoxView];
    UILabel *lbl = [[[UILabel alloc] initWithFrame:CGRectMake(45, 11, 250, 20)] autorelease];
    lbl.text = text;
    lbl.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:lbl];
    return self;
}

- (void) stateChanged:(BOOL) checked forContext:(NSString*) context{
    
}

@end
