//
//  SVNNotification.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNNotification.h"

@implementation SVNNotification {
    svn_wc_notify_t *_notifyStruct;
}

-(id)initWithStruct:(const svn_wc_notify_t *)notifyStruct {
    self = [super init];
    if (self) {
        _notifyStruct = svn_wc_dup_notify(notifyStruct, self.pool);
    }
    return self;
}

-(NSString *)path {
    return [NSString stringWithUTF8String:_notifyStruct->path];
}

@end
