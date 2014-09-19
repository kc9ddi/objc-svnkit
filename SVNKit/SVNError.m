//
//  SVNError.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import "SVNError.h"

@implementation SVNError {
    svn_error_t *_errStruct;
}

-(void)dealloc {
    svn_error_clear(_errStruct);
}

-(id)initWithStruct:(svn_error_t *)errStruct {
    self = [super initWithDomain:@"us.kc9ddi.svnkit" code:errStruct->apr_err userInfo:nil];
    if (self) {
        _errStruct = svn_error_dup(errStruct);
    }
    return self;
}

-(NSString *)localizedDescription {
    SVNError *childError;
    if (_errStruct->child) {
        childError = [[SVNError alloc] initWithStruct:_errStruct->child];
    }
    
    char buf[1024];
    NSString *msg = [NSString stringWithUTF8String:svn_err_best_message(_errStruct, buf, sizeof(buf)/sizeof(buf[0]))];
    if (childError.localizedDescription.length) {
        msg = [msg stringByAppendingFormat:@"\n%@", childError.localizedDescription];
    }
    
    return msg;
}

-(NSString *)file {
    if (_errStruct && _errStruct->file) {
        return [NSString stringWithUTF8String:_errStruct->file];
    }
    return nil;
}

-(NSInteger)line {
    if (_errStruct) {
        return _errStruct->line;
    }
    return 0;
}

@end
