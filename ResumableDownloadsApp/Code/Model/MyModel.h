@interface MyModel : ISModel{
    float percentage;
}

@property (nonatomic, assign) float   percentage;

- (BOOL) resourceExist;
- (void) removeResource;

@end
