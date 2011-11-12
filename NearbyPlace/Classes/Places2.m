#import "Places2.h"

@implementation Places2

- (NSString*) path{
    return @"http://api.geonames.org/findNearbyPlaceName?lat=30&lng=-97&radius=50&style=FULL&username=agilis";
}

- (NSMutableArray*) parse:(NSData*) XMLData{
    CXMLDocument *doc = [[[CXMLDocument alloc] initWithData:XMLData options:0 error:nil] autorelease];
    NSMutableArray *res = [[[NSMutableArray alloc] init] autorelease];
    NSArray *nodes = NULL;
    nodes = [doc nodesForXPath:@"//geoname" error:nil];
    for (CXMLElement *node in nodes) {
        NSMutableDictionary *item = [[[NSMutableDictionary alloc] init] autorelease];
        int counter;
        for(counter = 0; counter < [node childCount]; counter++) {
            [item setObject:[[node childAtIndex:counter] stringValue] forKey:[[node childAtIndex:counter] name]];
        }
        NSArray *attrs = [node attributes];
        for(CXMLElement *atr in attrs){
            [item setObject:[atr stringValue] forKey:[atr name]]; 
        }
        [res addObject:item];
    }
    return res;
}

@end
