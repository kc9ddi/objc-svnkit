//
//  SVNListPropertiesOperation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 9/10/14.
//

#import <SVNKit/SVNKit.h>

@interface SVNListPropertiesOperation : SVNOperation

@property (nonatomic) NSString *target;
@property (nonatomic) SVNRevision *revision;
@property (nonatomic) SVNRevision *pegRevision;
@property (nonatomic) svn_depth_t depth;

@property (nonatomic) NSDictionary *listPropertiesResult;

@end
