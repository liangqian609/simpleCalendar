//
//  NSDate+Galendar.h
//  ydbus
//
//  Created by iOS开发本-(梁乾) on 16/2/23.
//  Copyright © 2016年 SIBAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Galendar)
/**
 *  计算这个月有多少天
 *
 *  @return 天数
 */
- (NSUInteger)numberOfDaysInCurrentMonth;

/**
 *  获取这个月有多少周
 *
 *  @return 周数
 */
- (NSUInteger)numberOfWeeksInCurrentMonth;

/**
 *  计算这个月的第一天是礼拜几
 *
 *  @return 礼拜几
 */
- (NSUInteger)weeklyOrdinality;

/**
 *  计算这个月最开始的一天
 *
 *  @return 最开始的一天
 */
- (NSDate *)firstDayOfCurrentMonth;

/**
 *  上一个月
 *
 *  @return 上一个月
 */
- (NSDate *)dayInThePreviousMonth;
/**
 *  下一个月
 *
 *  @return 下一个月
 */
- (NSDate *)dayInTheFollowingMonth;

/**
 *  获取年月日对象
 *
 *  @return 年月日对象
 */
- (NSDateComponents *)YMDComponents;

/**
 *  NSString转NSDate YY-MM-DD HH:MM:SS格式
 *
 *  @param dateString 日期字符串
 *
 *  @return 日期
 */
+ (NSDate *)dateFromString:(NSString *)dateString;
/**
 *  NSString转NSDate YY-MM-DD格式
 *
 *  @param dateString YY-MM-DD
 *
 *  @return 日期
 */
+ (NSDate *)dateFromStringYY_MM_DD:(NSString *)dateString;
/**
 *  NSDate转NSString
 *
 *  @param date 日期
 *
 *  @return 日期字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date;

@end
