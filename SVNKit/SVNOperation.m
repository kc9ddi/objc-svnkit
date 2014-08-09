//
//  SVNOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNOperation.h"

@implementation SVNOperation

-(dispatch_queue_t)taskQ {
    if (_taskQ) {
        _taskQ = dispatch_queue_create("us.kc9ddi.svnkit.svnTaskQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _taskQ;
}

-(BOOL)isConcurrent {
    return YES;
}

@end
