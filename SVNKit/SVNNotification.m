//
//  SVNNotification.m
//  SVNKit
//
//  Created by Patrick McDonnell on 8/9/14.
//

#import "SVNNotification.h"

@implementation SVNNotification {
    svn_wc_notify_action_t _action;
}

@synthesize path=_path;

-(id)initWithStruct:(const svn_wc_notify_t *)notifyStruct {
    self = [super init];
    if (self) {
        _path = [NSString stringWithUTF8String:notifyStruct->path];
        _action = notifyStruct->action;
    }
    return self;
}

-(NSString *)basename {
    NSString *url = _path;
    if (url.length < 1) {
        return @"";
    }
    
    NSArray *filenames = [url componentsSeparatedByString:@"/"];
    if (filenames.count < 1) {
        return @"";
    }
    
    return filenames.lastObject;
}

-(NSString *)shortMessage {
    NSString *basename = self.basename;
    if (basename.length < 1) {
        return @"";
    }
    
    NSString *notifyMsg = @"";
    
    switch (_action) {
        case svn_wc_notify_update_delete:
        case svn_wc_notify_commit_deleted:
            notifyMsg = [NSString stringWithFormat:@"D : %@", basename];
            break;
        case svn_wc_notify_update_add:
        case svn_wc_notify_commit_added:
            notifyMsg = [NSString stringWithFormat:@"A : %@", basename];
            break;
        case svn_wc_notify_update_update:
            notifyMsg = [NSString stringWithFormat:@"U : %@", basename];
            break;
        case svn_wc_notify_update_completed:
            notifyMsg = [NSString stringWithFormat:@"UC: %@", basename];
            break;
        case svn_wc_notify_commit_modified:
            notifyMsg = [NSString stringWithFormat:@"M : %@", basename];
            break;
        case svn_wc_notify_commit_replaced:
            notifyMsg = [NSString stringWithFormat:@"R : %@", basename];
            break;
        default:
            NSLog(@"Unknown SVN operation (%i) on: %@", _action, basename);
            break;
    }
    return notifyMsg;
}

-(NSString *)longMessage {
    NSString *path = _path;
    if (path.length < 1) {
        return @"";
    }
    
    NSString *notifyMsg = @"";
    
    switch (_action) {
        case svn_wc_notify_update_delete:
        case svn_wc_notify_commit_deleted:
            notifyMsg = [NSString stringWithFormat:@"Deleted: %@", path];
            break;
        case svn_wc_notify_update_add:
        case svn_wc_notify_commit_added:
            notifyMsg = [NSString stringWithFormat:@"Added: %@", path];
            break;
        case svn_wc_notify_update_update:
            notifyMsg = [NSString stringWithFormat:@"Updated: %@", path];
            break;
        case svn_wc_notify_update_completed:
            notifyMsg = [NSString stringWithFormat:@"Update completed: %@", path];
            break;
        case svn_wc_notify_commit_modified:
            notifyMsg = [NSString stringWithFormat:@"Modified: %@", path];
            break;
        case svn_wc_notify_commit_replaced:
            notifyMsg = [NSString stringWithFormat:@"Replaced: %@", path];
            break;
        default:
            NSLog(@"Unknown SVN operation (%i) on: %@", _action, path);
            break;
    }
    return notifyMsg;
}

@end
