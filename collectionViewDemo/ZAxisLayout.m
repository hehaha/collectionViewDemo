
//
//  ZAxisLayout.m
//  collectionViewDemo
//
//  Created by hexin on 15/6/8.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "ZAxisLayout.h"


@implementation ZAxisLayout
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger cellNum = [self.collectionView numberOfItemsInSection:0];
    NSMutableArray *attributesArr = [NSMutableArray array];
    for (int i = 0; i < cellNum; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [attributesArr addObject:attributes];
    }
    return attributesArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%d",indexPath.item);
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.frame = CGRectMake(100, 100 - 10 * [indexPath item], 100, 200);
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1.0 / 1000.0;
    CGFloat scale = (100.0 - [indexPath item] * 2) / 100.0;
    CATransform3D translate = CATransform3DMakeTranslation(0, 0, 100 - [indexPath item]);
    attribute.transform3D = CATransform3DConcat(translate, CATransform3DMakeScale(scale, scale, 1));
    attribute.alpha = (100.0 - [indexPath item] * 10) / 100.0;
    return attribute;
}
@end
