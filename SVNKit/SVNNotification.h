//
//  SVNNotification.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "APRPool.h"
#import <svn_wc.h>

@interface SVNNotification : APRPool

-(id)initWithStruct:(const svn_wc_notify_t *)notifyStruct;

@property (nonatomic, readonly) NSString *path;

@end
