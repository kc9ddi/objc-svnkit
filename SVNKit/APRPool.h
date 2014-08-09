//
//  APRPool.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <svn_pools.h>

@interface APRPool : NSObject

@property (nonatomic) apr_pool_t *pool;

-(id)initWithPool:(APRPool *)pool;

-(APRPool *)createSubpool;

@end
