#import "Photo.h"
#import "PhotoSync.h"

@implementation Photo

@synthesize image;

-(void)appendParamValue:(id)_value withParamName:(NSString*)_param toData:(NSMutableData*)_data{
    [_data appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [_data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", _param] dataUsingEncoding:NSUTF8StringEncoding]];
    [_data appendData:[[[_value description] urlEncode] dataUsingEncoding:NSUTF8StringEncoding]];
}

-(void)appendPhoto:(UIImage*)_photo withParamName:(NSString*)_param toData:(NSMutableData*)_data{
    NSData *_photoData =  UIImageJPEGRepresentation(_photo, 0.6);
    [_data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"photo.jpg\"\r\n", _param] dataUsingEncoding:NSUTF8StringEncoding]];
    [_data appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [_data appendData:_photoData];
}

- (NSString*) path{
    return @"/photos";    
}

- (NSData*) dataToSave{
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [self appendPhoto:image withParamName:@"photo[uploaded_data]" toData:postBody];
    [self appendParamValue:@"asdas" withParamName:@"photo[caption]" toData:postBody];
    [self appendParamValue:[NSNumber numberWithFloat:33.2] withParamName:@"photo[lat]" toData:postBody];
    [self appendParamValue:[NSNumber numberWithFloat:-97.1] withParamName:@"photo[lng]" toData:postBody];
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    return postBody;
}

- (NSMutableDictionary*) parse:(NSData*) data{
    return $mdict();
}

+ (Class) syncClass{
    return [PhotoSync class];
}

- (void) dealloc{
    self.image  =   nil;
    [super dealloc];
}

@end
