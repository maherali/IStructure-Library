#import "SimpleTableController.h"
#import "MyModel.h"

@implementation SimpleTableController

@synthesize cell;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andValues:(NSDictionary *)passedInValues{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil andValues:passedInValues];
    MyModel *m = [[[MyModel alloc] initWithAttributes:$dict() andOptions:$dict()] autorelease];
    self.collection = [[[ISCollection alloc] initWithModels:$array(m)] autorelease];
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
    MyModel *m = (MyModel*)[self.collection at:indexPath.row];
    [theCell configureCellWithModel:m];
    __block SimpleTableController *this = self;
    $watch(@"resume_loading", theCell, ^(NSNotification *notif){
        MyModel *passedModel = [notif.userInfo objectForKey:MODEL_KEY];
        [this fetchModel:passedModel];
    });
    $watch(@"stop_loading", theCell, ^(NSNotification *notif){
        MyModel *passedModel = [notif.userInfo objectForKey:MODEL_KEY];
        [passedModel cancel];
    });
   
    return theCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
