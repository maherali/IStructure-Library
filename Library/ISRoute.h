/** ISRoute class  */

@interface ISRoute : NSObject {
    
}

/** template of the route */
@property (retain) NSString             *template;
/**  The regular expression of the route              */
@property (retain) NSRegularExpression  *routeRegEx;
@property (retain) NSArray              *paramNames;

/** ssdfjgs dfgs
 @param tmpl testing 
 
*/
- (id)      initWithTemplate:(NSString*) tmpl;
- (BOOL)    matches:(NSString*) route;
+ (id)      routeWithTemplate:(NSString*) tmpl;
- (NSDictionary*) matchedParams:(NSString*) route;

@end
  