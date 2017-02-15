//
//  HeaderSegmentControl.m
//  仿Monkey
//
//  Created by 林林尤达 on 17/2/4.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "HeaderSegmentControl.h"

@interface HeaderSegmentControl () {
    int currentTag;
    UIColor *black;
    UIColor *ligjt;
    UIFont *normalFont;
    UIFont *lightFont;
}
@end

@implementation HeaderSegmentControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
        float h =35;
        float space =0;
        float width =(ScreenWidth)/4-space;
        float height =h;
        float w= space+width;
        black = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1];
        ligjt = YiBlue;
        
        normalFont = [UIFont systemFontOfSize:12];
        if (ScreenWidth<=320) {
            lightFont = [UIFont systemFontOfSize:12];
        }else{
            lightFont = [UIFont systemFontOfSize:14];
        }
        
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button1];
        _button1.frame = CGRectMake(space, (h-height)/2, width, height);
        [_button1 setTitle:@"北京" forState:UIControlStateNormal];
        _button1.titleLabel.font = normalFont;
        [_button1 setTitleColor:black forState:UIControlStateNormal];
        _button1.tag = 101;
        [_button1 addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button2];
        _button2.frame = CGRectMake(w+space, (h-height)/2, width, height);
        [_button2 setTitle:@"China" forState:UIControlStateNormal];
        _button2.titleLabel.font = normalFont;
        [_button2 setTitleColor:black forState:UIControlStateNormal];
        _button2.tag = 102;
        [_button2 addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button3];
        _button3.frame = CGRectMake(w*2+space, (h-height)/2, width, height);
        [_button3 setTitle:@"World" forState:UIControlStateNormal];
        _button3.titleLabel.font = normalFont;
        [_button3 setTitleColor:black forState:UIControlStateNormal];
        _button3.tag = 103;
        [_button3 addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button4];
        _button4.frame = CGRectMake(w*3+space, (h-20)/2, width-5, 20);
        [_button4 setTitle:@"" forState:UIControlStateNormal];
        _button4.titleLabel.font = [UIFont systemFontOfSize:12];
        [_button4 setTitleColor:black forState:UIControlStateNormal];
        _button4.tag = 104;
        [_button4 addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        [_button4 setBackgroundColor:YiBlue];
        [_button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //   默认情况
        currentTag =101;
        
        [_button1 setTitleColor:ligjt forState:UIControlStateNormal];
        _button1.titleLabel.font = lightFont;
    }
    return self;
}

- (void)swipeAction:(NSInteger)tag
{
    switch (tag) {
        case 101:
            currentTag =101;
            [_button1 setTitleColor:ligjt forState:UIControlStateNormal];
            [_button2 setTitleColor:black forState:UIControlStateNormal];
            [_button3 setTitleColor:black forState:UIControlStateNormal];
            
            _button1.titleLabel.font = lightFont;
            _button2.titleLabel.font = normalFont;
            _button2.titleLabel.font = normalFont;
            break;
        case 102:
            
            currentTag = 102;
            [_button1 setTitleColor:black forState:UIControlStateNormal];
            [_button2 setTitleColor:ligjt forState:UIControlStateNormal];
            [_button3 setTitleColor:black forState:UIControlStateNormal];
            
            _button1.titleLabel.font = normalFont;
            _button2.titleLabel.font = lightFont;
            _button2.titleLabel.font = normalFont;
            break;
        case 103:
            if (_buttonCount <=2) {
                break;
            }
            currentTag = 104;
            [_button1 setTitleColor:black forState:UIControlStateNormal];
            [_button2 setTitleColor:black forState:UIControlStateNormal];
            [_button3 setTitleColor:ligjt forState:UIControlStateNormal];
            
            _button1.titleLabel.font = normalFont;
            _button2.titleLabel.font = normalFont;
            _button2.titleLabel.font = lightFont;
            break;
        case 104:
            if (_buttonCount <=3) {
                break;
            }
            currentTag = 104;
            [_button1 setTitleColor:black forState:UIControlStateNormal];
            [_button2 setTitleColor:black forState:UIControlStateNormal];
            [_button3 setTitleColor:black forState:UIControlStateNormal];
            
            _button1.titleLabel.font = normalFont;
            _button2.titleLabel.font = normalFont;
            _button3.titleLabel.font = normalFont;
            break;
        default:
            break;
    }
    if (_ButtonActionBlock){
        _ButtonActionBlock(currentTag);
    }
}

- (void)btAction:(UIButton *)button
{
    [self swipeAction:button.tag];
}

@end
