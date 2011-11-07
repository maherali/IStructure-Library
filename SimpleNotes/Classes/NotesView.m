#import "NotesView.h"
#import "Note.h"

@implementation NotesView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.editing ? [collection length] + 1 : [collection length];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    if(self.editing && indexPath.row == 0){
        cell.editingAccessoryType   = UITableViewCellAccessoryNone;
        cell.accessoryType          = UITableViewCellAccessoryNone;
        cell.textLabel.text         = @"Add a note";
        cell.detailTextLabel.text   = @"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell.editingAccessoryType   = UITableViewCellAccessoryNone;
        cell.accessoryType          = UITableViewCellAccessoryDisclosureIndicator;
        Note *note                  = (Note*)[self.collection at:self.editing?(indexPath.row-1):indexPath.row];
        cell.textLabel.text         = [note description];
        cell.detailTextLabel.text   = [note lastUpdated];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return UITableViewCellEditingStyleInsert;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate{
    [super setEditing:editing animated:animate];
    [self reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [options objectForKey:@"section_header_title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __block NotesView *this = self;
    $trigger(@"note:selected", $dict(@"note", $object(indexPath.row)));
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    __block NotesView *this = self;
    if(indexPath.row == 0){
        $trigger(@"note:add", $dict());
    }else{
        $trigger(@"note:delete", $dict(@"note", $object(indexPath.row-1)));
    }
}

@end
