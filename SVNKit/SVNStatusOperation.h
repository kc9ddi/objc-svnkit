//
//  SVNStatusOperation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNOperation.h"

@class SVNRevision;

@interface SVNStatusOperation : SVNOperation

@property (nonatomic) NSString *path;
@property (nonatomic) SVNRevision *revision;
@property (nonatomic) svn_depth_t depth;
@property (nonatomic) BOOL getAll;
@property (nonatomic) BOOL update;
@property (nonatomic) BOOL noIgnore;
@property (nonatomic) BOOL ignoreExternals;
@property (nonatomic) BOOL depthAsSticky;

@property (nonatomic, readonly) NSArray *statusResult;

@end
