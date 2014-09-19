//
//  SVNInfo.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNAPRPool.h"
#import <svn_client.h>

@interface SVNInfo : SVNAPRPool

-(id)initWithStruct:(const svn_client_info2_t *)infoStruct path:(NSString *)path;

@property (nonatomic, readonly) NSString *path;
@property (nonatomic, readonly) NSString *url;
@property (nonatomic, readonly) NSString *decodedUrl;
@property (nonatomic, readonly) svn_node_kind_t nodeKind;

@end
