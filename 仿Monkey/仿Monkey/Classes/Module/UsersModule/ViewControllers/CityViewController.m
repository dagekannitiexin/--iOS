//
//  CityViewController.m
//  仿Monkey
//
//  Created by 林林尤达 on 17/2/4.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "CityViewController.h"

@interface CityViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableView1;
    NSArray *citys;
}

@end

@implementation CityViewController
@synthesize pinyinCitys;


#pragma mark  - lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Select City", nil);
    
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:tableView1];
    tableView1.delegate =self;
    tableView1.dataSource = self;
    
    if (pinyinCitys.count>0){
        if (![pinyinCitys[0]isEqualToString:@"beijing"]){
            citys = pinyinCitys;
        }else{
            citys=@[NSLocalizedString(@"beijing", @""),NSLocalizedString(@"shanghai", @""),NSLocalizedString(@"shenzhen", @""),
                    NSLocalizedString(@"hangzhou", @""),NSLocalizedString(@"guangzhou", @""),NSLocalizedString(@"chengdu", @""),
                    NSLocalizedString(@"nanjing", @""),NSLocalizedString(@"wuhan", @""),NSLocalizedString(@"suzhou", @""),
                    NSLocalizedString(@"xiamen", @""),NSLocalizedString(@"tianjin", @""),NSLocalizedString(@"chongqing", @""),
                    NSLocalizedString(@"changsha", @"")];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - uitableViewDateSource &UitableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return citys.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    NSString *cellId =@"CellId1";
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = (citys)[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"cityAppear"];
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"countryApper"];
    [[NSUserDefaults standardUserDefaults] setObject:pinyinCitys[indexPath.row] forKey:@"pinyinCity"];
    [[NSUserDefaults standardUserDefaults] setObject:citys[indexPath.row] forKey:@"city"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
