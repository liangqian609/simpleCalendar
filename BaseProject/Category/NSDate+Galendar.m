//
//  NSDate+Galendar.m
//  ydbus
//
//  Created by iOS开发本-(梁乾) on 16/2/23.
//  Copyright © 2016年 SIBAT. All rights reserved.
//

#import "NSDate+Galendar.h"

@implementation NSDate (Galendar)

-(NSUInteger)numberOfDaysInCurrentMonth
{
     // 频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
//    NSDate* textDate = [NSDate date];
//    NSUInteger numberOfDaysInMonth = range.length;
//    return numberOfDaysInMonth;
}

/*计算这个月的第一天是礼拜几*/
- (NSUInteger)weeklyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:self];
}

//获取这个月有多少周
- (NSUInteger)numberOfWeeksInCurrentMonth
{
    NSUInteger weekday = [[self firstDayOfCurrentMonth] weeklyOrdinality];//这个月第一天是星期几
    NSUInteger days = [self numberOfDaysInCurrentMonth];
    NSUInteger weeks = 0;
    
    //只要weekday这个返回值不是1则代表这周肯定不满7天，所以只要>1 就可以 减去第一周的天数，剩余天数除以7，得到倍数和余数：
    if (weekday > 1) {
        weeks += 1, days -= (7 - weekday + 1);
    }
    
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    
    return weeks;
}

- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;

    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    NSTimeInterval  timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];
    NSDate* destDate = [startDate dateByAddingTimeInterval:timeZoneOffset];
    
    return destDate;
    
}

//上一个月
- (NSDate *)dayInThePreviousMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

//下一个月
- (NSDate *)dayInTheFollowingMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

//获取年月日对象
- (NSDateComponents *)YMDComponents
{
    return [[NSCalendar currentCalendar] components:
            NSCalendarUnitYear|
            NSCalendarUnitMonth|
            NSCalendarUnitDay|
            NSCalendarUnitWeekday fromDate:self];
}

//NSString转NSDate yyyy-MM-dd HH:mm:ss格式的
+ (NSDate *)dateFromString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone* localzone = [NSTimeZone systemTimeZone];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:localzone];
    NSDate *date= [dateFormatter dateFromString:dateString];
    
//     NSTimeInterval  timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];//获得系统时区和格林威治时区的秒数差
//    
//      NSDate* destDate = [date dateByAddingTimeInterval:timeZoneOffset];
    
    
    return date;
}
+ (NSDate *)dateFromStringYY_MM_DD:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *date= [dateFormatter dateFromString:dateString];
    
    NSTimeInterval  timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];//获得系统时区和格林威治时区的秒数差
    
    NSDate* destDate = [date dateByAddingTimeInterval:timeZoneOffset];
    
    return destDate;
}

//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}


@end
