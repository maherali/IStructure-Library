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
    bar.delegate                = self;
    TCTextFieldCell   *emailCell = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Email"] autorelease];
    emailCell.textField.delegate = self;
    emailCell.textField.text     = [self.model get:@"email"];
    emailCell.textField.keyboardType = UIKeyboardTypeEmailAddress;
    [emailCell setEditingNavigationBar:bar];
    TCTextFieldCell   *passwordCell = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Password"] autorelease];
    passwordCell.textField.delegate = self;
    passwordCell.textField.secureTextEntry = YES;
    [passwordCell setEditingNavigationBar:bar];
    TCTextFieldCell   *passwordConfCell = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Password Conformation"] autorelease];
    passwordConfCell.textField.delegate = self;
    passwordConfCell.textField.secureTextEntry = YES;
    [passwordConfCell setEditingNavigationBar:bar];
    self.cells = $array(emailCell, passwordCell, passwordConfCell);
    
    __block TCRegistrationView *this = self;
    $watch(@"signup_button:tapped", ^(NSNotification *notif){
        if([this.model set:$dict(@"email", emailCell.textField.text, @"password", passwordCell.textField.text?passwordCell.textField.text:@"", @"password_confirmation", passwordConfCell.textField.text?passwordConfCell.textField.text:@"") 
               withOptions:[TCUIFactory commonSetOptions] ]){
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
    __block TCRegistrationView *this = self;
    UIView *registrationFooter = [[[TCRegistrationFooter alloc] initWithFrame:CGRectMake(0, 0, 320, 100)] autorelease];
    $unwatch(@"tnc_link:tapped");
    $watch(@"tnc_link:tapped", registrationFooter, ^(NSNotification *notif){
        $trigger(@"start:tnc");
    });
    return registrationFooter;
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
