//
//  SVNAuthenticationCredentials.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import <Foundation/Foundation.h>

@interface SVNAuthenticationCredentials : NSObject

@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *realm;

@end
