#import "TCEditingNavigationBar.h"

@interface TCFormView : ISTableView<UITableViewDelegate, UITableViewDataSource, TCEditingNavigationBarDelegate> {
	NSString        *title;
	NSArray         *cells;
}

@property   (nonatomic, retain)     NSString       *title;
@property   (nonatomic, retain)     NSArray        *cells;

@end
