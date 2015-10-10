//
//  SNComposeToolbar.h
//  webd
//
//  Created by 普伴 on 15/8/20.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    SNComposeToolbarButtonTypeCamera,
    SNComposeToolbarButtonTypePicture,
    SNComposeToolbarButtonTypeMention,
    SNComposeToolbarButtonTypeTrend,
    SNComposeToolbarButtonTypeEmotion
    
}SNComposeToolbarButtonType;

@class SNComposeToolbar;

@protocol SNComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(SNComposeToolbar *)toolbar didClickedButton:(SNComposeToolbarButtonType)buttonType;

@end
@interface SNComposeToolbar : UIView

@property (weak, nonatomic) id<SNComposeToolbarDelegate> delegate;

@property (assign, nonatomic) BOOL showEmotionButton;

@end
