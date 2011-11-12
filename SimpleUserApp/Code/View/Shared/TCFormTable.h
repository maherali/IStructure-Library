#import "TCEditingNavigationBar.h"

@interface TCFormTable : ISTableView<UITableViewDelegate, UITableViewDataSource, TCEditingNavigationBarDelegate> {
	NSString        *title;
	NSArray         *cells;
}

@property   (nonatomic, retain)     NSString       *title;
@property   (nonatomic, retain)     NSArray        *cells;

@end
