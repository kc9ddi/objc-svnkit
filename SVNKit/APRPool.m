//
//  APRPool.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "APRPool.h"
#import "APRManager.h"

@implementation APRPool {
    APRPool *_parentPool;
}

-(void)dealloc {
    svn_pool_clear(_pool);
}

-(id)init {
    self = [super init];
    if (self) {
        [APRManager sharedManager];
        _pool = svn_pool_create_ex(NULL, NULL);
    }
    return self;
}

-(id)initWithPool:(APRPool *)pool {
    self = [super init];
    if (self) {
        [APRManager sharedManager];
        _parentPool = pool;
        _pool = svn_pool_create_ex(pool.pool, NULL);
    }
    return self;
}

-(APRPool *)createSubpool {
    return [[APRPool alloc] initWithPool:self];
}

@end
