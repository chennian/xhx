//
//  NSObject+Emoji.m
//  LittleBlackBear
//
//  Created by MichaelChan on 6/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

#import "NSObject+Emoji.h"

@implementation NSObject (Emoji)
+ (BOOL)stringContainsEmoji:(NSString *)string
{
//    NSString* s = @"323";
    
    //NSStringEncoding
    NSString * s = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(s);
    
    NSString* ss = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]  ];
    
    NSLog(ss);
    
    return YES;
}


@end
