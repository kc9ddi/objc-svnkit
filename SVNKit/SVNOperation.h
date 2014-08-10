//
//  SVNOperation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APRPool.h"
#import <svn_client.h>

@class APRPool, SVNError;

typedef void (^SVNErrorHandler)(SVNError *error);

@interface SVNOperation : NSOperation

@property (nonatomic) svn_client_ctx_t *ctx;
@property (nonatomic) APRPool *pool;
@property (nonatomic, copy) SVNErrorHandler errorHandler;

-(void)_handleAndFreeError:(svn_error_t *)err;
-(APRPool *)subpool;

@end
