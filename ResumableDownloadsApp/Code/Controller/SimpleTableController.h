#import "SimpleCell.h"

@interface SimpleTableController : ISTableViewController{
    IBOutlet SimpleCell *cell;
}

@property   (nonatomic, retain)     SimpleCell  *cell;

- (void) fetchModel:(MyModel*) m;

@end
