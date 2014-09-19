//
//  SVNListOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import "SVNListOperation.h"
#import "SVNRevision.h"
#import "SVNDirectoryEntry.h"

static svn_error_t *list_func(void *baton, const char *path, const svn_dirent_t *dirent, const svn_lock_t *lock, const char *abs_path, const char *external_parent_url, const char *external_target, apr_pool_t *scratch_pool);

@implementation SVNListOperation

-(id)init {
    self = [super init];
    if (self) {
        _listResult = [NSMutableArray new];
    }
    return self;
}

-(void)main {
    svn_opt_revision_t peg_rev = _pegRevision.structValue;
    svn_opt_revision_t rev = _revision.structValue;
    
    if (self.isCancelled) {
        return;
    }
    
    svn_error_t *err = svn_client_list2([_pathOrURL UTF8String], &peg_rev, &rev, _depth, SVN_DIRENT_ALL, FALSE, (svn_client_list_func_t)list_func, (__bridge void *)_listResult, self.ctx, self.pool.pool);
    
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
    }
}

@end

static svn_error_t *list_func(void *baton, const char *path, const svn_dirent_t *dirent, const svn_lock_t *lock, const char *abs_path, const char *external_parent_url, const char *external_target, apr_pool_t *scratch_pool) {
    NSString *direntName = [NSString stringWithUTF8String:path];
    if (!direntName.length) {
        return SVN_NO_ERROR;
    }
    
    NSMutableArray *list = (__bridge NSMutableArray *)(baton);
    SVNDirectoryEntry *direntInfo = [[SVNDirectoryEntry alloc] initWithStruct:dirent];
    direntInfo.name = direntName;
    direntInfo.absolutePath = [NSString stringWithUTF8String:abs_path];
    [list addObject:direntInfo];
    return SVN_NO_ERROR;
}