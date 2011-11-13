#import "Session.h"
#import "SessionSync.h"

@implementation Session

@synthesize loggedIn, rememberMe;

// This is the path used for any sync operation on the model
- (NSString*) path{
    return @"/users/sign_in.json";
}

// This one says that the path for destroy operation is as follows
- (NSString*) destroyPath{
    return @"/users/sign_out.json";
}

// Use SessionSync class as my sync class
+ (Class) syncClass{
    return [SessionSync class];
}

// Before calling sync to perform an operation (save, destroy, etc.), this method is called by teh method implementing the operation so that 
// you can pass in more data to sync. 
// Here, we are passing in the user name and password so that sync uses them in the Authorization HTTP header.
- (void) lastChanceToUpdateSyncOptions:(NSMutableDictionary*) opts forMethod:(NSString*) method{
    if([method isEqualToString:METHOD_CREATE]){ // Only in the case of create (post)
        [opts setObject:[self get:@"user_name"] forKey:@"USER_NAME"];
        [opts setObject:[self get:@"password"] forKey:@"PASSWORD"];
    }
}

// We are overriding this method since this model does not use an id. 
// If the user is logged in, the model is considered not new.
// When you try to perform destroy operation on a model and that model is not new, sync is 
// not called.
- (BOOL) isNew{
    return !loggedIn;
}

// You can implement a validate: method to do model validation before performing teh operation.
// If this method is defined and it returns a non-empty array, the operation is cancelled and the validation 
// block is called. The validation block is declared as follows:
// typedef void(^ValidationErrorHandler)(id origin, NSArray *errors, NSDictionary* options);
// There is a commonValidationErrorHandler method in TCUIFactory that just shows the errors
- (NSArray*) validate:(NSDictionary*) attrs{
    NSMutableArray  *arr    = $marray();
    NSString        *userName  = [attrs objectForKey:@"user_name"];
    if(userName && [userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1){
        [arr addObject:@"Username is missing"];
    }
    NSString        *password  = [attrs objectForKey:@"password"];
    if(password && [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1){
        [arr addObject:@"Password is missing"];
    }
    return arr;
}


@end
