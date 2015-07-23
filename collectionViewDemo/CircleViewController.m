//
//  CircleViewController.m
//  collectionViewDemo
//
//  Created by hexin on 15/5/15.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "CircleViewController.h"
#import "NumberCell.h"
#import "CircleLayout.h"

@interface CircleViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic ,strong)UICollectionView *collectionView;
@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[[CircleLayout alloc]init]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"NumberCell" bundle:nil] forCellWithReuseIdentifier:@"NumberCell"];
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NumberCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}
@end
