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
	self.tableView = [[[[self formTableClass] alloc] initWithOptions:$dict(COLLECTION_KEY, collection)] autorelease];
}

@end
