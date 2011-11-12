#import "TCFormCell.h"

@implementation TCFormCell

- (id) init{
    return [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
}

- (void) layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.backgroundView.frame;
    frame.origin.x -= 3;
    frame.size.width += 7;
    self.backgroundView.frame = frame;
    
    frame = self.selectedBackgroundView.frame;
    frame.origin.x -= 3;
    frame.size.width += 7;
    self.selectedBackgroundView.frame = frame;
    
    frame = self.contentView.frame;
    frame.origin.x -= 3;
    frame.size.width += 7;
    self.contentView.frame = frame;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (UIView*) nextFieldAfterField:(UIView*) v{
    return nil;
}

@end
