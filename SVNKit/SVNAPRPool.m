//
//  SVNAPRPool.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNAPRPool.h"
#import "SVNAPRManager.h"

@implementation SVNAPRPool {
    apr_allocator_t *_allocator;
}

-(void)dealloc {
    svn_pool_destroy(_pool);
    apr_allocator_destroy(_allocator);
}

-(id)init {
    self = [super init];
    if (self) {
        [SVNAPRManager sharedManager];
        
        apr_allocator_create(&_allocator);
        apr_allocator_max_free_set(_allocator, 20);
        
        _pool = svn_pool_create_ex(NULL, _allocator);
    }
    return self;
}

@end
