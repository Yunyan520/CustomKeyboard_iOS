//
//  PwCustomKeyboard.m
//  CustomKeybord
//
//  Created by king on 2018/1/9.
//  Copyright © 2018年 king. All rights reserved.
//

#import "PwCustomKeyboard.h"
#import "PwLettersKeyboard.h"
#import "PwNumKeyBoardView.h"
#import "PwSymbolKeyboard.h"
typedef NS_ENUM(NSInteger, CustomKeyboardType)
{
    CustomKeyboardType_Num  = 1,//数字
    CustomKeyboardType_Letters  = 2,//字母
    CustomKeyboardType_Symbol  = 3//符号
};
@interface PwCustomKeyboard()
/** 需要操作的textView */
@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, strong) UITextField *textField;
/** 三种键盘样式---数字、字母、符号 */
@property(nonatomic, strong) PwLettersKeyboard *letterKeyboard;
@property(nonatomic, strong) PwNumKeyBoardView *numKeyboard;
@property(nonatomic, strong) PwSymbolKeyboard *symbolKeyboard;
@end

@implementation PwCustomKeyboard
static CGFloat keyY = 100;
- (instancetype)initWithTextView:(UITextView *)textView
{
    self = [super init];
    if(self)
    {
        self.textView = textView;
        [self viewInit];
    }
    return self;
}
- (instancetype)initWithTextField:(UITextField *)field
{
    self = [super init];
    if(self)
    {
        self.textField = field;
        [self viewInit];
    }
    return self;
}
- (void)viewInit
{
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self configKeyboardType];
    [self configNumKeyBoard];
    [self configLetterKeyboard];
    [self configSymbolKeyboard];
}
/**
  *  锁定键盘高度
  */
- (void)setFrame:(CGRect)frame
{
    frame.size.height = 350;//AUTO_ADAPT_SIZE_VALUE(233, 253, 283);
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    bounds.size.height = 350;//AUTO_ADAPT_SIZE_VALUE(233, 253, 283);
    [super setBounds:bounds];
}
//创建三种键盘切换button
- (void)configKeyboardType
{
    NSInteger btnTypeCount = 3;
    CGFloat btnWidth = (DeviceWidth/2)/btnTypeCount;
    CGFloat btnHeight = 20;
    NSArray *titles = @[@"数字",@"字母",@"符号"];
    for (NSInteger i = 0; i < btnTypeCount; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((DeviceWidth/2)+i*btnWidth, 5, btnWidth, btnHeight);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        btn.tag = (CustomKeyboardType)i+1;
        if(i == 1)
        {
            //默认字母键盘
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(typeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
//点击切换键盘
- (void)typeBtnClicked:(UIButton *)sender
{
    if(sender.selected)
    {
        return;
    }
    UIButton *btn_num = [self viewWithTag:CustomKeyboardType_Num];
    UIButton *btn_let = [self viewWithTag:CustomKeyboardType_Letters];
    UIButton *btn_sym = [self viewWithTag:CustomKeyboardType_Symbol];
    sender.selected = YES;
    if(sender == btn_num)
    {
        btn_let.selected = NO;
        btn_sym.selected = NO;
        [self clickNumTypeBtn];
    }
    if(sender == btn_let)
    {
        btn_num.selected = NO;
        btn_sym.selected = NO;
        [self clickLetterTypeBtn];
    }
    if(sender == btn_sym)
    {
        btn_num.selected = NO;
        btn_let.selected = NO;
        [self clickSymbleTypeBtn];
    }
}
//创建字母键盘
- (void)configLetterKeyboard
{
    self.letterKeyboard = [[PwLettersKeyboard alloc] initWithFrame:CGRectMake(0, keyY, DeviceWidth, self.frame.size.height-keyY)];
    WS(weakSelf, self);
    [self.letterKeyboard setBtnClickedCallback:^(NSString *str) {
        [weakSelf.textView?weakSelf.textView:weakSelf.textField  insertText:str];
    }];
    [self.letterKeyboard setDeleteBtnClickedCallback:^{
        [weakSelf.textView?weakSelf.textView:weakSelf.textField deleteBackward];
    }];
    [self.letterKeyboard setReturnBtnClickedCallback:^{
        if([weakSelf.delegate respondsToSelector:@selector(customKeyboardDidClickedReturn:)])
        {
            [weakSelf.delegate customKeyboardDidClickedReturn:weakSelf];
        }
    }];
    [self addSubview:self.letterKeyboard];
}
//创建数字键盘
- (void)configNumKeyBoard
{
    self.numKeyboard = [[PwNumKeyBoardView alloc] initWithFrame:CGRectMake(0, keyY, DeviceWidth, self.frame.size.height-keyY)];
    WS(weakSelf, self);
    [self.numKeyboard setBtnClickedCallback:^(NSString *str) {
        [weakSelf.textView?weakSelf.textView:weakSelf.textField insertText:str];
    }];
    [self.numKeyboard setDeleteBtnClickedCallback:^{
        [weakSelf.textView?weakSelf.textView:weakSelf.textField deleteBackward];
    }];
    [self.numKeyboard setReturnBtnClickedCallback:^{
        if([weakSelf.delegate respondsToSelector:@selector(customKeyboardDidClickedReturn:)])
        {
            [weakSelf.delegate customKeyboardDidClickedReturn:weakSelf];
        }
    }];
}
//创建符号键盘
- (void)configSymbolKeyboard
{
    self.symbolKeyboard = [[PwSymbolKeyboard alloc] initWithFrame:CGRectMake(0, keyY, DeviceWidth, self.frame.size.height-keyY)];
    WS(weakSelf, self);
    [self.symbolKeyboard setBtnClickedCallback:^(NSString *str) {
        [weakSelf.textView?weakSelf.textView:weakSelf.textField insertText:str];
    }];
    [self.symbolKeyboard setDeleteBtnClickedCallback:^{
        [weakSelf.textView?weakSelf.textView:weakSelf.textField deleteBackward];
    }];
    [self.symbolKeyboard setReturnBtnClickedCallback:^{
        if([weakSelf.delegate respondsToSelector:@selector(customKeyboardDidClickedReturn:)])
        {
            [weakSelf.delegate customKeyboardDidClickedReturn:weakSelf];
        }
    }];
}
- (void)clickNumTypeBtn
{
    [self.letterKeyboard removeFromSuperview];
    [self.symbolKeyboard removeFromSuperview];
    [self addSubview:self.numKeyboard];
    [self.numKeyboard reRankNum];
}
- (void)clickLetterTypeBtn
{
    [self.numKeyboard removeFromSuperview];
    [self.symbolKeyboard removeFromSuperview];
    [self addSubview:self.letterKeyboard];
}
- (void)clickSymbleTypeBtn
{
    [self.numKeyboard removeFromSuperview];
    [self.letterKeyboard removeFromSuperview];
    [self addSubview:self.symbolKeyboard];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
