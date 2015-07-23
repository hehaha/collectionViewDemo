//
//  TransformLayout.m
//  collectionViewDemo
//
//  Created by hexin on 15/5/22.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "TransformLayout.h"

@implementation TransformLayout
- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = CGSizeMake(200, 300);
    self.minimumLineSpacing = -50;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layouts = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    CGFloat centerX = visibleRect.origin.x + visibleRect.size.width / 2.0;
    CGFloat rectHalfWidth = visibleRect.size.width / 2.0;
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = 0.001;
    [layouts enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attributes, NSUInteger idx, BOOL *stop) {
        if (CGRectIntersectsRect(visibleRect, attributes.frame)) {
            CGFloat distance = attributes.center.x - centerX;
            CGFloat rotateAngle = M_PI_2 * (distance / rectHalfWidth);
            attributes.transform3D = CATransform3DConcat(CATransform3DMakeRotation(rotateAngle, 0, 1, 0), identity);
        }
        else {
            attributes.transform3D = CATransform3DIdentity;
        }
    }];
    return layouts;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect rectWhenStop = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *attributes = [super layoutAttributesForElementsInRect:rectWhenStop];
    CGFloat minOffset = FLT_MAX;
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        CGFloat centerY = attribute.center.y;
        CGFloat nowOffset = centerY - CGRectGetMidY(rectWhenStop);
        if (ABS(nowOffset) < ABS(minOffset) ) {
            minOffset = nowOffset;
        }
    }
    return CGPointMake(rectWhenStop.origin.x, rectWhenStop.origin.y + minOffset);
}
@end
