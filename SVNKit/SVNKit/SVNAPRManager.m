//
//  SVNAPRManager.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import "SVNAPRManager.h"
#include <apr_general.h>
#include <svn_cmdline.h>

@implementation SVNAPRManager

+(SVNAPRManager *)sharedManager {
    static SVNAPRManager *sharedAPR;
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
