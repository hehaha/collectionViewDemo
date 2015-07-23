//
//  ZAxisViewController.m
//  collectionViewDemo
//
//  Created by hexin on 15/6/8.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "ZAxisViewController.h"
#import "ZAxisLayout.h"

@interface ZAxisViewController()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)ZAxisLayout *layout;
@end

@implementation ZAxisViewController
- (ZAxisLayout *)layout {
    if (!_layout) {
        _layout = [[ZAxisLayout alloc]init];
    }
    return _layout;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 20;
    CGFloat red = (random() % 100) / 100.0;
    CGFloat blue = (random() % 100) / 100.0;
    CGFloat green = (random() % 100) / 100.0;
    UIColor *backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    cell.backgroundColor = backgroundColor;
    return cell;
}
@end
