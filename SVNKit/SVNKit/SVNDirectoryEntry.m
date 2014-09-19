//
//  SVNDirectoryEntry.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import "SVNDirectoryEntry.h"

@implementation SVNDirectoryEntry {
    svn_dirent_t *_direntStruct;
}

-(id)initWithStruct:(const svn_dirent_t *)direntStruct {
    self = [super init];
    if (self) {
        _direntStruct = svn_dirent_dup(direntStruct, self.pool);
    }
    return self;
}

-(NSString *)urlEncodedName {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)_name, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
}

-(svn_node_kind_t)kind {
    if (!_direntStruct) {
        return svn_node_unknown;
    }
    return _direntStruct->kind;
}

-(NSUInteger)size {
    if (!_direntStruct) {
        return 0;
    }
    return _direntStruct->size;
}

-(NSTimeInterval)time {
    if (!_direntStruct) {
        return 0;
    }
    return apr_time_sec(_direntStruct->time);
}


@end
