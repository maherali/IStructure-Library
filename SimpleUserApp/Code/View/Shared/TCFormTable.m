#import "TCFormTable.h"
#import "TCFormCell.h"
#import "UIView+TripCase.h"

@implementation TCFormTable

@synthesize title, cells;

- (id)init{
	self = [super initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
	self.delegate           = self;
	self.dataSource         = self;
    self.backgroundColor    = [UIColor clearColor];
    self.separatorStyle     = UITableViewCellSeparatorStyleSingleLine;
    self.separatorColor     = [UIColor lightGrayColor];
	return self;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 35;
}

- (NSInteger) numberOfRowsInSection:(NSInteger)section{
    return cells.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self numberOfRowsInSection:section];
}

- (TCFormCell*) formCellAtIndexPath:(NSIndexPath *)indexPath {
    return [cells objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self formCellAtIndexPath:indexPath];
}

- (TCFormCell*) findCell:(BOOL) previous ofCell:(TCFormCell*) before location:(int*) loc{
    int curr = 0;
    for(int i=0; i< cells.count; i++){
        TCFormCell *cell = [cells objectAtIndex:i];
        if(before == cell){
            break;
        }
        curr++;
    }
    if(previous) curr--; else curr++;
    *loc = curr;
    if((curr >= 0) && (curr< cells.count)){
        return [cells objectAtIndex:curr];
    }else{
        return nil;
    }
}

- (void) movePrevious:(BOOL) previous{
    UIView *responder = [self findFirstResponder];   
    for(TCFormCell *formCell in cells){
        int location = 0;
        if([formCell hasView:responder]){
            UIView *nextView = [formCell nextFieldAfterField:responder];
            if(nextView){
                [nextView becomeFirstResponder];
            }else{
                TCFormCell *previousCell = [self findCell:previous ofCell:formCell location:&location];
                nextView = [previousCell nextFieldAfterField:nil];
                [nextView becomeFirstResponder];
            }
            @try {
                NSLog(@"Location %d", location);
                [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:location inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
            }
            @catch (NSException *exception) {
                
            }
        }
    }
}

- (void) moveToPrevious{
    [self movePrevious:YES];
}

- (void) moveToNext{
    [self movePrevious:NO];
}

- (void) done{
    UIView *responder = [self findFirstResponder];  
    [responder resignFirstResponder];
}

- (void) dealloc{
	self.title          = nil;
	self.cells          = nil;
    [super dealloc];
}

@end
