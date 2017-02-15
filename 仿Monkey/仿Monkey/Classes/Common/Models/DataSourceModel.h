//
//  DataSourceModel.h
//  仿Monkey
//
//  Created by 林林尤达 on 17/2/6.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSourceModel : NSObject

@property (nonatomic,strong) NSMutableArray *dsArray;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger totalCount;


- (void)reset;
@end
