//
//  PeriDetailViewController.h
//  Peri
//
//  Created by fitfun on 15/11/12.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PeriDetailViewController :BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate>
@property (strong, nonatomic) NSString *detailImageUrl;
@end
