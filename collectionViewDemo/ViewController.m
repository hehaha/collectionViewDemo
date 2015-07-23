//
//  ViewController.m
//  collectionViewDemo
//
//  Created by hexin on 15/5/15.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "ViewController.h"
#import "NumberCell.h"
#import "LineLayout.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NumberCell" bundle:nil] forCellWithReuseIdentifier:@"NumberCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        LineLayout *layout = [[LineLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 60;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NumberCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}
@end
