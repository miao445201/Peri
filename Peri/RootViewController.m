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
#import "ProgressHUD.h"
#import "MJRefresh.h"

@interface RootViewController ()
@property int pageCount;
@property (strong, nonatomic)NSString *htmlUrl;
@property (strong, nonatomic)NSMutableArray *imageArray;
@property (strong, nonatomic)NSMutableArray *imageDetailUrlArray;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
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
    [self addRefresh];
    [self addGestureRecognizer];
    [self setNaviTitle:@"妹子去哪了"];
    [self setRightNaviItemWithTitle:@"下一页" imageName:@"next.ico"];
    [self setLeftNaviItemWithTitle:@"上一页" imageName:@"back.ico"];
    [self.imageCollectionView reloadData];
}

- (void)addRefresh {
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 下拉刷新
    self.imageCollectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self GetFromHtml];
        [weakSelf.imageCollectionView.mj_header endRefreshing];
    }];
    [self.imageCollectionView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.imageCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self GetFromHtml];
        [weakSelf.imageCollectionView.mj_header endRefreshing];
    }];
    // 默认先隐藏footer
    self.imageCollectionView.mj_footer.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)GetFromHtml {
    htmlUrl = [NSString stringWithFormat:@"http://www.meizitu.com/a/list_1_%d.html",self.pageCount];
    
//    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
//        self.imageArray = [GetHtmlAnalyze searchImageWithHtml:htmlUrl];
//        self.imageDetailUrlArray = [GetHtmlAnalyze searchImageDetailUrlWithHtml:htmlUrl];
//        self.titleArray = [GetHtmlAnalyze searchTitleWithHtml:htmlUrl];
//    }];
//    
//    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
//        [self.imageCollectionView reloadData];
//    }];
//    [operation2 addDependency:operation1];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperations:@[operation2, operation1] waitUntilFinished:NO];
    self.imageArray = [GetHtmlAnalyze searchImageWithHtml:htmlUrl];
    self.imageDetailUrlArray = [GetHtmlAnalyze searchImageDetailUrlWithHtml:htmlUrl];
    [self.imageCollectionView reloadData];

}

- (void)addGestureRecognizer {
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightItemTapped)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftItemTapped)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
}
- (void)leftItemTapped {
    if (self.pageCount > 1) {
        self.pageCount--;
        [self GetFromHtml];
        [self moveLeftViewAnimation];
    }
    else {
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"手滑了吗？" message:@"已经是第一页了哟" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertview show];
    }
    
}
- (void)rightItemTapped {
    [self moveRightViewAnimation];
    self.pageCount++;
    [self GetFromHtml];
}

- (void)moveLeftViewAnimation {
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDelay:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (void)moveRightViewAnimation {
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDelay:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    [UIView commitAnimations];
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
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
    [ProgressHUD show:@"Please wait..."];
    [self.navigationController pushViewController:periDetail animated:YES];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void) collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[collectionView indexPathsForVisibleItems] lastObject]).row){
        [ProgressHUD dismiss];
    }
}
@end
