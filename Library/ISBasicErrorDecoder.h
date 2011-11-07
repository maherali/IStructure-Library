#import "ISErrorDecoder.h"


/** An error decoder for decoding basic errors.
 
 Implement your own or override and customize.
 
        - (BOOL) hasAppLevelErrors{
            return response.statusCode == 422;
        }

        - (NSArray*) appLevelErrors{
            NSDictionary *errorsHash = [[[[SBJsonParser alloc] init] autorelease] objectWithData:data];
            NSMutableArray *errs = $marray();
            for(id key in [errorsHash allKeys]){
                NSArray *setOfErrors = [errorsHash objectForKey:key];
                for(NSString *v in setOfErrors){
                    [errs addObject:$sprintf(@"%@ %@", key, v)];
                }
            }
            return errs;      
        }

        - (BOOL) hasNetworkLevelErrors{
            return error || [$array($object(500),$object(404),$object(403)) containsObject:$object(response.statusCode)];
        }

        - (NSArray*) networkLevelErrors{
            if(error) return $array([error localizedDescription]);
            return $array([NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]);
        }

 */
@interface ISBasicErrorDecoder : ISErrorDecoder


/** The data used in decoding errors.
 
 
 ISBasicSync updates the ISBasicErrorDecoder instance with the information needed 
 to decode errors. This happens just before send: about to return.
  
     ((ISBasicErrorDecoder*)self.errorDecoder).data      = self.data;
*/
@property   (retain)    NSData                  *data;

/** The response used in decoding errors.
 

 ISBasicSync updates the ISBasicErrorDecoder instance  with the information needed 
 to decode errors. This happens just before send: about to return.
 

    ((ISBasicErrorDecoder*)self.errorDecoder).response  = self.response;

 */

@property   (retain)    NSHTTPURLResponse       *response;

/** The error used in decoding errors.
 
 
 ISBasicSync updates the ISBasicErrorDecoder instance with the information needed 
 to decode errors. This happens just before send: about to return.
 
    ((ISBasicErrorDecoder*)self.errorDecoder).error     = self.error;
 
 */

@property   (retain)    NSError                 *error;


@end
