//
//  SVNNotification.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import "SVNAPRPool.h"
#import <svn_wc.h>

@interface SVNNotification : NSObject

-(id)initWithStruct:(const svn_wc_notify_t *)notifyStruct;

@property (nonatomic, readonly) NSString *path;
@property (nonatomic, readonly) NSString *shortMessage;
@property (nonatomic, readonly) NSString *longMessage;

@end
