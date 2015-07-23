//
//  CircleLayout.m
//  collectionViewDemo
//
//  Created by hexin on 15/5/15.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "CircleLayout.h"
static NSInteger circleRadius = 100;

@interface CircleLayout()
@property (nonatomic, assign)NSInteger cellCount;
@end

@implementation CircleLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.cellCount = [self.collectionView numberOfItemsInSection:0];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layout = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    layout.size = CGSizeMake(50, 50);
    CGFloat angle = (CGFloat)indexPath.row / (CGFloat)(self.cellCount - 1) * 2 * M_PI;
    CGFloat centerX = self.collectionView.center.x + cos(angle) * circleRadius;
    CGFloat centerY = self.collectionView.center.y + sin(angle) * circleRadius;
    layout.center = CGPointMake(centerX, centerY);
    return layout;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *layouts = [NSMutableArray array];
    for (int i = 0; i < self.cellCount; i++) {
        UICollectionViewLayoutAttributes * attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [layouts addObject:attribute];
    }
    return layouts;
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.frame.size;
}
@end
