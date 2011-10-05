#import "ISErrorDecoder.h"

@interface ISBasicErrorDecoder : ISErrorDecoder

@property   (retain)    NSHTTPURLResponse       *response;
@property   (retain)    NSError                 *error;
@property   (retain)    NSData                  *data;

@end
