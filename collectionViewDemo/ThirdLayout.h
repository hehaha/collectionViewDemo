//
//  ThirdLayout.h
//  collectionViewDemo
//
//  Created by hexin on 15/5/16.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdLayout : UICollectionViewLayout
@property (nonatomic, assign)NSInteger selectedSection;
@property (nonatomic, assign)BOOL isAnimating;
- (void)rotateAniamtionWillBegin;
- (void)rotateAniamtionDidEnd;
@end
