//
//  UserRankDataSource.h
//  仿Monkey
//
//  Created by 林林尤达 on 17/2/6.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserRankDataSource : NSObject<UITableViewDataSource>

@property (nonatomic,strong) DataSourceModel *DsOfPageListObject1; //city datasource
@property (nonatomic,strong) DataSourceModel *DsOfPageListObject2; //country datasource
@property (nonatomic,strong) DataSourceModel *DsOfPageListObject3; //world datasource
@end
