//
//  ViewController.m
//  iOS 黑魔法Method Swizzling
//
//  Created by 赵小波 on 2018/3/5.
//  Copyright © 2018年 赵小波. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+LXZArray.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray *arr=@[@"334",@"3455",@"55555"];
    
    NSString *str=[arr  objectAtIndex:3];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
