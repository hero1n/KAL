//
//  NSDate+ZRExtension.m
//  ZARI
//
//  Created by 노재원 on 2015. 10. 30..
//  Copyright © 2015년 ZARI. All rights reserved.
//

#import "NSDate+ZRExtension.h"

@implementation NSDate (ZRExtension)

/*
 날짜 포맷 : yyyy-MM-dd
 */

// 오늘 날짜 반환
+ (NSString *)getTodayString{
    return [self getStringWithDate:[NSDate date]];
}

// 일주일 전 날짜 반환
+ (NSString *)getLastWeekString{
    return [self getStringWithDate:[self getDateAgoWithDay:7]];
}

// n일 전 날짜 반환
+ (NSString *)getDateStringWithDayAgo:(NSInteger)day{
    return [self getStringWithDate:[self getDateAgoWithDay:day]];
}

// n일 후 날짜 반환
+ (NSString *)getDateStringWithDayAfter:(NSInteger)day{
    return [self getStringWithDate:[self getDateAfterWithDay:day]];
}

+ (NSString *)getDateStringWithDay:(NSInteger)day{
    return [self getStringWithDate:[self getDateWithDay:day]];
}

// yyyy-MM-dd으로 맞추어 NSStrng 으로 변환
+ (NSString *)getStringWithDate:(NSDate *)date{
    NSString *string;
    if (date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        string = [dateFormatter stringFromDate:date];
    }
    
    return string;
}

// yyyy-MM-dd으로 맞추어 NSDate 으로 변환
+ (NSDate *)getDateWithString:(NSString *)string{
    NSDate *date;
    if (![string isEqual:[NSNull null]]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        date = [dateFormatter dateFromString:string];
    }
    
    return date;
}

// yyyy-MM-dd으로 맞추어 NSString을 반환
+ (NSDate *)getDateWithDay:(NSInteger)day{
    NSDate *date;
    NSInteger second = 60*60*24*day;
    date = [NSDate dateWithTimeIntervalSinceNow:second];
    
    return date;
}

// n일 전 Date
+ (NSDate *)getDateAgoWithDay:(NSInteger)day{
    NSDate *date = [NSDate date];
    if (day > 0) {
        NSInteger second = 60*60*24*day*-1;
        date = [NSDate dateWithTimeIntervalSinceNow:second];
    }else{
        NSLog(@"Error : %d is not correct.",day);
    }
    
    return date;
}

// n일 후 Date
+ (NSDate *)getDateAfterWithDay:(NSInteger)day{
    NSDate *date = [NSDate date];
    if (day >0) {
        NSInteger second = 60*60*24*day;
        date = [NSDate dateWithTimeIntervalSinceNow:second];
    }else{
        NSLog(@"Error : %d is not correct.",day);
    }
    
    return date;
}

- (BOOL)isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endDate{
    if ([self compare:beginDate] == NSOrderedAscending) {
        return NO;
    }
    if ([self compare:endDate] == NSOrderedDescending) {
        return NO;
    }
    return YES;
}

- (NSString *)getStringWithDay:(NSInteger)day{
    NSInteger second = 60*60*24*day;
    NSDate *date = [NSDate dateWithTimeInterval:second sinceDate:self];
    NSString *string = [NSDate getStringWithDate:date];
    
    return string;
}

- (NSDate *)getDateWithDay:(NSInteger)day{
    NSInteger second = 60*60*24*day;
    NSDate *date = [NSDate dateWithTimeInterval:second sinceDate:self];
    
    return date;
}

- (NSString *)getDayOfWeek{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger dayOfWeekInteger = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:self];
    
    NSString *dayOfWeekString;
    switch (dayOfWeekInteger) {
        case 1:
            dayOfWeekString = @"일";
            break;
        case 2:
            dayOfWeekString = @"월";
            break;
        case 3:
            dayOfWeekString = @"화";
            break;
        case 4:
            dayOfWeekString = @"수";
            break;
        case 5:
            dayOfWeekString = @"목";
            break;
        case 6:
            dayOfWeekString = @"금";
            break;
        case 7:
            dayOfWeekString = @"토";
            break;
    }
    
    return dayOfWeekString;
}

@end
