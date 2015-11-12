//
//  RootViewController.m
//  Peri
//
//  Created by fitfun on 15/11/9.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "RootViewController.h"
#import "GetHtmlAnalyze.h"
#import "CollectionViewCell.h"

@interface RootViewController ()
@property (strong, nonatomic)NSMutableArray *imageArray;
@property (strong, nonatomic)NSMutableArray *imageDetailUrlArray;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetFromHtml];
    self.imageCollectionView.dataSource = self;
    self.imageCollectionView.delegate = self;
    [self.imageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)GetFromHtml {
    NSString *htmlUrl = @"http://www.meizitu.com/a/list_1_2.html";
    self.imageArray = [GetHtmlAnalyze searchImageWithHtml:htmlUrl];
    self.imageDetailUrlArray = [GetHtmlAnalyze searchImageDetailUrlWithHtml:htmlUrl];
    NSLog(@"%@=======%lu",self.imageArray,(unsigned long)self.imageArray.count);

}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CollectionViewCell";
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *imgStr = [self.imageArray objectAtIndex:indexPath.row];
    NSURL *imageUrl = [NSURL URLWithString:imgStr];
    NSData* data = [NSData dataWithContentsOfURL:imageUrl];
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:data]];
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(160, 160);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end
