//
//  SVNInfo.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNInfo.h"

@implementation SVNInfo {
    svn_client_info2_t *_infoStruct;
}

-(id)initWithStruct:(const svn_client_info2_t *)infoStruct path:(NSString *)path {
    self = [super init];
    if (self) {
        _infoStruct = svn_client_info2_dup(infoStruct, self.pool);
        _path = path;
    }
    return self;
}

-(NSString *)url {
    if (_infoStruct && _infoStruct->URL) {
        return [NSString stringWithUTF8String:_infoStruct->URL];
    }
    return nil;
}

-(NSString *)decodedUrl {
    return [self.url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(svn_node_kind_t)nodeKind {
    if (_infoStruct) {
        return _infoStruct->kind;
    }
    return svn_node_unknown;
}

@end
