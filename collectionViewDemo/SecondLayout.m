//
//  SecondLayout.m
//  collectionViewDemo
//
//  Created by hexin on 15/5/16.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "SecondLayout.h"
@interface SecondLayout()
@property (nonatomic, strong)NSArray *cellsNum;
@property (nonatomic, assign)CGFloat sectionBottomSpacing;
@end

@implementation SecondLayout
static CGFloat bottomSpacing = 50.0;
static CGFloat topSpacing = 100.0;
static CGFloat sectionTopSpacing = 50;

- (void)setSelectedSection:(NSInteger)selectedSection {
    _selectedSection = selectedSection;
    [self invalidateLayout];
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.frame.size;
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

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributeArr = [NSMutableArray array];
    for (int section = 0; section < self.cellsNum.count; section ++) {
        for (int row = 0; row < [self.cellsNum[section] integerValue]; row ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [attributeArr addObject:attributes];
        }
    }
    return attributeArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGSize size = CGSizeMake(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height - topSpacing);
    if (indexPath.section == self.selectedSection) {
        attributes.frame = CGRectMake(0, sectionTopSpacing + indexPath.row * sectionTopSpacing, size.width, size.height);
    }
    else {
        if (indexPath.section < self.selectedSection) {
            NSInteger factor = [self.cellsNum[indexPath.section] integerValue] - indexPath.section;
            attributes.frame = CGRectMake(0, size.height + 130 - factor * self.sectionBottomSpacing, size.width, size.height);
        }
        else {
            NSInteger factor = [self.cellsNum[indexPath.section] integerValue] - indexPath.section + 1;
            attributes.frame = CGRectMake(0, size.height + 130 - factor * self.sectionBottomSpacing, size.width, size.height);
        }
    }
    return attributes;
}

- (CGFloat)sectionBottomSpacing {
    return bottomSpacing / (self.cellsNum.count - 1);
}
@end
