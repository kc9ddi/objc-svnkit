//
//  SVNDiffOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNDiffOperation.h"
#import "SVNRevision.h"
#import <apr_xlate.h>

@implementation SVNDiffOperation

-(void)main {
    svn_config_set(apr_hash_get(self.ctx->config, SVN_CONFIG_CATEGORY_CONFIG, APR_HASH_KEY_STRING), SVN_CONFIG_SECTION_HELPERS, SVN_CONFIG_OPTION_DIFF_CMD, [_diffCommand UTF8String]);
    
    svn_opt_revision_t rev1 = _revision1.structValue;
    svn_opt_revision_t rev2 = _revision2.structValue;
    
    svn_stream_t *outStream, *errStream;
    const char *outPath, *errPath;
    
    svn_error_t *err = svn_stream_open_unique(&outStream, &outPath, NULL, svn_io_file_del_on_pool_cleanup, self.subpool.pool, self.subpool.pool);
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
        goto CLEANUP;
    }
    
    err = svn_stream_open_unique(&errStream, &errPath, NULL, svn_io_file_del_on_pool_cleanup, self.subpool.pool, self.subpool.pool);
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
        goto CLEANUP;
    }
    
    err = svn_client_diff6(NULL, [_path1 UTF8String], &rev1, [_path2 UTF8String], &rev2, NULL, _depth, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, APR_LOCALE_CHARSET, outStream, errStream, NULL, self.ctx, self.subpool.pool);
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
        goto CLEANUP;
    }
    
CLEANUP:
    if (outStream) {
        svn_stream_close(outStream);
    }
    if (errStream) {
        svn_stream_close(errStream);
    }
}

@end
