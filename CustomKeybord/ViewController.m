//
//  ViewController.m
//  CustomKeybord
//
//  Created by king on 2018/1/9.
//  Copyright © 2018年 king. All rights reserved.
//

#import "ViewController.h"
#import "PwCustomKeyboard.h"
@interface ViewController ()<CustomKeyboardDelegate>
@property (strong, nonatomic) UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 100, 300, 44)];
    self.textView.backgroundColor = [UIColor greenColor];
    PwCustomKeyboard *keyboard = [[PwCustomKeyboard alloc] init];
    keyboard.delegate = self;
    self.textView.inputView = keyboard;
    [self.textView becomeFirstResponder];
    [self.view addSubview:self.textView];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - HJFCustomLoginKeyboardDelegate

- (void)customKeyboard:(PwCustomKeyboard *)customKeyboard didClickAtNormalButton:(UIButton *)button
{
    [self.textView insertText:button.currentTitle];
}
- (void)customKeyboardDidClickedDelete:(PwCustomKeyboard *)customKeyboard
{
    [self.textView deleteBackward];
}
- (void)customKeyboardDidClickedReturn:(PwCustomKeyboard *)customKeyboard
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
