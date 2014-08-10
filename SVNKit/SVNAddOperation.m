//
//  SVNAddOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNAddOperation.h"

@implementation SVNAddOperation

-(void)main {
    svn_error_t *err = svn_client_add5([_pathToAdd UTF8String], _depth, _force, _noIgnore, _noAutoProperties, _addParents, self.ctx, self.subpool.pool);
    
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
    }
}

@end
