//
//  SNUser.h
//  webd
//
//  Created by 邓世楠 on 15/8/18.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNUser : NSObject


/**
 *  显示好友名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  用户头像地址
 */
@property (nonatomic, copy) NSString *profile_image_url;

/**
 *  会员类型
 */
@property (assign, nonatomic) int mbtype;

/**
 *  会员等级
 */
@property (assign, nonatomic) int mbrank;

/**
 *  是否是VIP
 */
@property (assign, nonatomic, getter=isVip) BOOL vip;
@end
