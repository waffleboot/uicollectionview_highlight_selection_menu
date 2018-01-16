
#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UILabel *label;
- (void)showSelected:(BOOL)selected andHighlighted:(BOOL)highlighted;
@end
