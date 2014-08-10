//
//  SVNStatus.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "APRPool.h"
#import <svn_client.h>

@interface SVNStatus : APRPool

-(id)initWithStruct:(const svn_client_status_t *)statusStruct path:(NSString *)path;

@property (nonatomic, readonly) NSString *path;

@property (nonatomic, readonly) NSString *nodeStatusString;
@property (nonatomic, readonly) NSString *textStatusString;
@property (nonatomic, readonly) NSString *propStatusString;

@property (nonatomic, readonly) enum svn_wc_status_kind nodeStatus;
@property (nonatomic, readonly) enum svn_wc_status_kind textStatus;
@property (nonatomic, readonly) enum svn_wc_status_kind propStatus;

@end
