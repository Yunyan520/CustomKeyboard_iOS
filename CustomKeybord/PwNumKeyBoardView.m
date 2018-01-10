//
//  PwNumKeyBoardView.m
//  CustomKeybord
//
//  Created by king on 2018/1/10.
//  Copyright © 2018年 king. All rights reserved.
//

#import "PwNumKeyBoardView.h"
@implementation PwNumKeyBoardView
{
    NSArray *_allNums;
    NSMutableArray *_arr1;
    NSMutableArray *_arr2;
    NSMutableArray *_allNumBtns;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _arr1 = [[NSMutableArray alloc] init];
        _arr2 = [[NSMutableArray alloc] init];
        _allNumBtns = [[NSMutableArray alloc] init];
        [self configNumKeyBoard];
    }
    return self;
}
- (void)getAllNums
{
    _allNums = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    _allNums = [_allNums sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [obj1 compare:obj2];
        } else {
            return [obj2 compare:obj1];
        }
    }];
    for (NSInteger i = 0; i < _allNums.count; i++) {
        if(i < 8)
        {
            [_arr1 addObject:_allNums[i]];
        }
        else
        {
            [_arr2 addObject:_allNums[i]];
        }
    }
}
- (void)configNumKeyBoard
{
    [self getAllNums];
    CGFloat leftDiatance = 10;
    CGFloat distance = 8;
    CGFloat btnWidth = (DeviceWidth-leftDiatance*2-distance*2)/3;
    CGFloat bottomBank = 10;
    CGFloat yDistance = 10;
    CGFloat btnStartY = 0;
    CGFloat btnHeight = (self.frame.size.height-btnStartY-bottomBank-yDistance*3)/4;
    for (NSInteger i = 0; i < 3; i++) {
        for (NSInteger j= 0; j < 4; j++) {
            CGFloat btnX = leftDiatance+i*(btnWidth+distance);
            CGFloat btnY = btnStartY+j*(btnHeight+yDistance);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
            btn.layer.cornerRadius = 5;
            btn.layer.masksToBounds = YES;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
            btn.backgroundColor = [UIColor whiteColor];
            if(i == 2 && j == 2)
            {
                [btn setTitle:@"delete" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            }
            else if(i == 2 && j == 3)
            {
                [btn setTitle:@"return" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(returnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [btn addTarget:self action:@selector(numBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_allNumBtns addObject:btn];
            }
            [self addSubview:btn];
        }
    }
    [self reRankNum];
}
- (void)numBtnClicked:(UIButton *)sender
{
    if(self.btnClickedCallback)
    {
        self.btnClickedCallback(sender);
    }
}
- (void)deleteBtnClicked
{
    if(self.deleteBtnClickedCallback)
    {
        self.deleteBtnClickedCallback();
    }
}
- (void)returnBtnClicked
{
    if(self.returnBtnClickedCallback)
    {
        self.returnBtnClickedCallback();
    }
}
- (void)reRankNum
{
    [self getAllNums];
    for (NSInteger i = 0; i < _allNumBtns.count; i++) {
        UIButton *currentBtn = _allNumBtns[i];
        [currentBtn setTitle:_allNums[i] forState:UIControlStateNormal];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
