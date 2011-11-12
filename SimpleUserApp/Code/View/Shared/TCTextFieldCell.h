#import "TCFormCell.h"
@class TCEditingNavigationBar;

@interface TCTextFieldCell : TCFormCell{
    UITextField         *textField;
}

@property (nonatomic, retain)    UITextField         *textField;

- (id) initWithPlaceHolder:(NSString*) placeHolder;
- (void) setEditingNavigationBar:(TCEditingNavigationBar*) bar;

@end
