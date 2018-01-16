
#import "ViewController.h"
#import "MyCollectionViewCell.h"

@interface ViewController ()
@property (nonatomic, strong) NSIndexPath *selectedItem;
@property (nonatomic, strong) NSIndexPath *unhighlightedItem;
@property (nonatomic, assign) BOOL menuInitiated;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.allowsMultipleSelection = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIMenuControllerWillShowMenuNotification:) name:UIMenuControllerWillShowMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIMenuControllerWillHideMenuNotification:) name:UIMenuControllerWillHideMenuNotification object:nil];
}

- (void)UIMenuControllerWillShowMenuNotification:(id)sender {
    self.menuInitiated = YES;
}
- (void)UIMenuControllerWillHideMenuNotification:(id)sender {
    MyCollectionViewCell *cell = (MyCollectionViewCell *) [self.collectionView cellForItemAtIndexPath:self.unhighlightedItem];
    [cell showSelected:self.unhighlightedItem == self.selectedItem andHighlighted:NO];
    self.menuInitiated = NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedItem) {
        [collectionView deselectItemAtIndexPath:self.selectedItem animated:NO];
        MyCollectionViewCell *cell = (MyCollectionViewCell *) [collectionView cellForItemAtIndexPath:self.selectedItem];
        [cell showSelected:NO andHighlighted:NO];
    }
    MyCollectionViewCell *cell = (MyCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    [cell showSelected:YES andHighlighted:NO];
    self.selectedItem = indexPath;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = (MyCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    [cell showSelected:NO andHighlighted:NO];
    self.selectedItem = nil;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = (MyCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    [cell showSelected:self.selectedItem == indexPath andHighlighted:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = (MyCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    if (!self.menuInitiated) {
        [cell showSelected:self.selectedItem == indexPath andHighlighted:NO];
    }
    self.unhighlightedItem = indexPath;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender {
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"]) {
        return YES;
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender {
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"]) {
        // nothing to do
    }
}

@end
