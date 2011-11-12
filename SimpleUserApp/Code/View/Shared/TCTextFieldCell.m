#import "TCTextFieldCell.h"
#import "TCEditingNavigationBar.h"

@implementation TCTextFieldCell

@synthesize textField;

- (id) initWithPlaceHolder:(NSString*) placeHolder{
    self = [super init];
    self.textField                  = [[[UITextField alloc] initWithFrame:CGRectMake(10,10,300,20)] autorelease];
	textField.tag                   = placeHolder.hash;
	textField.placeholder           = placeHolder;
	textField.clearButtonMode       = UITextFieldViewModeWhileEditing;
	textField.autocorrectionType    = UITextAutocorrectionTypeNo;
    textField.returnKeyType         = UIReturnKeyNext;
    [self.contentView addSubview:textField];
    return self;
}

- (void) setEditingNavigationBar:(TCEditingNavigationBar*) bar{
    textField.inputAccessoryView    = bar;
}

- (void) dealloc{
    self.textField  =   nil;
    [super dealloc];
}

- (UIView*) nextFieldAfterField:(UIView*) v{
    if(!v){
        return textField;
    }
    return nil;
}

@end
