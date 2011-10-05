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

- (id) initWithValues:(NSDictionary*) _passedIn andStyle:(UITableViewStyle) style;
- (id) initWithValues:(NSDictionary*) _passedIn;
- (NSDictionary*) routes;


@end
