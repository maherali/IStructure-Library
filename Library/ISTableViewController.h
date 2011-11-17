@class ISModel;
@class ISCollection;

@interface ISTableViewController : UITableViewController{
    NSMutableArray      *observers;
    ISModel             *model;
    ISCollection        *collection;
    NSDictionary        *options;
    NSDictionary        *params;
}

@property (retain) NSMutableArray   *observers;
@property (retain) ISModel          *model;
@property (retain) ISCollection     *collection;
@property (retain) NSDictionary     *options;
@property (retain) NSDictionary     *params;
@property (assign) UITableViewStyle style;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andValues:(NSDictionary*) passedInValues;
- (id) initWithValues:(NSDictionary*) passedIn andStyle:(UITableViewStyle) style;
- (id) initWithValues:(NSDictionary*) passedIn;
- (void) initialize:(NSDictionary*) values;
- (NSDictionary*) routes;
- (void) configureTableView;

@end
