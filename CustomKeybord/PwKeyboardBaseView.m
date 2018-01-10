//
//  PwKeyboardBaseView.m
//  CustomKeybord
//
//  Created by king on 2018/1/10.
//  Copyright © 2018年 king. All rights reserved.
//

#import "PwKeyboardBaseView.h"

@implementation PwKeyboardBaseView
- (UIButton *)configBtn:(CGRect)btnRect title:(NSString *)title contentView:(UIView *)contentView
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = btnRect;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    btn.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:btn];
    return btn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
