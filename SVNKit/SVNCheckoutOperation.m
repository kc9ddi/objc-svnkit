//
//  SVNCheckoutOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNCheckoutOperation.h"
#import "SVNRevision.h"
#import "SVNError.h"
#import "APRPool.h"

@implementation SVNCheckoutOperation

-(void)start {
    dispatch_async(self.taskQ, ^{
        svn_revnum_t result_rev;
        
        svn_opt_revision_t peg_rev = _pegRevision.structValue;
        svn_opt_revision_t rev = _revision.structValue;
        
        APRPool *subpool = [self.pool createSubpool];
        
        svn_error_t *err = svn_client_checkout3(&result_rev, [[_remoteURL absoluteString] UTF8String], [_localPath UTF8String], &peg_rev, &rev, _depth, _ignoreExternals, _allowUnversionedObstructions, self.ctx, subpool.pool);
        
        if (err != SVN_NO_ERROR) {
            [self _handleAndFreeError:err];
        }
    });
}

@end
