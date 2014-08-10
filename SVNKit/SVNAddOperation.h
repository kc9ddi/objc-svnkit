//
//  SVNAddOperation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNOperation.h"

@interface SVNAddOperation : SVNOperation

@property (nonatomic) NSString *pathToAdd;
@property (nonatomic) svn_depth_t depth;
@property (nonatomic) BOOL force;
@property (nonatomic) BOOL noIgnore;
@property (nonatomic) BOOL noAutoProperties;
@property (nonatomic) BOOL addParents;

@end