//
//  MyViewCollectionViewController.m
//  大姨吗
//
//  Created by wgj on 16/9/5.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "MyViewCollectionViewController.h"
#import "CollectionReusableView.h"
#import "CollectionViewCell.h"
#import <Masonry/Masonry.h>

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@interface MyViewCollectionViewController() <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MyViewCollectionViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionCell"];
        
        
        self.collectionView.backgroundColor = [UIColor redColor];
        [self.view addSubview:self.collectionView];
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        [self.view addSubview:self.collectionView];
        
    }
    return self;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section == 0) {
        return 4;
    }
    if (section == 1) {
        return 8;
    }
    else {
    
        return 0;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *reusable = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];

//        view.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section == 0) {
            view.title.text = @"我的订单";
        }
        if (indexPath.section == 1) {
            view.title.text = @"常用功能";
        }
        reusable = view;

    }
    return reusable;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"待付款"];
                cell.descLabel.text = @"待付款";
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"待发货"];
                cell.descLabel.text = @"待发货";
                break;
            case 2:
                cell.imageView.image = [UIImage imageNamed:@"待收货"];
                cell.descLabel.text = @"待收货";
                break;
            case 3:
                cell.imageView.image = [UIImage imageNamed:@"已签收"];
                cell.descLabel.text = @"已签收";
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
    
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"我的数据"];
                cell.descLabel.text = @"我的数据";
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"我的话题"];
                cell.descLabel.text = @"我的话题";
                break;
            case 2:
                cell.imageView.image = [UIImage imageNamed:@"我的他"];
                cell.descLabel.text = @"我的他";
                break;
            case 3:
                cell.imageView.image = [UIImage imageNamed:@"我的地址"];
                cell.descLabel.text = @"我的地址";
                break;
            case 4:
                cell.imageView.image = [UIImage imageNamed:@"魔瘦"];
                cell.descLabel.text = @"魔瘦";
                break;
            case 5:
                cell.imageView.image = [UIImage imageNamed:@"孕期模式"];
                cell.descLabel.text = @"孕期模式";
                break;
            case 6:
                cell.imageView.image = [UIImage imageNamed:@"主题"];
                cell.descLabel.text = @"主题";
                break;
            case 7:
                cell.imageView.image = [UIImage imageNamed:@"软件反馈"];
                cell.descLabel.text = @"软件反馈";
                break;
                
            default:
                break;
        }
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH  - 80) / 4, (SCREEN_WIDTH - 80) / 4 + 20);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 10, 20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(300, 20);
}

@end
