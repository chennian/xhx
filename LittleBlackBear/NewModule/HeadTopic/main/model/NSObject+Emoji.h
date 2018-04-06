//
//  NSObject+Emoji.h
//  LittleBlackBear
//
//  Created by MichaelChan on 6/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Emoji)

//
+ (NSString*)EmojiToUniCode:(NSString *)string;
+ (NSString*)stringToEmoji:(NSString *)string;


+ (BOOL)hasEmoji:(NSString *)string;
@end
