//
//  HeaderSegmentControl.h
//  仿Monkey
//
//  Created by 林林尤达 on 17/2/4.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderSegmentControl : UIView
@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UIButton *button2;
@property (nonatomic,strong) UIButton *button3;
@property (nonatomic,strong) UIButton *button4;
@property (nonatomic,copy) void (^ButtonActionBlock)(int buttonTag);
@property (nonatomic,assign) int buttonCount;
- (void)swipeAction:(NSInteger)tag;
@end
