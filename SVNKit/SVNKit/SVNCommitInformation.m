//
//  SVNCommitInformation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//

#import "SVNCommitInformation.h"
#import "SVNRevision.h"

@implementation SVNCommitInformation {
    svn_commit_info_t *_commitStruct;
}

-(id)initWithStruct:(const svn_commit_info_t *)commitStruct {
    self = [super init];
    if (self) {
        _commitStruct = svn_commit_info_dup(commitStruct, self.pool);
    }
    return self;
}

-(SVNRevision *)revision {
    if (_commitStruct && _commitStruct->revision) {
        SVNRevision *revision = [SVNRevision new];
        revision.number = _commitStruct->revision;
        revision.kind = svn_opt_revision_committed;
        return revision;
    }
    return nil;
}

-(NSString *)serverDate {
    if (_commitStruct && _commitStruct->date) {
        return [NSString stringWithUTF8String:_commitStruct->date];
    }
    return nil;
}

-(NSString *)author {
    if (_commitStruct && _commitStruct->author) {
        return [NSString stringWithUTF8String:_commitStruct->author];
    }
    return nil;
}

-(NSString *)postCommitError {
    if (_commitStruct && _commitStruct->post_commit_err) {
        return [NSString stringWithUTF8String:_commitStruct->post_commit_err];
    }
    return nil;
}

-(NSString *)repositoryRoot {
    if (_commitStruct && _commitStruct->repos_root) {
        return [NSString stringWithUTF8String:_commitStruct->repos_root];
    }
    return nil;
}

@end
