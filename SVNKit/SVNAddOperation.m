//
//  SVNAddOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//

#import "SVNAddOperation.h"
#import <svn_version.h>

@implementation SVNAddOperation

-(void)main {

    svn_error_t *err = svn_client_add4([_pathToAdd UTF8String], _depth, _force, _noIgnore, _addParents, self.ctx, self.pool.pool);
    
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
    }
}

@end
