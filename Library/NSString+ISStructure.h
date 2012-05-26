@interface NSString (ISStructure)

- (NSString*) urlEncode;
- (NSString*) encryptedStringWithKey:(NSString*) key;
- (NSString*) decryptedStringWithKey:(NSString*) key;

@end
