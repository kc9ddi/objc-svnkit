//
//  SVNCommitInformation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "APRPool.h"

@class SVNRevision;

@interface SVNCommitInformation : APRPool

@property (nonatomic, readonly) SVNRevision *revision;
@property (nonatomic, readonly) NSString *serverDate;
@property (nonatomic, readonly) NSString *author;
@property (nonatomic, readonly) NSString *postCommitError;
@property (nonatomic, readonly) NSString *repositoryRoot;

-(id)initWithStruct:(const svn_commit_info_t *)commitStruct;

@end
