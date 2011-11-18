#import "NotesController.h"
#import "NoteView.h"
#import "NotesView.h"
#import "Notes.h"
#import "RefreshButton.h"
#import "Note.h"

@interface NotesController()
- (void) destroyNote:(Note*) note;
- (void) refreshNotes;
@end

@implementation NotesController

- (id) initWithValues:(NSDictionary*) passedInValues{
    self = [super initWithValues:passedInValues andStyle:UITableViewStylePlain];
    self.collection = [[[Notes alloc] initWithModels:nil] autorelease]; 
    __block NotesController *this = self;
    $watch(@"note:selected", ^(NSNotification *notif) {
        NSInteger row = [[notif.userInfo objectForKey:@"note"] intValue];
        $navigate($sprintf(@"/notes/%@", [[this.collection at:row] get:@"id"]), $dict(MODEL_KEY, [this.collection at:row]));
    });
    $watch(@"note:delete", ^(NSNotification *notif) {
        NSInteger row = [[notif.userInfo objectForKey:@"note"] intValue];
        Note *note = (Note*)[this.collection at:row];
        [this destroyNote:note];
    });
    $watch(@"note:add", ^(NSNotification *notif) {
        Note *aNote = [[[Note alloc] initWithAttributes:$dict() andOptions:$dict(COLLECTION_KEY, this.collection)] autorelease];
        $navigate($sprintf(@"/notes/%@", @"-1"), $dict(MODEL_KEY, aNote));
    });
    [self refreshNotes];
    return self;
}

- (void) destroyNote:(Note*) note{
    [note destroy:$dict(FAILURE_HANDLER_KEY, $block(^(Note *newNote, NSArray *errors){
        [UIAlertView errors:errors];
    }))];
}

- (void)refreshNotes{
    __block NotesController *this = self;
    $trigger(@"fetching:begin", $dict(), collection);
    [self.collection fetch:$dict(SUCCESS_HANDLER_KEY, $block(^(Notes *newCollection, NSData *data){
        $trigger(@"fetching:end", $dict(), this.collection);
    }), FAILURE_HANDLER_KEY, $block(^(Notes *newCollection, NSArray *errors){
        $trigger(@"fetching:end", $dict(), this.collection);
        [UIAlertView errors:errors];
    }))];
}

- (void) viewDidLoad{
    self.navigationItem.hidesBackButton = YES;
    NSString *headerTitle = @"Notes";
    self.tableView = [[[NotesView alloc] initWithOptions:$dict(COLLECTION_KEY, collection, @"section_header_title", headerTitle) 
                                                andStyle:UITableViewStylePlain] autorelease];
    self.title = [self.options objectForKey:@"title"] ? [self.options objectForKey:@"title"] : @"Notes";
    self.navigationItem.rightBarButtonItem = [RefreshButton buttonForCollection:self.collection target:self andAction:@selector(refreshNotes)];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    $stop(@"stats");
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    $start(@"stats", $dict(COLLECTION_KEY, collection));
}

+ (void) load{
    __block Class this = self;
    $routec(@"/notes");
}

@end
