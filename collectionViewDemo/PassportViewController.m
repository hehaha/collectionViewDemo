
//
//  PassportViewController.m
//  collectionViewDemo
//
//  Created by hexin on 15/5/16.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "PassportViewController.h"
#import "VerticalLayout.h"
#import "SecondLayout.h"
#import "ThirdLayout.h"
#import "NumberCell.h"
#import "FourthLayout.h"

@interface PassportViewController ()
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSArray *dataSource;
@property (nonatomic, strong)SecondLayout *secondLayout;
@property (nonatomic, strong)VerticalLayout *firstLayout;
@property (nonatomic, strong)ThirdLayout *thirdLayout;
@end

@implementation PassportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"NumberCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource[section] integerValue];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 20;
    CGFloat red = (random() % 100) / 100.0;
    CGFloat blue = (random() % 100) / 100.0;
    CGFloat green = (random() % 100) / 100.0;
    UIColor *backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    cell.backgroundColor = backgroundColor;
    cell.numberLabel.text = [NSString stringWithFormat:@"row: %ld, section: %ld",indexPath.row, indexPath.section];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.collectionView.collectionViewLayout isKindOfClass:[VerticalLayout class]]) {
        self.secondLayout.selectedSection = indexPath.section;
        self.thirdLayout.selectedSection = indexPath.section;
        __weak PassportViewController *weakSelf = self;
        [self.collectionView setCollectionViewLayout:self.secondLayout animated:YES completion:^(BOOL finished) {
            [weakSelf.collectionView setCollectionViewLayout:weakSelf.thirdLayout animated:YES];
        }];
    }
    else {
        [self.collectionView setCollectionViewLayout:self.firstLayout animated:YES];
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.firstLayout];
    }
    return _collectionView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@3, @4, @3];
    }
    return _dataSource;
}

- (SecondLayout *)secondLayout {
    if (!_secondLayout) {
        _secondLayout = [[SecondLayout alloc]init];
    }
    return _secondLayout;
}

- (VerticalLayout *)firstLayout {
    if (!_firstLayout) {
        _firstLayout = [[VerticalLayout alloc]init];
    }
    return _firstLayout;
}

- (ThirdLayout *)thirdLayout {
    if (!_thirdLayout) {
        _thirdLayout = [[ThirdLayout alloc]init];
    }
    return _thirdLayout;
}
@end
