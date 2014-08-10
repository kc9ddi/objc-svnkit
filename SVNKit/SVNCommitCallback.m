//
//  SVNCommitCallback.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNCommitCallback.h"
#import "SVNCommitInformation.h"

svn_error_t * svnkit_commit_callback(const svn_commit_info_t *commit_info, void *baton, apr_pool_t *pool) {
    NSMutableArray *list = (__bridge NSMutableArray *)(baton);
    SVNCommitInformation *commitInfo = [[SVNCommitInformation alloc] initWithStruct:commit_info];
    [list addObject:commitInfo];
    return SVN_NO_ERROR;
}
