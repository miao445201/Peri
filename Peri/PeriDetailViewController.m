//
//  PeriDetailViewController.m
//  Peri
//
//  Created by fitfun on 15/11/12.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "PeriDetailViewController.h"
#import "GetHtmlAnalyze.h"
#import "UIImageView+WebCache.h"

@interface PeriDetailViewController ()

@property (strong, nonatomic)NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@end

@implementation PeriDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetFromHtml];
    self.imageCollectionView.dataSource = self;
    self.imageCollectionView.delegate = self;
    [self.imageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
}

- (void)GetFromHtml {
    self.imageArray = [GetHtmlAnalyze searchDetailImageWithHtml:self.detailImageUrl];
    NSLog(@"%@=======%lu",self.imageArray,(unsigned long)self.imageArray.count);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CollectionViewCell";
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *imgStr = [self.imageArray objectAtIndex:indexPath.row];
    
    UIImageView *image = [[UIImageView alloc]init];
    [image  sd_setImageWithURL:[NSURL URLWithString:imgStr]placeholderImage:[UIImage imageNamed: @"placeholder.png"]];
    cell.backgroundView = image;
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth,ScreenHeight/1.2);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
