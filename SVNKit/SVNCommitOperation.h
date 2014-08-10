//
//  SVNCommitOperation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNOperation.h"

@interface SVNCommitOperation : SVNOperation

@property (nonatomic) NSSet *statusesToCommit;
@property (nonatomic) svn_depth_t depth;
@property (nonatomic) BOOL keepLocks;
@property (nonatomic) BOOL keepChangeLists;
@property (nonatomic) BOOL commitAsOperations;
@property (nonatomic) BOOL includeExternals;
@property (nonatomic) BOOL includeDirectoryExternals;
@property (nonatomic) NSString *commitMessage;

@property (nonatomic, readonly) NSArray *commitResult;

@end
