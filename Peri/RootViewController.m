//
//  RootViewController.m
//  Peri
//
//  Created by fitfun on 15/11/9.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "RootViewController.h"
#import "GetHtmlAnalyze.h"
#import "UIImageView+WebCache.h"
#import "PeriDetailViewController.h"

@interface RootViewController ()
@property (strong, nonatomic)NSString *htmlUrl;
@property int pageCount;
@property (strong, nonatomic)NSMutableArray *imageArray;
@property (strong, nonatomic)NSMutableArray *imageDetailUrlArray;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@end

@implementation RootViewController
@synthesize htmlUrl;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageCount = 1;
    [self GetFromHtml];
    self.imageCollectionView.dataSource = self;
    self.imageCollectionView.delegate = self;
    [self.imageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self setNaviTitle:@"妹子去哪了"];
    [self setRightNaviItemWithTitle:@"下一页" imageName:@"next.ico"];
    [self setLeftNaviItemWithTitle:@"上一页" imageName:@"back.ico"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)GetFromHtml {
    htmlUrl = [NSString stringWithFormat:@"http://www.meizitu.com/a/list_1_%d.html",self.pageCount];
    NSLog(@"%@",htmlUrl);
    self.imageArray = [GetHtmlAnalyze searchImageWithHtml:htmlUrl];
    self.imageDetailUrlArray = [GetHtmlAnalyze searchImageDetailUrlWithHtml:htmlUrl];
    NSLog(@"%@=======%lu",self.imageDetailUrlArray,(unsigned long)self.imageDetailUrlArray.count);

}

- (void)leftItemTapped {
    if (self.pageCount > 1) {
        self.pageCount--;
        [self GetFromHtml];
        [self.imageCollectionView reloadData];
    }
    else {
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"手滑了吗？" message:@"已经是第一页了哟" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertview show];
    }
    
}
- (void)rightItemTapped {
    self.pageCount++;
    [self GetFromHtml];
    [self.imageCollectionView reloadData];
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
    return CGSizeMake(165, 165);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *detailImageUrl = [self.imageDetailUrlArray objectAtIndex:indexPath.row];
    PeriDetailViewController *periDetail = [[PeriDetailViewController alloc]init];
    periDetail.detailImageUrl = detailImageUrl;
    [self.navigationController pushViewController:periDetail animated:YES];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end
