#import "SimpleTableController.h"

@implementation SimpleTableController

@synthesize cell;

- (id) 
- (id)in:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellID";
    SimpleCell *theCell = (SimpleCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (theCell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"SimpleCell" owner:self options:nil];
        theCell = self.cell;
    }
    [theCell configure];
    return theCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void) dealloc{
    self.cell = nil;
    [super dealloc];
}

@end
