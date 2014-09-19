//
//  SVNRevision.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNRevision.h"

@implementation SVNRevision

-(svn_opt_revision_t)structValue {
    svn_opt_revision_t revision;
    
    revision.kind = _kind;
    
    if (_number || _date) {
        svn_opt_revision_value_t value;
        if (_number) {
            value.number = _number;
        } else {
            value.date = [_date timeIntervalSince1970];
        }
        revision.value = value;
    }
    
    return revision;
}

+(SVNRevision *)revisionWithRevisionKind:(enum svn_opt_revision_kind)kind {
    SVNRevision *rev = [SVNRevision new];
    rev.kind = kind;
    return rev;
}

@end
