
#import "MyCollectionViewCell.h"

NSUInteger counter;

@interface MyCollectionViewCell ()
@end

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.label.text = [NSNumber numberWithUnsignedInteger:++counter].stringValue;
}

- (void)showSelected:(BOOL)selected andHighlighted:(BOOL)highlighted {
    if (selected) {
        self.backgroundColor = UIColor.orangeColor;
    } else if (highlighted) {
        self.backgroundColor = UIColor.greenColor;
    } else {
        self.backgroundColor = UIColor.whiteColor;
    }
    self.contentView.alpha = highlighted ? 0.5f : 1.0f;
}

@end
