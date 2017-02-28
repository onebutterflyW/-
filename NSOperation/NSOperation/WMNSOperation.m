//
//  WMNSOperation.m
//  NSOperation
//
//  Created by 软件工程系01 on 17/2/28.
//  Copyright © 2017年 软件工程系01. All rights reserved.
//

#import "WMNSOperation.h"

@implementation WMNSOperation


//如果操作完全终止，则可能无法回收已分配的资源。 因此，应该实现取消事件，并且当它们在操作执行时发生取消事件时可以优雅地退出。

- (void)main {
    
    
    NSLog(@"main before");
    @try {
        
        BOOL isDone = NO;
        
        while (![self isCancelled] && !isDone) {
            
            //执行操作，并在执行后将isDone置为Yes
            sleep(5);
            NSLog(@"currentThread = %@", [NSThread currentThread]);
            NSLog(@"mainThread    = %@", [NSThread mainThread]);
            
            isDone = YES;
            
        }
        
    }
    
    @catch(NSException *e) {
        
        NSLog(@"exception %@",e);
        
    }
    
    NSLog(@"main after");

}


@end
