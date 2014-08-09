//
//  SVNOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNOperation.h"
#import "SVNError.h"

@implementation SVNOperation

-(dispatch_queue_t)taskQ {
    if (!_taskQ) {
        _taskQ = dispatch_queue_create("us.kc9ddi.svnkit.svnTaskQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _taskQ;
}

-(void)_handleAndFreeError:(svn_error_t *)err {
    SVNError *error = [[SVNError alloc] initWithStruct:err];
    dispatch_sync(dispatch_get_main_queue(), ^{
        if (_errorHandler) {
            _errorHandler(error);
        }
    });
    svn_error_clear(err);
}

-(BOOL)isConcurrent {
    return YES;
}

@end
