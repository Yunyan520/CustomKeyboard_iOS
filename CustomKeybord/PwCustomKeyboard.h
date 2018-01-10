//
//  PwCustomKeyboard.h
//  CustomKeybord
//
//  Created by king on 2018/1/9.
//  Copyright © 2018年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PwCustomKeyboard;
@protocol CustomKeyboardDelegate <NSObject>
- (void)customKeyboard:(PwCustomKeyboard *)customKeyboard didClickAtNormalButton:(UIButton *)button;
/** 点击了删除键 */
- (void)customKeyboardDidClickedDelete:(PwCustomKeyboard *)customKeyboard;
/** 点击return按钮 */
- (void)customKeyboardDidClickedReturn:(PwCustomKeyboard *)customKeyboard;
@end
@interface PwCustomKeyboard : UIView
- (instancetype)init;
@property (nonatomic, weak) id<CustomKeyboardDelegate> delegate;
@end
