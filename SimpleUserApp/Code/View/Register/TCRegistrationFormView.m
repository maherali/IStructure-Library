#import "TCRegistrationFormView.h"
#import "TCFormCell.h"
#import "TCTextFieldCell.h"
#import "TCCheckedFieldCell.h"
#import "TCRegistrationFooter.h"

@implementation TCRegistrationFormView

- (id)init{
    self = [super init];
    self.sectionHeaderHeight = 5;
    TCEditingNavigationBar *bar = [[[TCEditingNavigationBar alloc] init] autorelease];
    bar.delegate              = self;
    TCTextFieldCell   *cell1 = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"First Name"] autorelease];
    cell1.textField.delegate = self;
    [cell1 setEditingNavigationBar:bar];
    TCTextFieldCell   *cell2 = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Last Name"] autorelease];
    cell2.textField.delegate = self;
    [cell2 setEditingNavigationBar:bar];
    TCTextFieldCell   *cell3 = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Email"] autorelease];
    cell3.textField.delegate = self;
    cell3.textField.keyboardType = UIKeyboardTypeEmailAddress;
    [cell3 setEditingNavigationBar:bar];
    TCTextFieldCell   *cell4 = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Password"] autorelease];
    cell4.textField.delegate = self;
    cell4.textField.secureTextEntry = YES;
    [cell4 setEditingNavigationBar:bar];
    TCTextFieldCell   *cell5 = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Password Conformation"] autorelease];
    cell5.textField.delegate = self;
    cell5.textField.secureTextEntry = YES;
    [cell5 setEditingNavigationBar:bar];
    TCTextFieldCell   *cell6 = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Promo Code (optional)"] autorelease];
    cell6.textField.delegate = self;
    cell6.textField.returnKeyType  = UIReturnKeyDone;
    [cell6 setEditingNavigationBar:bar];
    
    TCCheckedFieldCell   *cell7 = [[[TCCheckedFieldCell alloc] initWithText:@"Sign me up for the TripCase newsletter"] autorelease];
    TCCheckedFieldCell   *cell8 = [[[TCCheckedFieldCell alloc] initWithText:@"Sign me up for product updates"] autorelease];
 
    self.cells = [NSArray arrayWithObjects:cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8, nil];
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[[TCRegistrationFooter alloc] initWithFrame:CGRectMake(0, 0, 320, 100)] autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == ((TCTextFieldCell*)[cells objectAtIndex:5]).textField){
        [self done];
    }else{
        [self moveToNext];
    }
    return NO;
}

@end
