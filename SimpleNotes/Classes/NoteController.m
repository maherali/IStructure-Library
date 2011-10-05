#import "NoteController.h"
#import "NoteView.h"
#import "Note.h"

@implementation NoteController

- (id) initWithValues:(NSDictionary*) passedInValues andStyle:(UITableViewStyle) style{
    self = [super initWithValues:passedInValues andStyle:style];
    __block NoteController *this = self;
    $watch(@"note:title:selected", ^(NSNotification *notif){
        $navigate($sprintf(@"/notes/%@/edit", this.model.id), $dict(MODEL_KEY, this.model, @"attr_name", @"title"));
    });
    $watch(@"change", this.model, ^(NSNotification *notif){
        this.navigationItem.rightBarButtonItem.enabled = YES;
    });
    return self;
}
- (void) viewDidLoad{
    self.tableView = [[[NoteView alloc] initWithOptions:$dict(MODEL_KEY, self.model) 
                                               andStyle:UITableViewStyleGrouped] autorelease];
    self.title = [self.options objectForKey:@"title"] ? [self.options objectForKey:@"title"] : @"Note";
    UIBarButtonItem *savebutton = [[[UIBarButtonItem alloc] 
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)] autorelease];
	self.navigationItem.rightBarButtonItem = savebutton;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    if([self.model hasChanged:@"title"]){
        self.navigationItem.rightBarButtonItem.enabled = YES;    
    }
}

- (void) save{
    __block NoteController *this = self;
    this.navigationItem.rightBarButtonItem.enabled = NO;
    if([this.model isNew]){
        [this.model.collection createModel:model withOptions:$dict(AT_KEY, $object(0), SUCCESS_HANDLER_KEY, $block(^(Note *newNote, NSData *data){
            [this.navigationController popViewControllerAnimated:YES];
        }), FAILURE_HANDLER_KEY, $block(^(Note *newNote, NSArray *errors){
            this.navigationItem.rightBarButtonItem.enabled = YES;
            [UIAlertView errors:errors];
        }))];
    }else{
        [this.model save:$dict(SUCCESS_HANDLER_KEY, $block(^(Note *newNote, NSData *data){
            [this.navigationController popViewControllerAnimated:YES];
        }), FAILURE_HANDLER_KEY, $block(^(Note *newNote, NSArray *errors){
            this.navigationItem.rightBarButtonItem.enabled = YES;
            [UIAlertView errors:errors];
        }))];
    }
}

+ (void) load{
    __block Class this = self;
    $routec(@"/notes/:id");
}

@end
