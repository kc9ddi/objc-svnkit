//
//  SVNAuthenticationProvider.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "APRPool.h"

@class SVNAuthenticationProvider, SVNAuthenticationCredentials;

@protocol SVNAuthenticationDataSource <NSObject>

@optional
-(BOOL)SVNAuthenticationProvider:(SVNAuthenticationProvider *)provider simpleCredential:(SVNAuthenticationCredentials *)credentials;

-(BOOL)SVNAuthenticationProvider:(SVNAuthenticationProvider *)provider usernameCredential:(SVNAuthenticationCredentials *)credentials;

@end

@interface SVNAuthenticationProvider : APRPool

@property (nonatomic, readonly) apr_array_header_t *providers;
@property (nonatomic) id<SVNAuthenticationDataSource> dataSource;

@end
