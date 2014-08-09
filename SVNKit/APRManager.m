//
//  APRManager.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "APRManager.h"
#import <apr_general.h>
#import <svn_cmdline.h>

@implementation APRManager

+(APRManager *)sharedManager {
    static APRManager *sharedAPR;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAPR = [self new];
        apr_status_t aprErr = svn_cmdline_init("SVNKit", NULL);
        
        if (aprErr) {
            sharedAPR = nil;
        }
        
        if (atexit(apr_terminate) < 0) {
            sharedAPR = nil;
        }
    });
    
    return sharedAPR;
}

@end
