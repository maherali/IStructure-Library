#define IS_DEFAULT_TIMEOUT_INTERVAL    (5*60)
#define IS_DEFAULT_CACHE_POLICY        NSURLRequestReloadIgnoringLocalAndRemoteCacheData
#define IS_DEFAULT_COOKIES_POLICY      YES

#define HTTP_RESPONSE_ARG               @"HTTP_RESPONSE_ARG"

#import "ISSync.h"

/** ISSync implementation class implementing JSON over HTTP.
*/
@interface ISBasicSync : ISSync {
    NSHTTPURLResponse       *response;
	NSError                 *error;
    NSMutableData           *data;
    NSURLConnection         *connection;
}

@property (retain) NSHTTPURLResponse        *response;
@property (retain) NSError                  *error;
@property (retain) NSMutableData            *data;
@property (retain) NSURLConnection          *connection;


/** Contact the server.
 The following is a possible implementation of this method:
 
        - (void) send:(NSMutableURLRequest*)request{
            __block ISBasicSync *this   = self;
            $trigger(@"network:on");
            self.data                   = [NSMutableData data];
            self.connection             = [[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES] autorelease];
        }

 Notice how this implementation is asynchronous. 
 
 @param request The request used in contacting the server.
 */
- (void) send:(NSMutableURLRequest*)request;

/** Update the HTTP headers.
 
 The following is a possible implementation of this method:
 
      - (void) setHeaders:(NSMutableURLRequest*) request{    
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        }
*/
- (void) setHeaders:(NSMutableURLRequest*) request;


/** Configure the connection.
 
The following is a possible implementation of this method:
 
      - (void) configureConnection:(NSMutableURLRequest*) request{
            request.cachePolicy             = IS_DEFAULT_CACHE_POLICY;
            request.HTTPShouldHandleCookies = IS_DEFAULT_COOKIES_POLICY;
            request.timeoutInterval         = IS_DEFAULT_TIMEOUT_INTERVAL;
        }
 */
- (void) configureConnection:(NSMutableURLRequest*) request;

/** Read request configuration.
 
 The following is a possible implementation of this method:
 
      - (void) setReadInfo:(NSMutableURLRequest*) request{
            [request setHTTPMethod:@"GET"];
        }
 */
- (void) setReadInfo:(NSMutableURLRequest*) request;


/** Create request configuration.
 
 The following is a possible implementation of this method:
 
      - (void) setCreateInfo:(NSMutableURLRequest*) request{
            NSData   *postData = [self.options objectForKey:DATA_KEY];
            if(postData){
                [request setHTTPBody:postData];
            }
            [request setHTTPMethod:@"POST"];    
        }
 */
- (void) setCreateInfo:(NSMutableURLRequest*) request;


/** Delete request configuration.
 
 The following is a possible implementation of this method:
 
      - (void) setDeleteInfo:(NSMutableURLRequest*) request{
            [request setHTTPMethod:@"DELETE"];
        }
 */
- (void) setDeleteInfo:(NSMutableURLRequest*) request;


/** Update request configuration.
 
 The following is a possible implementation of this method:
 
      - (void) setUpdateInfo:(NSMutableURLRequest*) request{
            [self setCreateInfo:request];
            [request setHTTPMethod:@"PUT"];
        }
*/

- (void) setUpdateInfo:(NSMutableURLRequest*) request;

/** Build the request.
 
 The following is a possible implementation of this method:
 
 
       - (NSMutableURLRequest*) buildRequest{
            NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
            [self setHeaders:request];
            [self configureConnection:request];
            NSString    *method     = [self.options objectForKey:METHOD_KEY];
            NSURL       *url        = [NSURL URLWithString:[self.options objectForKey:URL_KEY]];
            if ([method isEqualToString:METHOD_CREATE]) {
                [self setCreateInfo:request];
            } else if ([method isEqualToString:METHOD_READ]) {
                [self setReadInfo:request];
            } if ([method isEqualToString:METHOD_DELETE]) {
                [self setDeleteInfo:request];
            } if ([method isEqualToString:METHOD_UPDATE]) {
                [self setUpdateInfo:request];
            }			
            [request setURL:url];
            return request;
        }
 */

- (NSMutableURLRequest*) buildRequest;

/** Provide a way for subclasses to configure teh request just before contacting server.
 
 Base class is a noop.
 
 @return the request to use in contacting the server.
 @param request The request just before contacting the server.
 */
- (NSMutableURLRequest*) lastChanceToUpdateRequest:(NSMutableURLRequest*) request;

/**
 Called when the HTTP connection finished loading data
 You can assume that the data has been set.
 Base class implementation is a no-op.
 */
- (void) syncFinished;

/**
 Called when the HTTP connection failed.
 You can assume that the error has been set.
 Base class implementation is a no-op.
 */
- (void) syncFailed;

@end














