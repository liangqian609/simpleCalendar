//
//  DateCollectionViewCell.m
//  BaseProject
//
//  Created by iOS开发本-(梁乾) on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "DateCollectionViewCell.h"
#import "NSDate+Galendar.h"

#define Year 2016

@interface DateCollectionViewCell ()
@property (nonatomic, strong) UILabel *dayLabel;

@end

@implementation DateCollectionViewCell
{
    NSInteger weekDays;
    NSInteger days;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.dayLabel];
    }
    return self;
}

- (UILabel *)dayLabel {
	if(_dayLabel == nil) {
		_dayLabel = [[UILabel alloc] init];
        _dayLabel.textColor = [UIColor redColor];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.font = [UIFont systemFontOfSize:20];
	}
	return _dayLabel;
}

-(void)layoutSubviews
{
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

-(void)getCellNumbers:(NSInteger)section
{
    NSCalendar* calendar = [NSCalendar currentCalendar];//选择的是罗马用户当前的操作系统模式的日历
    
    //构建一个每月的日期
    NSDateComponents* component = [[NSDateComponents alloc] init];
    [component setYear:Year];
    [component setMonth:(section + 1)];
    [component setDay:5];
    [component setHour:12];
    [component setMinute:0];
    [component setSecond:0];
    [component setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDate* date = [calendar dateFromComponents:component];
    //获得每个月的第一天是星期几
    weekDays = [[date firstDayOfCurrentMonth] weeklyOrdinality];
    //获得每个月的天数
    days = [date numberOfDaysInCurrentMonth];
}

-(void)cellLoadData:(id)data withIndexPath:(NSIndexPath *)indexPath
{
    //防重用，设置没有用到的属性为空
    self.backgroundColor = nil;
    self.dayLabel.text = nil;

    [self getCellNumbers:indexPath.section];
    
        if (indexPath.row < weekDays - 1) {
            //本月1号前的空白，可以设置为上月的结束日期
            self.backgroundColor = [UIColor clearColor];
            
        }else if(indexPath.row < weekDays + days - 1){
            //本月的日期
            self.dayLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row - weekDays  + 2];
            
        }else{
            //本月结束后的空白，可以设置为下月的提前日期
            self.backgroundColor = [UIColor clearColor];
            
        }
}

@end
