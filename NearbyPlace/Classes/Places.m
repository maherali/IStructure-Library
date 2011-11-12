#import "Places.h"
#import "Place.h"
#import "GeoNamesSync.h"

@implementation Places

- (Class) modelClass{
    return [Place class];
}

+ (Class) syncClass{
    return [GeoNamesSync class];
}

- (NSString*) path{
    return @"http://api.geonames.org/findNearbyPlaceNameJSON?lat=30&lng=-97&radius=50&style=FULL&username=agilis";
}

- (NSMutableArray*) parse:(NSData*) data{
    return [(NSMutableDictionary*)[super parse:data] objectForKey:@"geonames"];
}

@end
