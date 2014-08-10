//
//  SVNStatus.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNStatus.h"

@implementation SVNStatus {
    svn_client_status_t *_statusStruct;
}

-(id)initWithStruct:(const svn_client_status_t *)statusStruct path:(NSString *)path {
    self = [super init];
    if (self) {
        _statusStruct = svn_client_status_dup(statusStruct, self.pool);
        _path = path;
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return [super isEqual:object];
    }
    
    SVNStatus *status = object;
    return ([self.path isEqualToString:status.path] &&
            self.nodeStatus == status.nodeStatus &&
            self.propStatus == status.propStatus &&
            self.textStatus == status.textStatus);
}

-(NSUInteger)hash {
    NSUInteger result = 1;
    result = (result << 19) - result + self.nodeStatus;
    result = (result << 19) - result + self.propStatus;
    result = (result << 19) - result + self.textStatus;
    if (_path) {
        result = (result << 19) - result + _path.hash;
    }
    return result;
}

-(enum svn_wc_status_kind)nodeStatus {
    return _statusStruct->node_status;
}

-(enum svn_wc_status_kind)propStatus {
    return _statusStruct->prop_status;
}

-(enum svn_wc_status_kind)textStatus {
    return _statusStruct->text_status;
}

-(NSString *)nodeStatusString {
    return [self _stringForStatus:_statusStruct->node_status];
}

-(NSString *)textStatusString {
    return [self _stringForStatus:_statusStruct->text_status];
}

-(NSString *)propStatusString {
    return [self _stringForStatus:_statusStruct->prop_status];
}

-(NSString *)_stringForStatus:(enum svn_wc_status_kind)status {
    switch (status) {
        case svn_wc_status_added:
            return @"Added";
        case svn_wc_status_incomplete:
            return @"Incomplete";
        case svn_wc_status_missing:
            return @"Missing";
        case svn_wc_status_deleted:
            return @"Deleted";
        case svn_wc_status_replaced:
            return @"Replaced";
        case svn_wc_status_modified:
            return @"Modified";
        case svn_wc_status_conflicted:
            return @"Conflicted";
        case svn_wc_status_ignored:
            return @"Ignored";
        case svn_wc_status_external:
            return @"External";
        default:
            return @"";
    }
}


@end
