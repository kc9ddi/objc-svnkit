//
//  SVNDirectoryEntry.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "APRPool.h"

@interface SVNDirectoryEntry : APRPool

@property (nonatomic) NSString *name;
@property (nonatomic, readonly) NSString *urlEncodedName;
@property (nonatomic, readonly) svn_node_kind_t kind;
@property (nonatomic, readonly) NSUInteger size;
@property (nonatomic, readonly) NSTimeInterval time;

-(id)initWithStruct:(const svn_dirent_t *)direntStruct;

@end
