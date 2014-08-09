//
//  SVNClient.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APRPool.h"

@class SVNClient, SVNNotification;

@protocol SVNClientDelegate <NSObject>

@optional
-(void)SVNClient:(SVNClient *)client receivedNotification:(SVNNotification *)notification;

@end

@interface SVNClient : APRPool

@property (nonatomic) id<SVNClientDelegate> delegate;

@end
