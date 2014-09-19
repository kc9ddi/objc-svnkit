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
    
    apr_file_t *outfile, *errfile;
    apr_int32_t fileAccess = APR_FOPEN_READ | APR_FOPEN_WRITE | APR_FOPEN_CREATE | APR_FOPEN_TRUNCATE;
    apr_status_t stat = apr_file_open(&outfile, "/tmp/macsvnDiff.txt", fileAccess, APR_FPROT_OS_DEFAULT, self.pool.pool);
    if (stat != APR_SUCCESS) {
        goto CLEANUP;
    }
    stat = apr_file_open(&errfile, "/tmp/macsvnDiffErr.txt", fileAccess, APR_FPROT_OS_DEFAULT, self.pool.pool);
    if (stat != APR_SUCCESS) {
        goto CLEANUP;
    }
    
    svn_error_t *err = svn_client_diff5(NULL, [_path1 UTF8String], &rev1, [_path2 UTF8String], &rev2, NULL, svn_depth_empty, FALSE, FALSE, FALSE, FALSE, FALSE, APR_LOCALE_CHARSET, outfile, errfile, FALSE, self.ctx, self.pool.pool);
    
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
        goto CLEANUP;
    }
    
CLEANUP:
    if (outfile) {
        apr_file_close(outfile);
    }
    if (errfile) {
        apr_file_close(errfile);
    }
}

@end
