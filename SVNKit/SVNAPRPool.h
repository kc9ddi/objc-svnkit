//
//  SVNAPRPool.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import <Foundation/Foundation.h>
#include <svn_types.h>
#include <svn_pools.h>

@interface SVNAPRPool : NSObject

@property (nonatomic) apr_pool_t *pool;

@end
