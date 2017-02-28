//
//  ViewController.m
//  NSOperation
//
//  Created by 软件工程系01 on 17/2/28.
//  Copyright © 2017年 软件工程系01. All rights reserved.
//

#import "ViewController.h"
#import "WMConcurrentOperation.h"
#import "WMNSOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   

    
//    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"NSOperation" forKey:@"练习NSOperation"];
//    
//    //传递给invoOper方法一个对象,执行的操作方法与调用start的方法在同一个线程，并且是同步执行的方法执行完毕，satrt才执行完
//    NSInvocationOperation *invoOper = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operationSelector:) object:dic];
//    NSLog(@"start before:%@",[NSThread currentThread]);
//    [invoOper start];
//    NSLog(@"start sfter:%@",[NSThread currentThread]);
   
    
    
    
// 
//    NSBlockOperation *blOp = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"1 start");
//        sleep(5);
//        NSLog(@"1 current thread = %@",[NSThread currentThread]);
//        NSLog(@"1 main  thread = %@",[NSThread mainThread]);
//        NSLog(@"1 end");
//    }];
//    
//    
//    [blOp addExecutionBlock:^{
//        NSLog(@"2 start");
//        sleep(5);
//        NSLog(@"2 current thread = %@",[NSThread currentThread]);
//        NSLog(@"2 main  thread = %@",[NSThread mainThread]);
//        NSLog(@"2 end");
//    }];
//    
//    
//    [blOp addExecutionBlock:^{
//        NSLog(@"3 start");
//        sleep(5);
//        NSLog(@"3 current thread = %@",[NSThread currentThread]);
//        NSLog(@"3 main  thread = %@",[NSThread mainThread]);
//        NSLog(@"3 end");
//    }];
//    
//    
//    NSLog(@"start before: %@",[NSThread currentThread]);
//    [blOp start];
//    NSLog(@"start after: %@",[NSThread mainThread]);
//  
    
    
    //自定义非并发的操作
//    WMNSOperation *wmOp = [[WMNSOperation alloc]init];
//    
//    NSLog(@"start before");
//    [wmOp start];
//    NSLog(@"start after");
   
    
   
    //自定义并发的操作
    WMConcurrentOperation *op = [[WMConcurrentOperation alloc]init];
   
   [op performOperation:op];
   
    

}


-(void)operationSelector:(NSDictionary *)dict{
    
    NSLog(@"dictValue=%@",[dict valueForKey:@"练习NSOperation"]);
    sleep(10);
    NSLog(@"current thread=%@",[NSThread currentThread]);

}


@end
