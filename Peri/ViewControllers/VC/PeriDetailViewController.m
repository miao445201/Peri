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
#import "ProgressHUD.h"

@interface PeriDetailViewController ()

@property (strong, nonatomic)NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@property (nonatomic, strong) UIImage *selectImage;
@end

@implementation PeriDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetFromHtml];
    [self addGestureRecognizer];
    self.imageCollectionView.dataSource = self;
    self.imageCollectionView.delegate = self;
    [self.imageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
}

- (void)GetFromHtml {
    self.imageArray = [GetHtmlAnalyze searchDetailImageWithHtml:self.detailImageUrl];
    NSLog(@"%@=======%lu",self.imageArray,(unsigned long)self.imageArray.count);
    [ProgressHUD dismiss];
}

- (void)addGestureRecognizer {
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftItemTapped)];
    
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
}

- (void)leftItemTapped
{
    [self.navigationController popViewControllerAnimated:YES];
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
    UICollectionViewCell *selectCell = [self.imageCollectionView cellForItemAtIndexPath:indexPath];
    UIImageView *selectImageView = (UIImageView*)selectCell.backgroundView;
    self.selectImage = selectImageView.image;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"心动了没？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"点击下载" otherButtonTitles:nil, nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"";
    if (!error) {
        message = @"成功保存到相册";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"下载提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else
    {
        message = [error description];
    }
    NSLog(@"message is %@",message);
}
#pragma UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIImageWriteToSavedPhotosAlbum(self.selectImage, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }else if (buttonIndex == 1) {
        NSLog(@"------------");
    }
}

@end
