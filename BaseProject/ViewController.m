//
//  ViewController.m
//  BaseProject
//
//  Created by tarena on 15/12/15.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "WeekHeaderView.h"
#import "DateCollectionViewCell.h"



@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIView *calendarView;
@property (nonatomic, strong) WeekHeaderView *weekHeaderView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel* monthLabel;//背景月份

@end


static NSString* Identifier = @"GalendarCell";

@implementation ViewController

#pragma mark ---懒加载控件---
- (UIView *)calendarView {
    if(_calendarView == nil) {
        _calendarView = [[UIView alloc] init];
        _calendarView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_calendarView];
        [_calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(heightFor100);
            make.left.mas_equalTo(widhtFor10*2);
            make.right.mas_equalTo(-widhtFor10*2);
            make.height.mas_equalTo(heightFor10*31.5);
        }];
    }
    return _calendarView;
}



- (WeekHeaderView *)weekHeaderView {
    if(_weekHeaderView == nil) {
        _weekHeaderView = [[WeekHeaderView alloc] initWithWidth:dayWidth];//view的宽度为ScreenW - widhtFor10*4
        [_calendarView addSubview:_weekHeaderView];
        [_weekHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(heightFor10*4.5);
        }];
    }
    return _weekHeaderView;
}

- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(dayWidth, heightFor10*4.5);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(widhtFor10*2, heightFor100*1.45, ScreenW - widhtFor10*4, heightFor100*2.7) collectionViewLayout:layout];
        

        _monthLabel = [[UILabel alloc] init];
        _monthLabel.alpha = 0.5;
        _monthLabel.font = [UIFont fontWithName:@"Arial" size:200];

        
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        _monthLabel.textColor = RGBCOLOR(217, 217, 217);
        [_calendarView addSubview:_monthLabel];
        [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(heightFor10*4.5);
            make.centerX.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(ScreenW - widhtFor10*4, heightFor100*2.7));
        }];
        
        
        //collectionView的背景透明，能够看到背景上的月份背景文字
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [_calendarView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_weekHeaderView.mas_bottom).mas_equalTo(0);
            make.left.right.bottom.mas_equalTo(0);
//            make.left.mas_equalTo(widhtFor10*2);
//            make.right.mas_equalTo(-widhtFor10*2);
//            make.height.mas_equalTo(heightFor100*2.7);
        }];
        
    }
    return _collectionView;
}


#pragma mark ---View生命周期---

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(247, 247, 247);
    self.calendarView.hidden = NO;
    self.weekHeaderView.hidden = NO;
    self.collectionView.hidden = NO;
    [self.collectionView registerClass:[DateCollectionViewCell class] forCellWithReuseIdentifier:Identifier];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //让日历初始化滚动到指定的月份，目前设置的是滚动到4月
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---CollectionView代理---

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 12;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 42;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DateCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    //当cell被初始化、重用到第21个出现时才刷新月份数值
    if (indexPath.row == 21) {
        self.monthLabel.text = [@(indexPath.section + 1) stringValue];
    }
    [cell cellLoadData:nil withIndexPath:indexPath];
    
    return cell;
}




@end





