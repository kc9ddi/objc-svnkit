//
//  SVNRevertOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNRevertOperation.h"

@implementation SVNRevertOperation

-(void)main {
    if (_pathsToRevert.count > INT_MAX) {
        @throw [NSException exceptionWithName:@"Invalid File Count" reason:@"Too many files are being reverted in a single operation" userInfo:nil];
    }
    
    apr_array_header_t *targets = apr_array_make(self.subpool.pool, (int)_pathsToRevert.count, sizeof(const char *));
    for (NSString *path in _pathsToRevert) {
        APR_ARRAY_PUSH(targets, const char *) = [path UTF8String];
    }
    
    svn_error_t *err = svn_client_revert2(targets, _depth, NULL, self.ctx, self.subpool.pool);
    
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
    }
}

@end
