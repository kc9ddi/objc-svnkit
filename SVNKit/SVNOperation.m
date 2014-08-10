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

-(void)_handleAndFreeError:(svn_error_t *)err {
    SVNError *error = [[SVNError alloc] initWithStruct:err];
    if (_errorHandler) {
        _errorHandler(error);
    }
    svn_error_clear(err);
}

-(APRPool *)subpool {
    return [_pool createSubpool];
}

@end
