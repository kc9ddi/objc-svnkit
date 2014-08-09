//
//  SVNError.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <svn_types.h>

@interface SVNError : NSError

-(id)initWithStruct:(svn_error_t *)errStruct;

@property (nonatomic, readonly) NSString *file;
@property (nonatomic, readonly) NSInteger line;

@end
