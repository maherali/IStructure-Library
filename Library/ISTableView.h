@class ISModel;
@class ISCollection;

@interface ISTableView : UITableView<UITableViewDelegate, UITableViewDataSource>{
    ISModel             *model;
    ISCollection        *collection;
    NSDictionary        *options;
    NSMutableArray      *observers;
}

@property (retain) NSMutableArray   *observers;
@property (retain) ISModel          *model;
@property (retain) ISCollection     *collection;
@property (retain) NSDictionary     *options;

- (id) initWithOptions:(NSDictionary*) _options andStyle:(UITableViewStyle) style;
- (id) initWithOptions:(NSDictionary*) _options;

@end
