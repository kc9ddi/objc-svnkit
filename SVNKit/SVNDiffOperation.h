//
//  SVNDiffOperation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//

#import "SVNOperation.h"

@class SVNRevision;

@interface SVNDiffOperation : SVNOperation

@property (nonatomic) NSString *diffCommand;
@property (nonatomic) NSString *path1;
@property (nonatomic) SVNRevision *revision1;
@property (nonatomic) NSString *path2;
@property (nonatomic) SVNRevision *revision2;
@property (nonatomic) svn_depth_t depth;

@end
