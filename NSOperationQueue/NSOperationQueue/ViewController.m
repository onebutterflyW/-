//
//  ViewController.m
//  NSOperationQueue
//
//  Created by 软件工程系01 on 17/2/28.
//  Copyright © 2017年 软件工程系01. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSOperationQueue *queue;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    queue = [NSOperationQueue new];
    //[queue setMaxConcurrentOperationCount:1];
    
    for (NSUInteger i = 0; i < 3; i ++) {
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:@"你好" forKey:@"打招呼"];
        NSInvocationOperation *inOp = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operationCountSelector: )object:dict];
        [queue addOperation:inOp];
        
    }
    
    queue.suspended = YES;
    // 然后再添加一个操作
    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"hello"forKey:@"打招呼"];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationCountSelector:) object:dict];
    [queue addOperation:op];
  
    
}


-(void)operationCountSelector:(NSDictionary *)dict{

    // 接收传进来的dict
    NSLog(@"dictValue = %@", [dict valueForKey:@"打招呼"]);
    sleep(3);  // 加个睡眠模仿耗时操作
    NSLog(@"currentThread = %@", [NSThread currentThread]);
    
    
    //在suspended改为 NO 之后才开始执行的。
    queue.suspended = NO;

}




@end
