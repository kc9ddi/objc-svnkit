//
//  SVNRevision.h
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//  Copyright (c) 2014 Epic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <svn_opt.h>

@interface SVNRevision : NSObject

@property (nonatomic) enum svn_opt_revision_kind kind;
@property (nonatomic) NSInteger number;
@property (nonatomic) NSDate *date;

-(svn_opt_revision_t)structValue;

+(SVNRevision *)head;

@end
