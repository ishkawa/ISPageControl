#import <UIKit/UIKit.h>

@interface ISPageControl : UIPageControl

@property (retain, nonatomic) UIImage *activeImage;
@property (retain, nonatomic) UIImage *inactiveImage;

- (void)customizeIndicators;

@end
