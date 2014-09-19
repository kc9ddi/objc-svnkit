//
//  SVNCommitInformation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//

#import "SVNAPRPool.h"

@class SVNRevision;

@interface SVNCommitInformation : SVNAPRPool

@property (nonatomic, readonly) SVNRevision *revision;
@property (nonatomic, readonly) NSString *serverDate;
@property (nonatomic, readonly) NSString *author;
@property (nonatomic, readonly) NSString *postCommitError;
@property (nonatomic, readonly) NSString *repositoryRoot;

-(id)initWithStruct:(const svn_commit_info_t *)commitStruct;

@end
