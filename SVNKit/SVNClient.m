//
//  SVNClient.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNClient.h"
#import "SVNAuthenticationProvider.h"
#import "SVNNotification.h"
#import "SVNOperation.h"
#import <svn_client.h>
#import <svn_fs.h>

static void wc_notify_func2(void *baton, const svn_wc_notify_t *notify, apr_pool_t *pool);

@implementation SVNClient {
    svn_client_ctx_t *_ctx;
    NSOperationQueue *_operationQueue;
}

-(id)init {
    self = [super init];
    if (self) {
        svn_error_t *err;
        
        if ((err = svn_fs_initialize(self.pool))) {
            svn_error_clear(err);
            return nil;
        }
        
        if ((err = svn_config_ensure(NULL, self.pool))) {
            svn_error_clear(err);
            return nil;
        }
        
        if ((err = svn_client_create_context2(&_ctx, NULL, self.pool))) {
            svn_error_clear(err);
            return nil;
        }
        
        if ((err = svn_config_get_config(&(_ctx->config), NULL, self.pool))) {
            svn_error_clear(err);
            return nil;
        }
        
        _ctx->notify_func2 = wc_notify_func2;
        _ctx->notify_baton2 = (__bridge void *)(self);
        
        SVNAuthenticationProvider *authProv = [SVNAuthenticationProvider new];
        svn_auth_open(&_ctx->auth_baton, authProv.providers, self.pool);
        
        _operationQueue = [NSOperationQueue new];
        _operationQueue.name = @"svn operations";
    }
    return self;
}

-(void)performOperation:(SVNOperation *)operation {
    [_operationQueue addOperation:operation];
}

@end

static void wc_notify_func2(void *baton, const svn_wc_notify_t *notify, apr_pool_t *pool) {
    SVNClient *client = (__bridge SVNClient *)(baton);
    if ([client.delegate respondsToSelector:@selector(SVNClient:receivedNotification:)]) {
        SVNNotification *notification = [[SVNNotification alloc] initWithStruct:notify];
        [client.delegate SVNClient:client receivedNotification:notification];
    }
}