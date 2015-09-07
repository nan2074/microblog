//
//  SNStatusCell.m
//  webd
//
//  Created by 普伴 on 15/8/25.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNStatusCell.h"
#import "SNStatusDetailView.h"
#import "SNStatusToolbar.h"
#import "SNStatusFrame.h"

@interface SNStatusCell ()

@property (weak, nonatomic) SNStatusDetailView *detailView;
@property (weak, nonatomic) SNStatusToolbar *toolbar;
@end



@implementation SNStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    SNStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[SNStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // 1.添加微博具体内容
        SNStatusDetailView *detailView = [[SNStatusDetailView alloc] init];
        [self.contentView addSubview:detailView];
        self.detailView = detailView;
        
        // 2.添加工具条
        SNStatusToolbar *toolbar = [[SNStatusToolbar alloc] init];
        [self.contentView addSubview:toolbar];
        self.toolbar = toolbar;
        
        // 3.cell的设置
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setStatusFrame:(SNStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.微博具体内容的frame数据
    self.detailView.detailFrame = _statusFrame.detailFrame;
    
    // 2.底部工具条的frame
    self.toolbar.frame = _statusFrame.toolbarFrame;
    self.toolbar.status = statusFrame.status;
}

@end
