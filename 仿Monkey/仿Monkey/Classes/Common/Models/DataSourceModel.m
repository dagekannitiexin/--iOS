//
//  DataSourceModel.m
//  仿Monkey
//
//  Created by 林林尤达 on 17/2/6.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "DataSourceModel.h"

@implementation DataSourceModel

- (id)init
{
    self = [super init];
    if (self){
        self.dsArray = [[NSMutableArray alloc]initWithCapacity:32];
        self.page = 0;
    }
    return self;
}

- (void)reset
{
    self.page = 0;
    [self.dsArray removeAllObjects];
}
@end
