#import "ISPageControl.h"

@implementation ISPageControl

@synthesize activeImage   = _activeImage;
@synthesize inactiveImage = _inactiveImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.activeImage   = [UIImage imageNamed:@"active.png"];
    self.inactiveImage = [UIImage imageNamed:@"inactive.png"];
    
    [self startObservingKeys];
    [self customizeIndicators];
}

- (void)dealloc
{
    self.activeImage   = nil;
    self.inactiveImage = nil;
    
    [self removeObserver:self forKeyPath:@"numberOfPages"];
    [self removeObserver:self forKeyPath:@"currentPage"];
    [super dealloc];
}

#pragma mark - key value observing

- (void)startObservingKeys
{
    [self addObserver:self
           forKeyPath:@"numberOfPages"
              options:NSKeyValueObservingOptionNew
              context:nil];
    
    [self addObserver:self
           forKeyPath:@"currentPage"
              options:NSKeyValueObservingOptionNew
              context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self) {
        [self customizeIndicators];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark -

- (void)customizeIndicators
{
    NSArray *indicators = [self valueForKey:@"_indicators"];
    for (UIImageView *imageView in indicators) {
        NSInteger index = [indicators indexOfObject:imageView];
        if (index == self.currentPage) {
            imageView.image = self.activeImage;
        } else {
            imageView.image = self.inactiveImage;
        }
    }
}


@end
