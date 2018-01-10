//
//  PwKeyboardBaseView.h
//  CustomKeybord
//
//  Created by king on 2018/1/10.
//  Copyright © 2018年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PwKeyboardBaseView : UIView
@property(nonatomic, copy) void(^btnClickedCallback)(UIButton *btn);
@property(nonatomic, copy) void(^deleteBtnClickedCallback)(void);
@property(nonatomic, copy) void(^returnBtnClickedCallback)(void);
- (UIButton *)configBtn:(CGRect)btnRect title:(NSString *)title contentView:(UIView *)contentView;
@end
