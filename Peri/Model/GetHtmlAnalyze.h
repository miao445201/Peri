//
//  GetHtmlAnalyze.h
//  Peri
//
//  Created by fitfun on 15/11/11.
//  Copyright © 2015年 miao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetHtmlAnalyze : NSObject

+ (void)GetFromHtml:(int)pageCount;

+ (NSMutableArray *) searchTitleWithHtml:(NSString *)html;

+ (NSMutableArray *) searchImageWithHtml:(NSString *)html;

+ (NSMutableArray *)searchDetailImageWithHtml:(NSString *)html;

+ (NSMutableArray *) searchImageDetailUrlWithHtml:(NSString *)html;

+ (NSString *) urlstring:(NSString*)strurl;

+ (NSMutableArray *)substringByhtmlStr:(NSString*)htmlStr regular:(NSString *)regular;

+ (id)jsonReturn:(NSString *)responseString;

@end
