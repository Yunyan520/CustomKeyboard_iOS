//
//  MyLine.m
//  FingerTouch
//
//  Created by king on 2018/1/11.
//  Copyright © 2018年 king. All rights reserved.
//

#import "MyLine.h"
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface MyLine ()
//记录选中按钮
@property (nonatomic)NSMutableArray *selectArray;
//记录当前手势所在点，用来划线
@property (nonatomic)CGPoint currentPoint;

@end
@implementation MyLine
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _selectArray = [[NSMutableArray alloc]init];
        [self createButton];
        
    }
    return self;
}
//绘图
- (void)drawRect:(CGRect)rect {
    
    //获取绘图需要的上下文，他是专门用来保存绘画期间的数据的
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    if (self.selectArray.count == 0) {
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置填充颜色
    [[UIColor blueColor] setFill];
    
    //设置描边颜色
    [[UIColor redColor] setStroke];
    
    //设置线宽
    CGContextSetLineWidth(contextRef, 10);
    //线的样式
    path.lineJoinStyle= kCGLineCapButt;
    //设置颜色
    [[UIColor colorWithRed:56/255.0 green:210/255.0 blue:254/255.0 alpha:0.5] set];
    //便利按钮  添加连线
    for (int i = 0; i < self.selectArray.count; i++) {
        UIButton *button = self.selectArray[i];
        if (i == 0) {
            //设置起点
            [path moveToPoint:button.center];
        }else{
            //添加连线
            [path addLineToPoint:button.center];
        }
    }
    
    //如果按钮不在当前点，就把当前触摸点作为当前点，可以使线随着拖动位置变化而变化
    [path addLineToPoint:_currentPoint];
    //把路径添加到上下文
    CGContextAddPath(contextRef, path.CGPath);
    //渲染
    CGContextStrokePath(contextRef);
}

//创建button
- (void)createButton{
    //左侧距离
    float leftW = (SCREEN_WIDTH - 250)/2;
    float heightW = 100;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            if (i == 0) {
                button.tag = 100+j;
                button.frame = CGRectMake(leftW+100*j, heightW, 50, 50);
            }else if (i == 1){
                button.tag = 103+j;
                button.frame = CGRectMake(leftW+100*j, heightW+100, 50, 50);
            }else if (i == 2){
                button.tag = 106+j;
                button.frame = CGRectMake(leftW+100*j, heightW+200, 50, 50);
            }
            [button setBackgroundImage:[UIImage imageNamed:@"0.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"2.jpg"] forState:UIControlStateSelected];
            button.backgroundColor = [UIColor yellowColor];
            button.userInteractionEnabled = NO;
            
            [self addSubview:button];
        }
    }
    
    
}

//根据触摸点找到对应的button
- (UIButton*)buttonWithPoint:(CGPoint)point{
    for (UIButton *button in self.subviews) {
        //注意这个：CGRectContainsPoint(btn.frame, point) 如果point这个点包含在btn的frame范围内
        if (CGRectContainsPoint(button.frame, point))
        {
            return button;
        }
    }
    return nil;
}


//开始触摸
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //拿到触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    //根据触摸点找到对应的button
    UIButton *button = [self buttonWithPoint:point];
    
    if (button && (button.selected == NO)) {
        button.selected = YES;
        //把这个button添加到数组中
        [self.selectArray addObject:button];
    }
    
}

//触摸移动过程中
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //拿到触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    //根据触摸点找到对应的button
    UIButton *button = [self buttonWithPoint:point];
    
    if (button && (button.selected == NO)) {
        button.selected = YES;
        //把这个button添加到数组中
        [self.selectArray addObject:button];
    }else{
        _currentPoint = point;
    }
    
    //调用绘图方法
    [self setNeedsDisplay];
}

//触摸结束
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UIButton *button in self.subviews) {
        button.selected = NO;
    }
    
    NSMutableString *path = [[NSMutableString alloc]init];
    for (UIButton *button in _selectArray) {
        [path appendFormat:@"%ld",button.tag - 100];
    }
    if (self.MyBlock) {
        self.MyBlock(path);
    }
    [_selectArray removeAllObjects];
    [self setNeedsDisplay];
    
}

- (void)chuanZhi:(NewBlock)block{
    self.MyBlock = block;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
