//
//  SVNListPropertiesOperation.m
//  SVNKit
//
//  Created by Patrick McDonnell on 9/10/14.
//

#import "SVNListPropertiesOperation.h"

static svn_error_t *svnkit_proplist_receiver(void *baton, const char *path, apr_hash_t *prop_hash, apr_pool_t *pool);

@implementation SVNListPropertiesOperation

-(id)init {
    self = [super init];
    if (self) {
        _listPropertiesResult = [NSMutableDictionary new];
    }
    return self;
}

-(void)main {
    svn_opt_revision_t peg_rev = _pegRevision.structValue;
    svn_opt_revision_t rev = _revision.structValue;
    
    svn_error_t *err = svn_client_proplist3([_target UTF8String], &peg_rev, &rev, _depth, NULL, svnkit_proplist_receiver, (__bridge void *)(_listPropertiesResult), self.ctx, self.pool.pool);
    
    if (err != SVN_NO_ERROR) {
        [self _handleAndFreeError:err];
    }
}

@end

static svn_error_t *svnkit_proplist_receiver(void *baton, const char *path, apr_hash_t *prop_hash, apr_pool_t *pool) {
    if (!prop_hash) {
        return SVN_NO_ERROR;
    }
    
    NSMutableDictionary *result = (__bridge NSMutableDictionary *)(baton);
    NSMutableDictionary *props = [NSMutableDictionary new];
    
    for (apr_hash_index_t *index = apr_hash_first(pool, prop_hash); index; index = apr_hash_next(index)) {
        const void *key;
        void *val;
        apr_hash_this(index, &key, NULL, &val);
        
        NSString *propName = [NSString stringWithUTF8String:(const char *)key];
        NSString *propVal = [NSString stringWithUTF8String:((svn_string_t *)val)->data];
        
        [props setObject:propVal forKey:propName];
    }
    
    [result setObject:props forKey:[NSString stringWithUTF8String:path]];
    return SVN_NO_ERROR;
}
