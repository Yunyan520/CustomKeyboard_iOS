//
//  PwLettersKeyboard.m
//  CustomKeybord
//
//  Created by king on 2018/1/10.
//  Copyright © 2018年 king. All rights reserved.
//

#import "PwLettersKeyboard.h"
#import "Constant.h"

@implementation PwLettersKeyboard
{
    NSMutableArray *_firstArr;
    NSMutableArray *_seArr;
    NSMutableArray *_thiArr;
    NSMutableArray *_letterBtns;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _letterBtns = [[NSMutableArray alloc] init];
        _firstArr = [[NSMutableArray alloc] init];
        _seArr = [[NSMutableArray alloc] init];
        _thiArr = [[NSMutableArray alloc] init];
        [self configLetterKeyboard];
    }
    return self;
}
- (void)getAllLetters
{
    NSArray *letters = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
    for (NSInteger i = 0; i < letters.count; i++) {
        if(i < 10)
        {
            [_firstArr addObject:letters[i]];
        }
        else if(i < 19)
        {
            [_seArr addObject:letters[i]];
        }
        else
        {
            [_thiArr addObject:letters[i]];
        }
    }
}
- (void)configLetterKeyboard
{
    [self getAllLetters];
    CGFloat yDistance = 10;
    CGFloat bottomBank = 10;
    
    CGFloat xDistance = 5;
    CGFloat letterBtnWidth = (DeviceWidth-xDistance*(_firstArr.count+1))/_firstArr.count;
    CGFloat btnHeight = (self.frame.size.height-bottomBank-yDistance*3)/4;
    for (NSInteger i = 0; i < _firstArr.count; i++) {
        UIButton *btn = [self configBtn:CGRectMake(xDistance+i*(xDistance+letterBtnWidth), 0, letterBtnWidth, btnHeight) title:_firstArr[i] contentView:self];
        [btn addTarget:self action:@selector(letterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        [_letterBtns addObject:btn];
    }
    
    CGFloat seStartX = xDistance+letterBtnWidth/2;
    CGFloat seBtnY = btnHeight+yDistance;
    for (NSInteger i = 0; i < _seArr.count; i++) {
        UIButton *btn = [self configBtn:CGRectMake(seStartX+i*(xDistance+letterBtnWidth), seBtnY, letterBtnWidth, btnHeight) title:_seArr[i] contentView:self];
        [btn addTarget:self action:@selector(letterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        [_letterBtns addObject:btn];
    }
    
    CGFloat thiStartX = seStartX+(xDistance+letterBtnWidth);
    CGFloat thiBtnY = seBtnY*2;
    for (NSInteger i = 0; i < _thiArr.count; i++) {
        UIButton *btn = [self configBtn:CGRectMake(thiStartX+i*(xDistance+letterBtnWidth), thiBtnY, letterBtnWidth, btnHeight) title:_thiArr[i] contentView:self];
        [btn addTarget:self action:@selector(letterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        [_letterBtns addObject:btn];
    }
    //大写键
    UIButton *upperBtn = [self configBtn:CGRectMake(xDistance, thiBtnY, seStartX+letterBtnWidth-xDistance, btnHeight) title:@"" contentView:self];
    upperBtn.backgroundColor = [UIColor grayColor];
    [upperBtn addTarget:self action:@selector(upperBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //删除键
    UIButton *deleteBtn = [self configBtn:CGRectMake(seStartX+8*(xDistance+letterBtnWidth), thiBtnY, seStartX+letterBtnWidth, btnHeight) title:@"" contentView:self];
    deleteBtn.backgroundColor = [UIColor grayColor];
    [deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //空格键
    CGFloat spaceBtnWidth = seStartX+letterBtnWidth+6*(letterBtnWidth+xDistance)-xDistance;
    UIButton *spaceBtn = [self configBtn:CGRectMake(xDistance, seBtnY*3, spaceBtnWidth, btnHeight) title:@"   " contentView:self];
    [spaceBtn addTarget:self action:@selector(letterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [spaceBtn addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    //确认键
    UIButton *returnBtn = [self configBtn:CGRectMake(seStartX+7*(xDistance+letterBtnWidth), seBtnY*3, seStartX+letterBtnWidth+xDistance+letterBtnWidth, btnHeight) title:@"return" contentView:self];
    [returnBtn addTarget:self action:@selector(returnBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [returnBtn addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
}
- (void)letterBtnClicked:(UIButton *)sender
{
    [self buttonBackGroundNormal:sender];
    if(self.btnClickedCallback)
    {
        self.btnClickedCallback(sender);
    }
}
- (void)upperBtnClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    for (NSInteger i = 0; i < _letterBtns.count; i++) {
        UIButton *currenBtn = _letterBtns[i];
        NSString *currentTitle = currenBtn.currentTitle;
        [currenBtn setTitle:sender.selected?[currentTitle uppercaseString]:[currentTitle lowercaseString] forState:UIControlStateNormal];
    }
}
- (void)deleteBtnClicked:(UIButton *)sender
{
    if(self.deleteBtnClickedCallback)
    {
        self.deleteBtnClickedCallback();
    }
}
- (void)returnBtnClicked:(UIButton *)sender
{
    [self buttonBackGroundNormal:sender];
    if(self.returnBtnClickedCallback)
    {
        self.returnBtnClickedCallback();
    }
}- (void)buttonBackGroundNormal:(UIButton *)sender
{
    sender.backgroundColor = [UIColor whiteColor];
}
- (void)buttonBackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = [UIColor grayColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
