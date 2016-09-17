//
// Created by Yao Guai on 16/9/17.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNErrorCode.h"

@implementation MNErrorCode

+ (BOOL) isSuccess:(NSInteger) code
{
    return code == SUCCESS;
}

+ (NSInteger) getNetworkErrorCode
{
    return FAIL_NETWORK;
}

+ (NSString *)getMessage:(NSInteger)code {
    switch (code) {
        case FAIL_NETWORK:
            return @"network error";
        case FAIL_SERVER_RESPONSE:
            return @"server response parse failed";
        case SUCCESS:
            return @"success";
        case FAIL_INTERNAL_NO_RESPONSE:
            return @"server not available currently";
        case FAIL_INTERNAL_NO_CODE:
            return @"server not available currently";
        case FAIL_INTERNAL_EXCEPTION:
            return @"server not available currently";
        case FAIL_INTERNAL_MULTI_SEND:
            return @"server not available currently";
        case FAIL_INTERNAL_MULTI_RESPONSE:
            return @"server not available currently";
        case FAIL_ACTION_NOT_REACHABLE:
            return @"server not available currently";
        case FAIL_REQUEST_METHOD:
            return @"server not available currently";
        case FAIL_PARAMETER_MISSING:
            return @"server not available currently";
        case FAIL_PARAMETER_TYPE:
            return @"server not available currently";
        case FAIL_OBJECT_NO_THIS_PROPERTY:
            return @"server not available currently";
        case FAIL_USER_UID_OR_NAME_NOT_EXISTS:
            return @"server not available currently";
        case FAIL_EMPTY_ACCOUNT:
            return @"account required";
        case FAIL_EMPTY_PASSWORD:
            return @"password required";
        case FAIL_WRONG_ACCOUNT_OR_PASSWORD:
            return @"password or account lost";
        case FAIL_LOGIN_TOO_FREQUENTLY:
            return @"login too frequently";
        case FAIL_USER_NAME_ALREADY_EXISTS:
            return @"account already exists";
        case FAIL_DATABASE_ERROR:
            return @"server not available currently";
        case FAIL_USER_NOT_EXISTS:
            return @"user not exists";
        case FAIL_PASSWORD_LENGTH:
            return @"password too short";
        case FAIL_INVALID_PASSWORD:
            return @"password invalid";
        case FAIL_INVALID_IP:
            return @"your ip is invalid";
        case FAIL_USER_CREATE_TOO_FREQUENTLY:
            return @"register too frequently";
        case FAIL_USER_TOKEN_EXPIRE:
            return @"token expire";
        case FAIL_UPLOAD_EMPTY_FILE:
            return @"upload file is empty";
        case FAIL_UPLOAD_FILE_TYPE:
            return @"upload file type error";
        case FAIL_UPLOAD_FILE_SIZE:
            return @"upload file size error";
        case FAIL_LOGIN_FAILED:
            return @"login failed";
        case FAIL_ROSTER_STATUS:
            return @"roster status error";
        case FAIL_GROUP_ROSTER_NOT_EXISTS:
            return @"roster group not exists";
        case FAIL_ROSTER_NOT_EXISTS:
            return @"roster not exists";
        case FAIL_MOVE_GROUP:
            return @"move group failed";
        case FAIL_ROSTER_BLACK:
            return @"you in black list";
        case FAIL_ROSTER_UNSUBSCRIBE:
            return @"unsubscribe failed";
        case FAIL_MESSAGE_EMPTY:
            return @"message is empty";
        case FAIL_OBJECT_NOT_FOUND:
            return @"object not found";
        case FAIL_MESSAGE_NOT_EXISTS:
            return @"message not exists";
        case FAIL_GROUP_NAME_EMPTY:
            return @"group name is empty";
        case FAIL_GROUP_TYPE:
            return @"group type error";
        case FAIL_GROUP_NOT_EXISTS:
            return @"group not exists";
        case FAIL_GROUP_USER_PERMISSION:
            return @"permission deny";
        case FAIL_GROUP_USER_STATUS:
            return @"status wrong";
        case FAIL_GROUP_USER_ALREADY_REQUEST:
            return @"already request";
        case FAIL_GROUP_USER_ALREADY_MEMBER:
            return @"already a member";
        case FAIL_GROUP_USER_ALREADY_REFUSED:
            return @"you are be refused";
        case FAIL_GROUP_USER_NOT_EXISTS:
            return @"user not exists";
        case FAIL_PERMISSION_DENY:
            return @"permission deny";
    }
    return @"server not available currently";
}

@end