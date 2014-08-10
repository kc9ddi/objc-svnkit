//
//  SVNDeleteOperation.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/10/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import "SVNOperation.h"

@interface SVNDeleteOperation : SVNOperation

@property (nonatomic) NSArray *pathsToDelete;
@property (nonatomic) BOOL force;
@property (nonatomic) BOOL keepLocal;

@property (nonatomic, readonly) NSArray *commitResult;

@end
