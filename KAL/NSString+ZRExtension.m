//
//  NSString+ZRExtension.m
//  ZARI
//
//  Created by 노재원 on 2015. 11. 26..
//  Copyright © 2015년 ZARI. All rights reserved.
//

#import "NSString+ZRExtension.h"

@implementation NSString (ZRExtension)

- (NSString *)removeTrim{
    NSCharacterSet *characterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *string;
    
    string = [self stringByTrimmingCharactersInSet:characterSet];
    
    return string;
}

@end
