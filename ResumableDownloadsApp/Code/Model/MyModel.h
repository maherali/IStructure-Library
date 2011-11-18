@interface MyModel : ISModel{
    float       percentage;
    UIImage     *image;
    BOOL        downloadPaused;
    BOOL        downloadOngoing;
}

@property (nonatomic, assign) float     percentage;
@property (nonatomic, retain) UIImage   *image;
@property (nonatomic, assign) BOOL      downloadPaused;
@property (nonatomic, assign) BOOL      downloadOngoing;

- (BOOL) resourceExist;
- (void) removeResource;
- (NSString*) resourcePathOnDisk;
- (BOOL) partialResourceExist;

@end
