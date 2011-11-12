#import "TCLoginView.h"
#import "TCFormCell.h"
#import "TCTextFieldCell.h"
#import "TCLoginFooter.h"
#import "TCToggleFieldCell.h"
#import "LoadingView.h"

@implementation TCLoginView

- (id) initWithOptions:(NSDictionary *) _options{
    self = [super initWithOptions:_options];
    self.sectionHeaderHeight = 5;
    TCEditingNavigationBar *bar = [[[TCEditingNavigationBar alloc] init] autorelease];
    bar.delegate              = self;
    __block TCTextFieldCell   *cell1 = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Username"] autorelease];
    cell1.textField.text = [self.model get:@"user_name"];
    cell1.textField.delegate = self;
    [cell1 setEditingNavigationBar:bar];
    __block TCTextFieldCell   *cell2 = [[[TCTextFieldCell alloc] initWithPlaceHolder:@"Password"] autorelease];
    cell2.textField.delegate = self;
    cell2.textField.secureTextEntry = YES;
    cell2.textField.text = [self.model get:@"password"];
    [cell2 setEditingNavigationBar:bar];
    cell2.textField.returnKeyType  = UIReturnKeyDone;
    TCToggleFieldCell   *cell3 = [[[TCToggleFieldCell alloc] init] autorelease];
    self.cells = [NSArray arrayWithObjects:cell1, cell2, cell3, nil];
    
    __block TCLoginView *this = self;
    $watch(@"signin_button:tapped", ^(NSNotification *notif){
        [this.model set:$dict(@"user_name", cell1.textField.text, @"password", cell2.textField.text)];
        $trigger(@"initiate:login");
    });
    
    $watch(@"start_signup_button:tapped", ^(NSNotification *notif){
        $trigger(@"start:register");
    });
    
    __block LoadingView *loadingView = nil;
    $watch(@"internet:begin", ^(NSNotification *notif){
        loadingView = [LoadingView loadingViewInView:this];
    });
    
    $watch(@"internet:end", ^(NSNotification *notif){
        [loadingView performSelector:@selector(removeView) withObject:nil afterDelay:0];
    });

    return self;
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
    return [[[TCLoginFooter alloc] initWithFrame:CGRectMake(0, 0, 320, 170) andModel:self.model] autorelease];
}

// receive the login button was clicked, get the remember me state and the user/pass and trigger
// should update the session model and trigger
// someone must observer the session model 

@end
