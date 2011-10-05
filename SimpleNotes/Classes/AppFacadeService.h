#import "ISGenericController.h"

@interface AppFacadeService : NSObject{
    UINavigationController  *navigationController;
    NSMutableArray          *observers;
}

@property (nonatomic, retain)   UINavigationController      *navigationController;
@property (nonatomic, retain)   NSMutableArray              *observers;

@end
