//
//  SVNDeleteOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNDeleteOperation.h"
#import "SVNCommitCallback.h"

@implementation SVNDeleteOperation

-(id)init {
    self = [super init];
    if (self) {
        _commitResult = [NSMutableArray new];
    }
    return self;
}

-(void)main {
    if (_pathsToDelete.count > INT_MAX) {
        @throw [NSException exceptionWithName:@"Invalid File Count" reason:@"Too many files are being deleted in a single operation" userInfo:nil];
    }
    
    apr_array_header_t *targets = apr_array_make(self.subpool.pool, (int)_pathsToDelete.count, sizeof(const char *));
    
    for (NSString *path in _pathsToDelete) {
        APR_ARRAY_PUSH(targets, const char *) = [path UTF8String];
    }
    
    svn_error_t *err = svn_client_delete4(targets, _force, _keepLocal, NULL, svnkit_commit_callback, (__bridge void *)(_commitResult), self.ctx, self.subpool.pool);
    
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
    }
}

@end