#import "utils.h"

NSString * ABAuthorizationStatusToString(ABAuthorizationStatus status) {
    NSString * strRes = @"";
    
    switch (status) {
        case kABAuthorizationStatusAuthorized:
            strRes = @"AB status Authorized";
            break;
            
        case kABAuthorizationStatusDenied:
            strRes = @"AB status Denied";
            break;
            
        case kABAuthorizationStatusNotDetermined:
            strRes = @"AB status Not Determied";
            break;
            
        case kABAuthorizationStatusRestricted:
            strRes = @"AB status Restricted";
            break;
            
        default:
            strRes = [NSString stringWithFormat:@"Error : invalid status : %ld", (long)status];
            break;
    }
    
    return strRes;
}

@implementation utils

@end
