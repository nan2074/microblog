//
//  SNUnreadCountResult.m
//  webd
//
//  Created by 普伴 on 15/8/24.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNUnreadCountResult.h"

@implementation SNUnreadCountResult


- (int)messageCount
{
    return self.comment + self.dm + self.mention_cmt + self.mention_status;
}

- (int)totalCount
{
    return self.messageCount + self.status + self.follower;
}
@end
