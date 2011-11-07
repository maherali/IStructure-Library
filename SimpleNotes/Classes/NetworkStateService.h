@interface NetworkStateService : NSObject{
    NSMutableArray      *observers;
}

@property (retain) NSMutableArray   *observers;

@end
