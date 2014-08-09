//
//  SVNOperation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <svn_client.h>

@class APRPool;

@interface SVNOperation : NSOperation

@property (nonatomic) svn_client_ctx_t *ctx;
@property (nonatomic) APRPool *pool;

@property (nonatomic) dispatch_queue_t taskQ;

@end
