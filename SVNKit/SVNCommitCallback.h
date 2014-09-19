//
//  SVNCommitCallback.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//

#import "SVNOperation.h"

svn_error_t * svnkit_commit_callback(const svn_commit_info_t *commit_info, void *baton, apr_pool_t *pool);
