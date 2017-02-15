//
//  LanguageViewController.h
//  仿Monkey
//
//  Created by 林林尤达 on 17/2/4.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,LanguageEntranceType) {
    UserLanguageEntranceType = 0,
    RepLanguageEntranceType,
    TrendingLanguageEntranceType,
};

@interface LanguageViewController : UIViewController
@property (nonatomic,assign) LanguageEntranceType languageEntranceType;

@end
