//
//  SVNOperation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import <Foundation/Foundation.h>
#import "SVNAPRPool.h"
#import <svn_client.h>

@class APRPool, SVNError;

typedef void (^SVNErrorHandler)(SVNError *error);

@interface SVNOperation : NSOperation

@property (nonatomic) svn_client_ctx_t *ctx;
@property (nonatomic, readonly) SVNAPRPool *pool;
@property (nonatomic, copy) SVNErrorHandler errorHandler;

-(void)_handleAndFreeError:(svn_error_t *)err;
@end
