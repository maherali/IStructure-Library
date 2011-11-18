@interface MyModel : ISModel{
    float       percentage;
    UIImage     *image;
}

@property (nonatomic, assign) float     percentage;
@property (nonatomic, retain) UIImage   *image;

- (BOOL) resourceExist;
- (void) removeResource;
- (NSString*) resourcePathOnDisk;

@end
