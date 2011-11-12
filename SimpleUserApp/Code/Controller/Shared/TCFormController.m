#import "TCFormController.h"
#import "TCFormView.h"

@implementation TCFormController

- (id) initWithValues:(NSDictionary*) passedInValues andStyle:(UITableViewStyle) style{
    self = [super initWithValues:passedInValues andStyle:style];
    return self;
}

- (Class) formTableClass{
    return [TCFormView class];
}

-(void)viewDidLoad {
	[super viewDidLoad];
    NSMutableDictionary *dict = $mdict();
    if(collection){
        [dict setObject:collection forKey:COLLECTION_KEY];
    }
    if(model){
        [dict setObject:model forKey:MODEL_KEY];
    }
	self.tableView = [[[[self formTableClass] alloc] initWithOptions:dict] autorelease];
}

@end
