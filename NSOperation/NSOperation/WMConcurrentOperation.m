//
//  WMConcurrentOperation.m
//  NSOperation
//
//  Created by 软件工程系01 on 17/2/28.
//  Copyright © 2017年 软件工程系01. All rights reserved.
//

#import "WMConcurrentOperation.h"

@interface WMConcurrentOperation ()
{
    BOOL  executing;
    BOOL  finishing;

}
@end


@implementation WMConcurrentOperation


-(id)init{

    self = [super init];
    if (self) {
        
        executing = NO;
        finishing = NO;
        
    }
    
    return self;

}

//该方法只是启动一个新线程并配置它调用main方法。 该方法还更新excuting成员变量，并为isExecuting键路径生成KVO通知以反映该值的变化。 随着其工作完成，此方法然后简单地返回，留下新分离的线程（main）来执行实际任务。
-(void)start{

    
      NSLog(@"start before=currentThread = %@",[NSThread currentThread]);
    //在开始任务前，要检查是否取消操作
    if ([self isCancelled]) {
        
        //如果操作取消，设置isFinished的状态
        [self willChangeValueForKey:@"isFinished"];
        finishing = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
        
    }
    
    //如果操作没被取消，开始执行任务
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExcuting"];
    
     NSLog(@"start after=currentThread = %@",[NSThread currentThread]);
}

//main方法是新线程的入口点。 它执行与操作对象相关联的工作，并在最后完成该工作时调用自定义的completeOperation方法。 completeOperation方法然后为isExecuting和isFinished键路径生成所需的KVO通知，以反映操作状态的更改。
-(void)main{
    
    NSLog(@"main begin");
    @try {
        
      
        //必须为自定义的operation提供autorelease pool，因为operation完成后需要销毁
        @autoreleasepool {
            
           
            //提供变量标识，表示要执行的操作是否完成
            BOOL isDone = NO;
            
            while (![self isCancelled] && !isDone) {
                
                //执行操作封装的任务
                NSLog(@"任务开始睡5秒");
                sleep(5);
                NSLog(@"currentThread = %@",[NSThread currentThread]);
             
                
                //操作完成
                isDone = YES;
            }
            [self completeOperation];
        }
    
    }
    @catch (NSException *e) {
        
        NSLog(@"Exception %@",e);
        
    }
    
    NSLog(@"main end");

}


- (void)completeOperation {
    
    [self willChangeValueForKey:@"isFinished"];
    
    [self willChangeValueForKey:@"isExecuting"];
    
    
    
    executing = NO;
    
    finishing = YES;
    
    
    
    [self didChangeValueForKey:@"isExecuting"];
    
    [self didChangeValueForKey:@"isFinished"];
    
}

-(BOOL)isAsynchronous{
    
    return YES;

}


-(BOOL)isExecuting{

    return executing;

}

-(BOOL)isFinished{

    return finishing;

}



-(BOOL)performOperation:(NSOperation *)anOp{


    BOOL  ranIt = NO;
    
    if ([anOp isReady] && ![anOp isCancelled])
    {
        if (![anOp isAsynchronous]) {
            [anOp start];
        }
        else {
            [NSThread detachNewThreadSelector:@selector(start)
                                     toTarget:anOp withObject:nil];
        }
        ranIt = YES;
    }
    else if ([anOp isCancelled])
    {
        // If it was canceled before it was started,
        //  move the operation to the finished state.
        [self willChangeValueForKey:@"isFinished"];
        [self willChangeValueForKey:@"isExecuting"];
        executing = NO;
        finishing  = YES;
        [self didChangeValueForKey:@"isExecuting"];
        [self didChangeValueForKey:@"isFinished"];
        
        // Set ranIt to YES to prevent the operation from
        // being passed to this method again in the future.
        ranIt = YES;
    }
    return ranIt;


}






@end
