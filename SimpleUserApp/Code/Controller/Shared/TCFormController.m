#import "TCFormController.h"
#import "TCFormTable.h"

@implementation TCFormController

- (id) initWithValues:(NSDictionary*) passedInValues andStyle:(UITableViewStyle) style{
    self = [super initWithValues:passedInValues andStyle:style];
    return self;
}

- (Class) formTableClass{
    return [TCFormTable class];
}

-(void)viewDidLoad {
	[super viewDidLoad];
	self.tableView = [[[[self formTableClass] alloc] initWithOptions:$dict(COLLECTION_KEY, collection)] autorelease];
}

@end
