@interface NSData (ISStructure)
- (id) concreteObject;

//NSData additions from colloquy project
+ (NSData *) dataWithBase64EncodedString:(NSString *) string;
- (id) initWithBase64EncodedString:(NSString *) string;
- (NSString *) base64Encoding;
- (NSString *) base64EncodingWithLineLength:(unsigned int) lineLength;
+ (NSData *)base64DecodeString: (NSString *)string;
- (BOOL) hasPrefix:(NSData *) prefix;
- (BOOL) hasPrefixBytes:(void *) prefix length:(unsigned int) length;
//end NSData additions from colloquy project


+ (NSData*) encryptString:(NSString*)plaintext withKey:(NSString*)key;
- (NSString*) decryptWithKey:(NSString*)key;

@end
