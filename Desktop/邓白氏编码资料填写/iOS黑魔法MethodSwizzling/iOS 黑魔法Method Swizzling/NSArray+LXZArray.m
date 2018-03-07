//
//  NSArray+LXZArray.m
//  iOS 黑魔法Method Swizzling
//
//  Created by 赵小波 on 2018/3/5.
//  Copyright © 2018年 赵小波. All rights reserved.
//

#import "NSArray+LXZArray.h"
#import <objc/runtime.h>

@implementation NSArray (LXZArray)
+ (void)load {
//    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
//    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(lxz_objectAtIndex:));
//    method_exchangeImplementations(fromMethod, toMethod);
    
    
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(lxz_objectAtIndex:));
    
    NSLog(@"%p", method_getImplementation(fromMethod));
    NSLog(@"%p", method_getImplementation(toMethod));
    method_exchangeImplementations(fromMethod, toMethod);
    
    NSLog(@"%p", method_getImplementation(fromMethod));
    NSLog(@"%p", method_getImplementation(toMethod));
    method_exchangeImplementations(fromMethod, toMethod);
    
    NSLog(@"%p", method_getImplementation(fromMethod));
    NSLog(@"%p", method_getImplementation(toMethod));
    method_exchangeImplementations(fromMethod, toMethod);
    
    NSLog(@"%p", method_getImplementation(fromMethod));
    NSLog(@"%p", method_getImplementation(toMethod));
    
  
}

- (id)lxz_objectAtIndex:(NSUInteger)index {
    if (self.count-1 < index) {
        // 这里做一下异常处理，不然都不知道出错了。
        @try {
            return [self lxz_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息，方便我们调试。
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    } else {
        return [self lxz_objectAtIndex:index];
    }
}

@end
