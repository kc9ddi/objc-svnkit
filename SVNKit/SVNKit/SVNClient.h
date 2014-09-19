//
//  SVNClient.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import <Foundation/Foundation.h>
#import "SVNAPRPool.h"

@class SVNClient, SVNNotification, SVNOperation;
@protocol SVNAuthenticationDataSource;

@protocol SVNClientDelegate <NSObject>

@optional
-(void)SVNClient:(SVNClient *)client receivedNotification:(SVNNotification *)notification;

@end

@interface SVNClient : SVNAPRPool

@property (nonatomic) id<SVNClientDelegate> delegate;
@property (nonatomic) id<SVNAuthenticationDataSource> authenticationDataSource;
@property (nonatomic, readonly) NSOperationQueue *operationQueue;

-(void)performOperation:(SVNOperation *)operation;

@end
