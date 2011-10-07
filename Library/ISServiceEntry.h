@interface ISServiceEntry : NSObject

@property (nonatomic, retain)   NSString    *serviceClassName;
@property (nonatomic, retain)   NSString    *serviceName;

- (ISServiceEntry*) initWithServiceName:(NSString*) srvcName andClassName:(NSString*) clsName;
+ (ISServiceEntry*) serviceWithServiceName:(NSString*) serviceName andClassName:(NSString*) className;

@end
