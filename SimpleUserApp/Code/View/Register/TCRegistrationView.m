#import "TCRegistrationView.h"
#import "TCFormCell.h"
#import "TCTextFieldCell.h"
#import "TCCheckedFieldCell.h"
#import "TCRegistrationFooter.h"
#import "TCUIFactory.h"
#import "LoadingView.h"

@implementation TCRegistrationView

- (id) initWithOptions:(NSDictionary *) _options{
    self = [super initWithOptions:_options];
    self.sectionHeaderHeight = 5;
    TCEditingNavigationBar *bar = [[[TCEditingNavigationBar alloc] init] autorelease];
    bar.delegate              = self;
    
    TCTextFieldCell   *cell1 = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Email"] autorelease];
    cell1.textField.delegate = self;
    cell1.textField.text     = [self.model get:@"email"];
    cell1.textField.keyboardType = UIKeyboardTypeEmailAddress;
    [cell1 setEditingNavigationBar:bar];
    TCTextFieldCell   *cell2 = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Password"] autorelease];
    cell2.textField.delegate = self;
    cell2.textField.secureTextEntry = YES;
    [cell2 setEditingNavigationBar:bar];
    TCTextFieldCell   *cell3 = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Password Conformation"] autorelease];
    cell3.textField.delegate = self;
    cell3.textField.secureTextEntry = YES;
    [cell3 setEditingNavigationBar:bar];
    
    self.cells = [NSArray arrayWithObjects:cell1, cell2, cell3, nil];
    
    __block TCRegistrationView *this = self;
    $watch(@"signup_button:tapped", ^(NSNotification *notif){
        if([this.model set:$dict(@"email", cell1.textField.text, @"password", cell2.textField.text?cell2.textField.text:@"", @"password_confirmation", cell3.textField.text?cell3.textField.text:@"") withOptions:[TCUIFactory commonSetOptions] ]){
            $trigger(@"initiate:register");
        }
    });
    __block TCRegistrationView *loadingView = nil;
    $watch(@"register:begin", ^(NSNotification *notif){
        loadingView = [LoadingView loadingViewInView:this.window];
    });
    
    $watch(@"register:end", ^(NSNotification *notif){
        [loadingView performSelector:@selector(removeView) withObject:nil afterDelay:0];
    });

    
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
    if(textField == ((TCTextFieldCell*)[cells objectAtIndex:2]).textField){
        [self done];
    }else{
        [self moveToNext];
    }
    return NO;
}

@end
