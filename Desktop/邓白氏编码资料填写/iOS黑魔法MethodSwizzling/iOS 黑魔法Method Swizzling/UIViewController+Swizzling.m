//
//  UIViewController+Swizzling.m
//  iOS 黑魔法Method Swizzling
//
//  Created by 赵小波 on 2018/3/5.
//  Copyright © 2018年 赵小波. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (Swizzling)
+(void)load{
    
    static  dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
    });
    
    //通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，如果是类方法就使用class_getClassMethod()函数获取。
    Method fromMethod=class_getInstanceMethod([self  class], @selector(viewDidLoad));
    Method toMethod=class_getInstanceMethod([self  class], @selector(swizzlingViewDidLoad));
    /**
     *  我们在这里使用class_addMethod()函数对Method Swizzling做了一层验证，如果self没有实现被交换的方法，会导致失败。
     *  而且self没有交换的方法实现，但是父类有这个方法，这样就会调用父类的方法，结果就不是我们想要的结果了。
     *  所以我们在这里通过class_addMethod()的验证，如果self实现了这个方法，class_addMethod()函数将会返回NO，我们就可以对其进行交换了。
     
    加个判断  如果要交换的方法实现了 就交换
     */
    
    if (!class_addMethod([self  class],@selector(swizzlingViewDidLoad),method_getImplementation(toMethod),method_getTypeEncoding(toMethod))) {
        
        method_exchangeImplementations(fromMethod,toMethod);
    }
}
/**
 利用runtime在项目运行时后交换viewDidLoad
 **/
-(void)swizzlingViewDidLoad{
    
    NSString *str=[NSString  stringWithFormat:@"%@",self.class];
    //价格判断  将系统的 uivewcontroller对象剔除掉
    if (![str containsString:@"UI"]) {
        
        
        NSLog(@"统计打点：%@",self.class);
        
        
        
    }
    
    [self  swizzlingViewDidLoad];
}
@end
