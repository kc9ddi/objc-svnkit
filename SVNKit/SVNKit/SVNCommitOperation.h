//
//  SVNCommitOperation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import "SVNOperation.h"

@interface SVNCommitOperation : SVNOperation

@property (nonatomic) NSArray *statusesToCommit;
@property (nonatomic) svn_depth_t depth;
@property (nonatomic) BOOL keepLocks;
@property (nonatomic) BOOL keepChangeLists;
@property (nonatomic) BOOL commitAsOperations;
@property (nonatomic) BOOL includeDirectoryExternals;
@property (nonatomic) NSString *commitMessage;

@property (nonatomic, readonly) NSArray *commitResult;

@end
