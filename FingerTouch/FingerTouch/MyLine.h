//
//  MyLine.h
//  FingerTouch
//
//  Created by king on 2018/1/11.
//  Copyright © 2018年 king. All rights reserved.
//

#import <UIKit/UIKit.h>
//一会要传值的类型
typedef void(^NewBlock)(NSString*);
@interface MyLine : UIView
//声明block的属性
@property (nonatomic) NewBlock MyBlock;

//声明block方法
- (void)chuanZhi:(NewBlock)block;
@end
