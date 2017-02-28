//
//  WMConcurrentOperation.h
//  NSOperation
//
//  Created by 软件工程系01 on 17/2/28.
//  Copyright © 2017年 软件工程系01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMConcurrentOperation : NSOperation

//执行时调用这个方法
-(BOOL)performOperation:(NSOperation *)anOp;

@end
