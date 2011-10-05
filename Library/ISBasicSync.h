#define IS_DEFAULT_TIMEOUT_INTERVAL    (5*60)
#define IS_DEFAULT_CACHE_POLICY        NSURLRequestReloadIgnoringLocalAndRemoteCacheData
#define IS_DEFAULT_COOKIES_POLICY      YES

#define HTTP_RESPONSE_ARG               @"HTTP_RESPONSE_ARG"

#import "ISSync.h"

@interface ISBasicSync : ISSync {
    NSHTTPURLResponse       *response;
	NSError                 *error;
    NSData                  *data;
}

@property (retain) NSHTTPURLResponse        *response;
@property (retain) NSError                  *error;
@property (retain) NSData                   *data;

- (void) send:(NSMutableURLRequest*)request;
- (void) setHeaders:(NSMutableURLRequest*) request;
- (void) configureConnection:(NSMutableURLRequest*) request;
- (void) setReadInfo:(NSMutableURLRequest*) request;
- (void) setCreateInfo:(NSMutableURLRequest*) request;
- (void) setDeleteInfo:(NSMutableURLRequest*) request;
- (void) setUpdateInfo:(NSMutableURLRequest*) request;
- (NSMutableURLRequest*) buildRequest;
- (NSMutableURLRequest*) lastChanceToUpdateRequest:(NSMutableURLRequest*) request;


@end


