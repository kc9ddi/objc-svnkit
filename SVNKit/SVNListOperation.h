//
//  SVNListOperation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNOperation.h"

@class SVNRevision;

@interface SVNListOperation : SVNOperation

@property (nonatomic) NSString *pathOrURL;
@property (nonatomic) SVNRevision *pegRevision;
@property (nonatomic) SVNRevision *revision;
@property (nonatomic) svn_depth_t depth;
@property (nonatomic) BOOL includeExternals;

@property (nonatomic, readonly) NSArray *listResult;

@end
