//
//  SVNRevertOperation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//

#import "SVNOperation.h"

@interface SVNRevertOperation : SVNOperation

@property (nonatomic) NSArray *pathsToRevert;
@property (nonatomic) svn_depth_t depth;

@end
