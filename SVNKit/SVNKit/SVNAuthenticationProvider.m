//
//  SVNAuthenticationProvider.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import "SVNAuthenticationProvider.h"
#import "SVNAuthenticationCredentials.h"
#import <svn_auth.h>

static svn_error_t * ssl_trust_prompt_func(svn_auth_cred_ssl_server_trust_t **cred_p, void *baton, const char *realm, apr_uint32_t failures, const svn_auth_ssl_server_cert_info_t *cert_info, svn_boolean_t may_save, apr_pool_t *pool);

static svn_error_t * simple_prompt_func(svn_auth_cred_simple_t **cred, void *baton, const char *realm, const char *username, svn_boolean_t may_save, apr_pool_t *pool);

static svn_error_t * username_prompt_func(svn_auth_cred_username_t **cred, void *baton, const char *realm, svn_boolean_t may_save, apr_pool_t *pool);

@implementation SVNAuthenticationProvider

-(id)init {
    self = [super init];
    if (self) {
        _providers = apr_array_make(self.pool, 4, sizeof(svn_auth_provider_object_t *));
        
        svn_auth_provider_object_t *provider;
        svn_error_t *err;
        
        svn_auth_get_ssl_server_trust_prompt_provider(&provider, ssl_trust_prompt_func, (__bridge void *)(self), self.pool);
        APR_ARRAY_PUSH(_providers, svn_auth_provider_object_t *) = provider;
        
        if ((err = svn_auth_get_platform_specific_provider(&provider, "keychain", "simple", self.pool))) {
            svn_error_clear(err);
            return nil;
        }
        APR_ARRAY_PUSH(_providers, svn_auth_provider_object_t *) = provider;
        
        svn_auth_get_simple_prompt_provider(&provider, simple_prompt_func, (__bridge void *)(self), 2, self.pool);
        APR_ARRAY_PUSH(_providers, svn_auth_provider_object_t *) = provider;
        
        svn_auth_get_username_prompt_provider(&provider, username_prompt_func, (__bridge void *)(self), 2, self.pool);
        APR_ARRAY_PUSH(_providers, svn_auth_provider_object_t *) = provider;
    }
    return self;
}

@end

static svn_error_t * simple_prompt_func(svn_auth_cred_simple_t **cred, void *baton, const char *realm, const char *username, svn_boolean_t may_save, apr_pool_t *pool) {
    SVNAuthenticationProvider *provider = (__bridge SVNAuthenticationProvider *)(baton);
    
    SVNAuthenticationCredentials *creds = [SVNAuthenticationCredentials new];
    
    if (realm) {
        creds.realm = [NSString stringWithUTF8String:realm];
    }
    
    if (username) {
        creds.username = [NSString stringWithUTF8String:username];
    }
    
    if (![provider.dataSource respondsToSelector:@selector(SVNAuthenticationProvider:simpleCredential:)]) {
        return SVN_NO_ERROR;
    }
    
    if ([provider.dataSource SVNAuthenticationProvider:provider simpleCredential:creds]) {
        svn_auth_cred_simple_t *credRet = apr_pcalloc(pool, sizeof(*credRet));
        if (creds.username.length) {
            credRet->username = apr_pstrdup(pool, [creds.username UTF8String]);
        }
        if (creds.password.length) {
            credRet->password = apr_pstrdup(pool, [creds.password UTF8String]);
        }
        *cred = credRet;
    }
    
    return SVN_NO_ERROR;
}

static svn_error_t * username_prompt_func(svn_auth_cred_username_t **cred, void *baton, const char *realm, svn_boolean_t may_save, apr_pool_t *pool) {
    SVNAuthenticationProvider *provider = (__bridge SVNAuthenticationProvider *)(baton);
    
    SVNAuthenticationCredentials *creds = [SVNAuthenticationCredentials new];
    
    if (realm) {
        creds.realm = [NSString stringWithUTF8String:realm];
    }
    
    if (![provider.dataSource respondsToSelector:@selector(SVNAuthenticationProvider:usernameCredential:)]) {
        return SVN_NO_ERROR;
    }
    
    if ([provider.dataSource SVNAuthenticationProvider:provider usernameCredential:creds]) {
        svn_auth_cred_username_t *credRet = apr_pcalloc(pool, sizeof(*credRet));
        if (creds.username.length) {
            credRet->username = apr_pstrdup(pool, [creds.username UTF8String]);
        }
        *cred = credRet;
    }
    
    return SVN_NO_ERROR;
}

static svn_error_t * ssl_trust_prompt_func(svn_auth_cred_ssl_server_trust_t **cred_p, void *baton, const char *realm, apr_uint32_t failures, const svn_auth_ssl_server_cert_info_t *cert_info, svn_boolean_t may_save, apr_pool_t *pool) {
    *cred_p = apr_pcalloc(pool, sizeof(**cred_p));
    (*cred_p)->may_save = false;
    (*cred_p)->accepted_failures = failures;
    return SVN_NO_ERROR;
}