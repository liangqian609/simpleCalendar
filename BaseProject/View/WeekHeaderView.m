//
//  WeekHeaderView.m
//  ydbus
//
//  Created by iOS开发本-(梁乾) on 16/2/23.
//  Copyright © 2016年 SIBAT. All rights reserved.
//


#import "WeekHeaderView.h"

@interface WeekHeaderView ()
@property (nonatomic, assign) double width; //决定使用那种宽度的BOOL值

@end

@implementation WeekHeaderView

-(instancetype)initWithWidth:(double)width
{
    if (self = [super init]) {
        _width = width;
        [self initWithHeader];
    }
    return self;
}

- (void)initWithHeader
{
    self.clipsToBounds = YES;
    CGFloat yOffset = heightFor10*4.5;//文本高度
    NSArray *textArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    for (int i = 0; i < textArray.count; i++) {
        UIColor *color = [UIColor whiteColor];
        if (i == 0 || i== 6) {
            color = RGBCOLOR(253, 82, 82);
        }
        [self initHeaderWeekText:textArray[i] titleColor:color x:_width * i y:yOffset];
    }
    
}

// 初始化数据
- (void)initHeaderWeekText:(NSString *)text titleColor:(UIColor *)color x:(CGFloat)x y:(CGFloat)y {
    UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(x, 0, _width, y)];
    [titleText setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    titleText.textAlignment = NSTextAlignmentCenter;
    titleText.textColor = color;
    titleText.text = text;
    titleText.backgroundColor = RGBCOLOR(111,196,161);
    [self addSubview:titleText];
}


@end
