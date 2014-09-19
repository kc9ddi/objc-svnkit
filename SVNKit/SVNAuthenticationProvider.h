//
//  SVNAuthenticationProvider.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import "SVNAPRPool.h"

@class SVNAuthenticationProvider, SVNAuthenticationCredentials;

@protocol SVNAuthenticationDataSource <NSObject>

@optional
-(BOOL)SVNAuthenticationProvider:(SVNAuthenticationProvider *)provider simpleCredential:(SVNAuthenticationCredentials *)credentials;

-(BOOL)SVNAuthenticationProvider:(SVNAuthenticationProvider *)provider usernameCredential:(SVNAuthenticationCredentials *)credentials;

@end

@interface SVNAuthenticationProvider : SVNAPRPool

@property (nonatomic, readonly) apr_array_header_t *providers;
@property (nonatomic) id<SVNAuthenticationDataSource> dataSource;

@end
