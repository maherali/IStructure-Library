#import "LineEditView.h"

@implementation LineEditView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
        UITextField *textField = [[[UITextField alloc] initWithFrame:CGRectMake(5, 5, 290, 20)] autorelease];
        textField.tag = 1234;
        [cell.contentView addSubview:textField];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } 
    UITextField *textField = (UITextField*)[cell.contentView viewWithTag:1234];
    [textField setReturnKeyType:UIReturnKeyDone];
    [textField addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    NSString *attrName = [self.options objectForKey:@"attr_name"];
    textField.text = [model get:attrName];
    [textField becomeFirstResponder];
    return cell;
}

- (IBAction)textFieldFinished:(UITextField*)sender{
    __block LineEditView *this = self;
    $trigger(@"value:available", $dict(@"value", sender.text));
    [sender resignFirstResponder];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            UILabel *view = [[[UILabel alloc] initWithFrame:CGRectMake(50, 0, 320, 30)] autorelease];
            view.font = [UIFont boldSystemFontOfSize:18];
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = UITextAlignmentCenter;
            view.textColor = [UIColor darkGrayColor];
            view.text = [[self.options objectForKey:@"attr_name"] capitalizedString];
            return view;
        }
    }   
    return nil;
}

@end
