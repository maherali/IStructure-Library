#import "NoteView.h"

@implementation NoteView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __block NoteView *this = self;
    switch (indexPath.row) {
        case 0:
            $trigger(@"note:title:selected");
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            UILabel *view = [[[UILabel alloc] initWithFrame:CGRectMake(50, 0, 320, 30)] autorelease];
            view.font = [UIFont boldSystemFontOfSize:18];
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = UITextAlignmentCenter;
            view.textColor = [UIColor darkGrayColor];
            view.text = @"Title";
            return view;
        }
    }   
    return nil;
}

@end
