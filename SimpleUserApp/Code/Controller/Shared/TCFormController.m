#import "TCFormController.h"
#import "TCFormTable.h"

@implementation TCFormController

- (id)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (Class) formTableClass{
    return [TCFormTable class];
}

-(void)viewDidLoad {
	[super viewDidLoad];
	self.tableView = [[[[self formTableClass] alloc] init] autorelease];
}

@end
