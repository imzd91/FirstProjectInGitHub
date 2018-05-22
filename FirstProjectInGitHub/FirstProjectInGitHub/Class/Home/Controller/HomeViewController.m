//
//  HomeViewController.m
//  FirstProjectInGitHub
//
//  Created by zd on 2018/5/17.
//  Copyright © 2018年 zd. All rights reserved.
//

#import "HomeViewController.h"
#import "ZDLayout.h"
#import "ZDWaterCell.h"
#import "ZDModel.h"

@interface HomeViewController ()<ZDLayoutDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mainCollectView;
@property (nonatomic, copy) NSArray *data;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (Development == 1) {
        NSLog(@"1111111");
    }else{
        NSLog(@"0000000");
    }
    [self setupUI];
    
    NSArray *arr = [[NSArray alloc] init];
    NSArray *arr2 = arr.copy;
    NSLog(@"%@  ,%@",arr,arr2);
    NSLog(@"sss");
}

- (void)setupUI{
    ZDLayout *layout = [[ZDLayout alloc] init];
    UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectView.backgroundColor = [UIColor whiteColor];
    collectView.dataSource = self;
    [collectView registerClass:[ZDWaterCell class] forCellWithReuseIdentifier:@"ZDWaterCell"];
    [self.view addSubview:collectView];
    self.mainCollectView = collectView;
    layout.zDelegate = self;
}

#pragma mark - layoutDelegate
- (CGFloat)waterFallLayout:(ZDLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth{
    CGFloat height = (CGFloat)arc4random_uniform(50);
    return height+50;
}

#pragma mark - collectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZDWaterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZDWaterCell" forIndexPath:indexPath];
    cell.model = self.data[indexPath.item];
    return cell;
}

- (NSArray *)data{
    if (!_data) {
        NSMutableArray *tmpM = [[NSMutableArray alloc] init];
        NSArray *images = @[@"代币记录退币图标",@"代币记录送币图标"];
        NSArray *titles = @[@"代币记录退币图标",@"代币记录送币图标"];
        for (NSInteger i = 0; i < 20; i++) {
            ZDModel *model = [[ZDModel alloc] init];
            model.imageName = images[i%2];
            model.title = titles[i%2];
            [tmpM addObject:model];
        }
        _data = tmpM;
    }
    return _data;
}

@end
