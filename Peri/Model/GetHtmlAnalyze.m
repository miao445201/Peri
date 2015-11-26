//
//  GetHtmlAnalyze.m
//  Peri
//
//  Created by fitfun on 15/11/11.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "GetHtmlAnalyze.h"
#import "imageModel.h"
#import "PeriDBModel.h"
@implementation GetHtmlAnalyze

+ (void)GetFromHtml:(int)pageCount {
    NSString *htmlUrl = [NSString stringWithFormat:@"http://www.meizitu.com/a/list_1_%d.html",pageCount];
    NSMutableArray *imageArray = [GetHtmlAnalyze searchImageWithHtml:htmlUrl];
    NSMutableArray *imageDetailUrlArray = [GetHtmlAnalyze searchImageDetailUrlWithHtml:htmlUrl];
    NSMutableArray *dataArray = [[NSMutableArray alloc]initWithCapacity:100];
    for (int i = 0; i < 30; i++) {
        imageModel *model = [[imageModel alloc]init];
        model.imageUrl = [imageArray objectAtIndex:i];
        model.imageDetail = [imageDetailUrlArray objectAtIndex:i];
        [dataArray addObject:model];
    }
    [[PeriDBModel GetInstance]initDB];
    [[PeriDBModel GetInstance]insertWithDataArray:dataArray];
    [[PeriDBModel GetInstance]closeDB];
}
+ (NSMutableArray *) searchImageWithHtml:(NSString *)html {
    NSString *htmlString = [GetHtmlAnalyze urlstring:html];
    NSLog(@"%@",htmlString);
    NSString *regular = [NSString stringWithFormat:@"(?<=img src=\").*?jpg"];
    NSMutableArray *dict = [GetHtmlAnalyze substringByhtmlStr:htmlString regular:regular];
    NSLog(@"%@",dict);
    return dict;
}

+ (NSMutableArray *) searchTitleWithHtml:(NSString *)html {
    NSString *htmlString = [GetHtmlAnalyze urlstring:html];
    NSLog(@"%@",htmlString);
    //NSString *regular = [NSString stringWithFormat:@"((?=alt=\")[^<]*></a>) | (alt=\"<b>[^<]*</b>)"];
    NSString *regular2 = [NSString stringWithFormat:@"alt=\"[^<b>][^<]*[^</b>]"];
    NSMutableArray *dict = [GetHtmlAnalyze substringByhtmlStr:htmlString regular:regular2];
    NSLog(@"%@",dict);
    return dict;
}

+ (NSMutableArray *)searchDetailImageWithHtml:(NSString *)html {
    NSString *htmlString = [GetHtmlAnalyze urlstring:html];
    NSLog(@"%@",htmlString);
    NSString *regular = [NSString stringWithFormat:@"(?<=src=\").*?jpg"];
    NSMutableArray *dict = [GetHtmlAnalyze substringByhtmlStr:htmlString regular:regular];
    NSLog(@"%@",dict);
    NSEnumerator *enumerator = [dict objectEnumerator];
    id object;
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:100];
    
    while ((object = [enumerator nextObject]) != nil){
        if([object rangeOfString:@"im"].location == NSNotFound) {
                [array addObject:object];
        }
    }
    return array;
}
+ (NSMutableArray *) searchImageDetailUrlWithHtml:(NSString *)html {
    NSString *htmlString = [GetHtmlAnalyze urlstring:html];
    NSLog(@"%@",htmlString);
    NSString *regular = [NSString stringWithFormat:@"(?<=href=\").*?html"];
    NSMutableArray *dict = [GetHtmlAnalyze substringByhtmlStr:htmlString regular:regular];
    NSLog(@"%@",dict);
    NSEnumerator *enumerator = [dict objectEnumerator];
    id object;
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:100];
    
    while ((object = [enumerator nextObject]) != nil){
        if([object rangeOfString:@"meizitu"].location != NSNotFound) {
            NSString *regex = @".*[0-9].*";
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            if ([predicate evaluateWithObject:object] == YES) {
                [array addObject:object];
            }
        }
    }
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for (unsigned i = 0 ; i< [array count]; i ++) {
        if ( [imageArray containsObject:array[i]]==NO) {
            [imageArray addObject:array[i]];
        }
    }    return imageArray;
}

+ (NSString*) urlstring:(NSString*)strurl {
    NSURL *url = [NSURL URLWithString:strurl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    NSLog(@" html = %@",retStr);
    return retStr;
}

+ (NSMutableArray *)substringByhtmlStr:(NSString*)htmlStr regular:(NSString *)regular{
    
    NSString * reg=regular;
    
    NSRange r= [htmlStr rangeOfString:reg options:NSRegularExpressionSearch];
    
    NSMutableArray *arr=[NSMutableArray array];
    
    if (r.length != NSNotFound &&r.length != 0) {
        
        int i=0;
        
        while (r.length != NSNotFound &&r.length != 0) {
            
            NSLog(@"index = %i regIndex = %lu loc = %lu",(++i),(unsigned long)r.length,(unsigned long)r.location);
            
            NSString* substr = [htmlStr substringWithRange:r];
            
            NSLog(@"substr = %@",substr);
            
            [arr addObject:substr];
            
            NSRange startr=NSMakeRange(r.location+r.length, [htmlStr length]-r.location-r.length);
            
            r = [htmlStr rangeOfString:reg options:NSRegularExpressionSearch range:startr];
        }
    }
    return arr;
}

+ (id)jsonReturn:(NSString *)responseString {
    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]]){
        
        NSDictionary *dictionary = (NSDictionary *)jsonObject;
        
        NSLog(@"Dersialized JSON Dictionary = %@", dictionary);
        return dictionary;
        
    }else if ([jsonObject isKindOfClass:[NSArray class]]){
        
        NSArray *nsArray = (NSArray *)jsonObject;
        NSLog(@"Dersialized JSON Array = %@", nsArray);
        return nsArray;
        
    } else {
        
        NSLog(@"An error happened while deserializing the JSON data.");
        return error;
    }
}

@end
