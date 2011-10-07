@interface ISErrorDecoder : NSObject

+ (id) errorDecoder;
- (BOOL) hasAppLevelErrors;
- (NSArray*) appLevelErrors;
- (BOOL) hasNetworkLevelErrors;
- (NSArray*) networkLevelErrors;

@end
