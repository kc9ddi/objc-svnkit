//
//  SVNStatusOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import "SVNStatusOperation.h"
#import "SVNRevision.h"
#import "SVNStatus.h"
#import "SVNAPRPool.h"

static svn_error_t * status_func(void *baton, char *path, const svn_client_status_t *status, apr_pool_t *scratch_pool);

@implementation SVNStatusOperation

-(id)init {
    self = [super init];
    if (self) {
        _statusResult = [NSMutableArray new];
    }
    return self;
}

-(void)main {
    svn_revnum_t result_rev;
    
    svn_opt_revision_t rev = _revision.structValue;
    
    svn_error_t *err = svn_client_status5(&result_rev, self.ctx, [_path UTF8String], &rev, _depth, _getAll, _update, _noIgnore, _ignoreExternals, _depthAsSticky, NULL, (svn_client_status_func_t)status_func, (__bridge void *)(_statusResult), self.pool.pool);
    
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
    }
}

@end

static svn_error_t * status_func(void *baton, char *path, const svn_client_status_t *status, apr_pool_t *scratch_pool) {
    NSMutableArray *statusList = (__bridge NSMutableArray *)(baton);
    SVNStatus *statusInfo = [[SVNStatus alloc] initWithStruct:status path:[NSString stringWithUTF8String:path]];
    [statusList addObject:statusInfo];
    return SVN_NO_ERROR;
}