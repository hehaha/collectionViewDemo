//
//  LineLayout.m
//  collectionViewDemo
//
//  Created by hexin on 15/5/15.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "LineLayout.h"

@implementation LineLayout
- (instancetype)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(200, 200);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = 100;
    }
    return self;
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

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attribute in array) {
        if (CGRectContainsRect(rect, attribute.frame)) {
            CGFloat distance = CGRectGetMidY(visibleRect) - attribute.center.y;
            CGFloat normalizedDistance = distance / 300;
            CGFloat zoom = 1 + 0.5*(1 - ABS(normalizedDistance));
            attribute.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
            attribute.zIndex = 1;
        }
    }
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

@end
