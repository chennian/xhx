//
//  NSObject+Emoji.m
//  LittleBlackBear
//
//  Created by MichaelChan on 6/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

#import "NSObject+Emoji.h"

@implementation NSObject (Emoji)
+ (NSString*)EmojiToUniCode:(NSString *)string
{
//    NSString* s = @"323";
    
    NSString *uniStr = [NSString stringWithUTF8String:[string UTF8String]];
    
    
    NSData *uniData = [uniStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *goodStr = [[NSString alloc] initWithData:uniData encoding:NSUTF8StringEncoding] ;
//    NSLog(goodStr);
    
    
    return goodStr;
}
+ (NSString*)stringToEmoji:(NSString *)string{
    const char *jsonString = [string UTF8String];// goodStr 服务器返回的 json
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    
    if ([[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding] == NULL){
        return @"";
    }
//    NSString *goodMsg1 = ;

    
//    [NSString alloc]ini
    return [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];//goodMsg1;
}

+ (BOOL)hasEmoji:(NSString *)string{
    if ([string containsString:@"\\u"]){
        return YES;
    }
    return NO;
    
}
@end
