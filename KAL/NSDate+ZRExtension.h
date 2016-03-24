//
//  NSDate+ZRExtension.h
//  ZARI
//
//  Created by 노재원 on 2015. 10. 30..
//  Copyright © 2015년 ZARI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZRExtension)

+ (NSString *)getTodayString;
+ (NSString *)getLastWeekString;
+ (NSString *)getStringWithDate:(NSDate *)date;
+ (NSDate *)getDateWithString:(NSString *)string;
+ (NSString *)getDateStringWithDayAgo:(NSInteger)day;
+ (NSString *)getDateStringWithDayAfter:(NSInteger)day;
+ (NSString *)getDateStringWithDay:(NSInteger)day;
+ (NSDate *)getDateAgoWithDay:(NSInteger)day;
+ (NSDate *)getDateAfterWithDay:(NSInteger)day;
+ (NSDate *)getDateWithDay:(NSInteger)day;
- (BOOL)isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endDate;
- (NSString *)getStringWithDay:(NSInteger)day;
- (NSDate *)getDateWithDay:(NSInteger)day;
- (NSString *)getDayOfWeek;

@end
