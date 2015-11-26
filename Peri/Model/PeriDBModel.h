//
//  PeriDBModel.h
//  Peri
//
//  Created by fitfun on 15/11/25.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeriDBModel : NSObject

+ (instancetype)GetInstance;

- (void)initDB;

- (void)closeDB;

- (void)insertWithDataArray:(NSMutableArray *)dataArray;

- (NSMutableArray*)queryWithPage:(int)page;

@end
