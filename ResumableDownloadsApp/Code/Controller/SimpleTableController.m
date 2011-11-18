#import "SimpleTableController.h"
#import "MyModel.h"

@implementation SimpleTableController

@synthesize cell;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andValues:(NSDictionary *)passedInValues{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil andValues:passedInValues];
    MyModel *m1 = [[[MyModel alloc] initWithAttributes:$dict(@"URL", @"http://edmullen.net/test/rc.jpg") andOptions:$dict()] autorelease];
    MyModel *m2 = [[[MyModel alloc] initWithAttributes:$dict(@"URL", @"http://www.nasa.gov/images/content/605011main_moon_946-710.jpg") andOptions:$dict()] autorelease];
    MyModel *m3 = [[[MyModel alloc] initWithAttributes:$dict(@"URL", @"http://cpartipilo.files.wordpress.com/2011/02/large_brown_bearkodiak.jpg") andOptions:$dict()] autorelease];
    self.collection = [[[ISCollection alloc] initWithModels:$array(m1, m2, m3)] autorelease];
    return self;
}

- (void) configureTableView { }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.collection length];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellID";
    SimpleCell *theCell = (SimpleCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (theCell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"SimpleCell" owner:self options:nil];
        theCell = self.cell;
    }
    [theCell configureCellWithModel:(MyModel*)[self.collection at:indexPath.row]];
    __block SimpleTableController *this = self;
    $unwatch(@"resume_loading", theCell);
    $unwatch(@"stop_loading", theCell);
    $watch(@"resume_loading", theCell, ^(NSNotification *notif){
        [this fetchModel:theCell.model];
    });
    $watch(@"stop_loading", theCell, ^(NSNotification *notif){
        [theCell.model cancel];
    });
    return theCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    MyModel *aModel = (MyModel*)[self.collection at:indexPath.row];
    [aModel removeResource];
    [aModel change];
}

- (void) fetchModel:(MyModel*) m{
    __block SimpleTableController *this = self;
    [m fetch:$dict(SUCCESS_HANDLER_KEY, $block(^(MyModel *model, NSData *data){
        [this.tableView reloadData];
    }), FAILURE_HANDLER_KEY, $block(^(MyModel *model, NSArray *errors){
        [UIAlertView errors:errors];
    }), CANCEL_HANDLER_KEY, $block(^(MyModel *model, NSArray *errors){
        [UIAlertView errors:errors];
    }))];
}

- (void) dealloc{
    self.cell = nil;
    [super dealloc];
}

@end
