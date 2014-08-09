//
//  SVNClient.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNClient.h"
#import <svn_client.h>
#import <svn_fs.h>

static svn_wc_notify_func2_t svnkit_wc_notify_func2;
static svn_client_get_commit_log3_t svnkit_log_msg_func3;

@implementation SVNClient {
    svn_client_ctx_t *_ctx;
}

-(id)init {
    self = [super init];
    if (self) {
        svn_error_t *err = nil;
        
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
        
        _ctx->notify_func2 = svnkit_wc_notify_func2;
        _ctx->notify_baton2 = (__bridge void *)(self);
        
        _ctx->log_msg_func3 = svnkit_log_msg_func3;
        _ctx->log_msg_baton3 = NULL;
    }
    
    return self;
}

@end
