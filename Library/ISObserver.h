@interface ISObserver : NSObject

@property (retain) id name;
@property (retain) id observer;
@property (retain) id object;

+ (id) valueWithName:(id) _name andObserver:(id) _observer forObject:(id) _object;

@end
