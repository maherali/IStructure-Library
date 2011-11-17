#import "SimpleCell.h"

@interface SimpleTableController : ISTableViewController{
    IBOutlet SimpleCell *cell;
}

@property   (nonatomic, retain)     SimpleCell  *cell;

@end
