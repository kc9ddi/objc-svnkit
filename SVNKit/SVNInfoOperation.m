//
//  SVNInfoOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNInfoOperation.h"
#import "SVNRevision.h"
#import "SVNInfo.h"

static svn_error_t * info_func(void *baton, const char *abspath_or_url, const svn_client_info2_t *info, apr_pool_t *scratch_pool);

@implementation SVNInfoOperation

-(id)init {
    self = [super init];
    if (self) {
        _infoResult = [NSMutableArray new];
    }
    return self;
}

-(void)main {
    svn_opt_revision_t peg_rev = _pegRevision.structValue;
    svn_opt_revision_t rev = _revision.structValue;
    
    svn_error_t *err = svn_client_info3([_pathOrURL UTF8String], &peg_rev, &rev, _depth, _fetchExcluded, _fetchActualOnly, NULL, info_func, (__bridge void *)(_infoResult), self.ctx, self.subpool.pool);
    
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
    }
}

@end

static svn_error_t * info_func(void *baton, const char *abspath_or_url, const svn_client_info2_t *info, apr_pool_t *scratch_pool) {
    NSMutableArray *infoList = (__bridge NSMutableArray *)baton;
    SVNInfo *svnInfo = [[SVNInfo alloc] initWithStruct:info path:[NSString stringWithUTF8String:abspath_or_url]];
    [infoList addObject:svnInfo];
    return SVN_NO_ERROR;
}
