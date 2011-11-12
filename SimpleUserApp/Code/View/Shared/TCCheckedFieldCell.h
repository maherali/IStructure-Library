#import "TCFormCell.h"
#import "TCCheckBoxView.h"

@interface TCCheckedFieldCell : TCFormCell<TCCheckBoxViewDelegate>

- (id) initWithText:(NSString*) text;

@end
