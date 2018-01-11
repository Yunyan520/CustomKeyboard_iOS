//
//  ViewController.m
//  FingerTouch
//
//  Created by king on 2018/1/11.
//  Copyright © 2018年 king. All rights reserved.
//

#import "ViewController.h"
#import "MyLine.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    MyLine *myline = [[MyLine alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    myline.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: myline];
    
    [myline chuanZhi:^(NSString *str) {
        NSLog(@"%@",str);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
