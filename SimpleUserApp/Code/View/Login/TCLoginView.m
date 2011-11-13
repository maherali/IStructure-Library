#import "TCLoginView.h"
#import "TCFormCell.h"
#import "TCTextFieldCell.h"
#import "TCLoginFooter.h"
#import "TCToggleFieldCell.h"
#import "LoadingView.h"
#import "TCUIFactory.h"

@implementation TCLoginView

- (id) initWithOptions:(NSDictionary *) _options{
    self = [super initWithOptions:_options];
    self.sectionHeaderHeight = 5;
    TCEditingNavigationBar *bar = [[[TCEditingNavigationBar alloc] init] autorelease];
    bar.delegate              = self;
    __block TCTextFieldCell   *userNameCell = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Username"] autorelease];
    userNameCell.textField.text = [self.model get:@"user_name"];
    userNameCell.textField.keyboardType = UIKeyboardTypeEmailAddress;
    userNameCell.textField.delegate = self;
    [userNameCell setEditingNavigationBar:bar];
    __block TCTextFieldCell   *passwordCell = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Password"] autorelease];
    passwordCell.textField.delegate = self;
    passwordCell.textField.secureTextEntry = YES;
    passwordCell.textField.text = [self.model get:@"password"];
    [passwordCell setEditingNavigationBar:bar];
    passwordCell.textField.returnKeyType  = UIReturnKeyDone;
    TCToggleFieldCell   *rememberMeCell = [[[TCToggleFieldCell alloc] init] autorelease];
    BOOL rememberMe = [[self.model get:@"remember_me"] isEqualToString:@"YES"];
    rememberMeCell.checked = rememberMe;
    self.cells = $array(userNameCell, passwordCell, rememberMeCell);
    
    __block TCLoginView *this = self;
    $watch(@"signin_button:tapped", ^(NSNotification *notif){
        if([this.model set:$dict(@"user_name", userNameCell.textField.text?userNameCell.textField.text:@"", @"password", passwordCell.textField.text?passwordCell.textField.text:@"", @"remember_me", rememberMeCell.checked?@"YES":@"NO")
               withOptions:[TCUIFactory commonSetOptions]]){
            $trigger(@"initiate:login");
        }
    });
    $watch(@"start_signup_button:tapped", ^(NSNotification *notif){
        $trigger(@"start:register");
    });
    __block LoadingView *loadingView = nil;
    $watch(@"login:begin", ^(NSNotification *notif){
        loadingView = [LoadingView loadingViewInView:this.window];
    });
    $watch(@"login:end", ^(NSNotification *notif){
        [loadingView performSelector:@selector(removeView) withObject:nil afterDelay:0];
    });
    $watch(@"reload_data", this, ^(NSNotification *notif){
        userNameCell.textField.text    = [self.model get:@"user_name"];
        passwordCell.textField.text    = [self.model get:@"password"];
        BOOL rememberMe                = [[self.model get:@"remember_me"] isEqualToString:@"YES"];
        rememberMeCell.checked         = rememberMe;
    });
    
    return self;
}

- (void) reloadData{
    __block TCLoginView *this = self;
    $trigger(@"reload_data");
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 100;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == ((TCTextFieldCell*)[cells objectAtIndex:1]).textField){
        [self done];
    }else{
        [self moveToNext];
    }
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 170;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    __block TCLoginView *this = self;
    UIView *loginFooter = [[[TCLoginFooter alloc] initWithFrame:CGRectMake(0, 0, 320, 170) andModel:self.model] autorelease];
    $unwatch(@"tnc_link:tapped");
    $watch(@"tnc_link:tapped", loginFooter, ^(NSNotification *notif){
        $trigger(@"start:tnc");
    });
    return loginFooter;
}

@end
