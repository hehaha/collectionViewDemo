
//
//  VerticalLayout.m
//  collectionViewDemo
//
//  Created by hexin on 15/5/16.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "VerticalLayout.h"
@interface VerticalLayout()
@property (nonatomic, strong)NSArray *cellsNum;
@property (nonatomic, assign)CGFloat sectionLineSpacing;
@end

@implementation VerticalLayout
static NSInteger topSpacing = 100;
static CGFloat sectionSpacing = 50;

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height + 50);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributeArr = [NSMutableArray array];
    for (int section = 0; section < self.cellsNum.count; section++) {
        for (int row = 0; row < [self.cellsNum[section] integerValue]; row++) {
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
            [attributeArr addObject:attributes];
        }
    }
    return attributeArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat itemY = topSpacing + indexPath.section * self.sectionLineSpacing + [self itemSpaceOfSection:indexPath.section] * indexPath.row;
    NSInteger zIndex = [self zIndexWithIndexPath:indexPath];
    attributes.transform3D = CATransform3DMakeTranslation(0, 0, zIndex);
    attributes.zIndex = zIndex;
    attributes.frame = CGRectMake(0, itemY, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height - topSpacing);
    return attributes;
}
- (NSArray *)cellsNum {
    if (!_cellsNum) {
        NSMutableArray *nums = [[NSMutableArray alloc]init];
        NSInteger sectionNum = [self.collectionView numberOfSections];
        for (int i = 0; i < sectionNum; i++) {
            NSNumber *numberOfItem = [NSNumber numberWithInteger:[self.collectionView numberOfItemsInSection:i]];
            [nums addObject:numberOfItem];
        }
        _cellsNum = nums;
    }
    return _cellsNum;
}

- (CGFloat)sectionLineSpacing {
    CGFloat viewHeight = self.collectionView.bounds.size.height;
    return (viewHeight - topSpacing) / self.cellsNum.count;
}

- (CGFloat)itemSpaceOfSection: (NSInteger)section {
    NSInteger itemNum = [self.cellsNum[section] integerValue];
    return sectionSpacing / itemNum;
}

- (NSInteger)zIndexWithIndexPath: (NSIndexPath *)indexPath {
    NSInteger zIndex = 0;
    for (int i = 0; i < indexPath.section; i++) {
        zIndex += [self.cellsNum[i] integerValue];
    }
    zIndex += indexPath.row;
    return zIndex;
}
@end
