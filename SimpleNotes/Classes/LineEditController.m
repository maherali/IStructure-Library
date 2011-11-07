#import "LineEditController.h"
#import "Note.h"
#import "LineEditView.h"

@implementation LineEditController

- (id) initWithValues:(NSDictionary*) passedInValues andStyle:(UITableViewStyle) style{
    self = [super initWithValues:passedInValues andStyle:style];
    __block LineEditController *this = self;
    ValidationErrorHandler validationErrorHndlr = $block(^(id origin, NSArray *errors, NSDictionary* options){
        [UIAlertView errors:errors];
    });
    $watch(@"value:available", ^(NSNotification *notif){
        __block NSDictionary *attrs =   $dict([this.options objectForKey:@"attr_name"], [notif.userInfo objectForKey:@"value"]);
        __block NSDictionary *opts  =   $dict(VALIDATION_ERROR_HANDLER_KEY, validationErrorHndlr);
        if([this.model set:attrs withOptions:opts]){
            [this.navigationController popViewControllerAnimated:YES];
        }
    });
    return self;
}

- (void) viewDidLoad{
    self.tableView = [[[LineEditView alloc] initWithOptions:$dict(MODEL_KEY, self.model, @"attr_name", [self.options objectForKey:@"attr_name"]) andStyle:UITableViewStyleGrouped] autorelease];
    self.title = $sprintf(@"Edit %@", [[self.options objectForKey:@"attr_name"] capitalizedString]);
}

+ (void) load{
    __block Class this = self;
    $routec(@"/notes/:id/edit");
}

@end
