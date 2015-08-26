//
//  SNAccessTokenParam.h
//  webd
//
//  Created by 普伴 on 15/8/21.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNAccessTokenParam : NSObject



// 申请应用时分批的AppKey
@property (copy, nonatomic) NSString *client_id;

// 申请应用时分配的AppSecret
@property (copy, nonatomic) NSString *client_secret;

// 请求的类型，填写authorization_code
@property (copy, nonatomic) NSString *grant_type;

// 调用authorize获得code值
@property (copy, nonatomic) NSString *code;

// 回调地址，需要与注册应用里的回调地址一致
@property (copy, nonatomic) NSString *redirect_uri;




@end
