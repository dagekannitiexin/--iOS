//
//  UserRankViewModel.h
//  仿Monkey
//
//  Created by 林林尤达 on 17/2/7.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UserRankDataSourceModelResponseBlock)(DataSourceModel *DsOfPageListObject);

@interface UserRankViewModel : NSObject

- (BOOL)loadDataFromApiWithIsFirst:(BOOL)isFirst
                      currentIndex:(int)currentIndex
                    firstTableData:(UserRankDataSourceModelResponseBlock)firstCompletionBlock
                   secondTableData:(UserRankDataSourceModelResponseBlock)secondCompletionBlock
                    thirdTableData:(UserRankDataSourceModelResponseBlock)thirdCompletionBlock;

@end
