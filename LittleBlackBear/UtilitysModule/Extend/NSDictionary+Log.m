
//
//  Created by apple on 16/4/9.
//  Copyright © 2016年 Batac_Lee. All rights reserved.
//
/*
    字典分类;
    注释:不用导入头文件,直接拉进项目即可使用;
    功能:可以将从网络获得数据中的编码形式转为中文;
 */
#import <Foundation/Foundation.h>


@implementation NSDictionary (Log)

-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *string = [NSMutableString string];
    
    [string appendString:@"{"];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [string appendFormat:@"%@:",key];
        [string appendFormat:@"%@,",obj];
    }];
    
    [string appendString:@"}"];
    
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    return string;
}

@end


@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    return strM.copy;
}

@end

