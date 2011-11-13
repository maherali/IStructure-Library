@interface TCSettings : NSObject {
    NSMutableDictionary         *settings;
}

@property   (nonatomic, retain) NSMutableDictionary *settings;

-   (id)    init;
-   (void)  setValue:(id)_setting forKey:(NSString*)_key;
-   (id)    valueForKey:(NSString*)_key;
+   (NSString*) settingsFileName;
+   (TCSettings*) instance;

@end
