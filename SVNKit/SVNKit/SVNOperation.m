//
//  SVNOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import "SVNOperation.h"
#import "SVNError.h"

@implementation SVNOperation

@synthesize pool=_pool;

-(SVNAPRPool *)pool {
    if (!_pool) {
        _pool = [[SVNAPRPool alloc] init];
    }
    return _pool;
}

-(void)_handleAndFreeError:(svn_error_t *)err {
    if (_errorHandler) {
        svn_error_t *dup_err = svn_error_dup(err);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _errorHandler([[SVNError alloc] initWithStruct:dup_err]);
            svn_error_clear(dup_err);
        }];
    }
    svn_error_clear(err);
}

@end
