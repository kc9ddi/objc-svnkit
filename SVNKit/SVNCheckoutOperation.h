//
//  SVNCheckoutOperation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNOperation.h"
#import <svn_types.h>

@class SVNRevision;

@interface SVNCheckoutOperation : SVNOperation

@property (nonatomic) NSURL *remoteURL;
@property (nonatomic) NSString *localPath;
@property (nonatomic) SVNRevision *pegRevision;
@property (nonatomic) SVNRevision *revision;
@property (nonatomic) svn_depth_t depth;
@property (nonatomic) BOOL ignoreExternals;
@property (nonatomic) BOOL allowUnversionedObstructions;

@end
