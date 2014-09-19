//
//  SVNCommitOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import "SVNCommitOperation.h"
#import "SVNStatus.h"
#import "SVNCommitInformation.h"
#import "SVNCommitCallback.h"

static svn_client_get_commit_log3_t svnkit_log_msg_baton_3(const char **log_msg, const char **tmp_file, const apr_array_header_t *commit_items, void *baton, apr_pool_t *pool);

@implementation SVNCommitOperation

-(id)init {
    self = [super init];
    if (self) {
        _commitResult = [NSMutableArray new];
    }
    return self;
}

-(void)main {
    if (_statusesToCommit.count == 0) {
        return;
    }
    
    if (_statusesToCommit.count > INT_MAX) {
        @throw [NSException exceptionWithName:@"Invalid File Count" reason:@"Too many files are being committed in a single operation" userInfo:nil];
    }
    
    if (self.isCancelled) {
        return;
    }
    
    self.ctx->log_msg_func3 = (svn_client_get_commit_log3_t)svnkit_log_msg_baton_3;
    self.ctx->log_msg_baton3 = (void *)[_commitMessage UTF8String];
    
    if (self.isCancelled) {
        goto CLEANUP;
    }
    
    apr_array_header_t *targets = apr_array_make(self.pool.pool, (int)_statusesToCommit.count, sizeof(const char *));
    for (SVNStatus *status in _statusesToCommit) {
        APR_ARRAY_PUSH(targets, const char *) = [status.path UTF8String];
    }
    
    if (self.isCancelled) {
        goto CLEANUP;
    }
    
    svn_error_t *err = svn_client_commit5(targets, _depth, _keepLocks, _keepChangeLists, _commitAsOperations, NULL, NULL, svnkit_commit_callback, (__bridge void *)(_commitResult), self.ctx, self.pool.pool);
    
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
    }

CLEANUP:
    self.ctx->log_msg_func3 = NULL;
    self.ctx->log_msg_baton3 = NULL;
}

@end

svn_client_get_commit_log3_t svnkit_log_msg_baton_3(const char **log_msg, const char **tmp_file, const apr_array_header_t *commit_items, void *baton, apr_pool_t *pool) {
    *log_msg = (const char *)baton;
    return SVN_NO_ERROR;
}