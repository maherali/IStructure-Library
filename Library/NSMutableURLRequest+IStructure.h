@interface NSMutableURLRequest (IStructure)

/** Support for adding a Basic HTTP Authentication (Authorization) header
 
 @param user The user login id
 @param password The user password
 */

- (void) addBasicHTTPAuthHeaderForUser:(NSString*) user withPassword:(NSString*) password;

@end
