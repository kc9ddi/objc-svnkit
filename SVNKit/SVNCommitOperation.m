//
//  SVNCommitOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNCommitOperation.h"
#import "SVNStatus.h"
#import "SVNCommitInformation.h"

static svn_error_t * commit_callback(const svn_commit_info_t *commit_info, void *baton, apr_pool_t *pool);

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
    
    self.ctx->log_msg_baton3 = (void *)[_commitMessage UTF8String];
    
    apr_array_header_t *targets = apr_array_make(self.pool.pool, (int)_statusesToCommit.count, sizeof(const char *));
    for (SVNStatus *status in _statusesToCommit) {
        APR_ARRAY_PUSH(targets, const char *) = [status.path UTF8String];
    }
    
    svn_error_t *err = svn_client_commit6(targets, _depth, _keepLocks, _keepChangeLists, _commitAsOperations, _includeExternals, _includeDirectoryExternals, NULL, NULL, commit_callback, (__bridge void *)(_commitResult), self.ctx, self.subpool.pool);
    
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
    }
}

@end

static svn_error_t * commit_callback(const svn_commit_info_t *commit_info, void *baton, apr_pool_t *pool) {
    NSMutableArray *list = (__bridge NSMutableArray *)(baton);
    SVNCommitInformation *commitInfo = [[SVNCommitInformation alloc] initWithStruct:commit_info];
    [list addObject:commitInfo];
    return SVN_NO_ERROR;
}