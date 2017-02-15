//
//  CountryViewController.m
//  仿Monkey
//
//  Created by 林林尤达 on 17/2/3.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "CountryViewController.h"
#import "CityViewController.h"

@interface CountryViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableView1;
    NSArray *countrys;
}

@end

@implementation CountryViewController


#pragma mark - Lifecycle
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
    self.title = NSLocalizedString(@"选择国家", nil);
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:tableView1];
    
    tableView1.dataSource = self;
    tableView1.delegate = self;
    countrys = @[@"USA",@"UK",@"Germany",@"China",@"Canada",@"India",@"France",@"Australia",@"Other"];
    
}

- (void)dealloc
{
#if defined(DEBUG)||defined(_DEBUG)
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //do any additional setup after loading the view
}

#pragma mark - tableViewDateSource &UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return countrys.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSString *cellId = @"CellId1";
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = (countrys)[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当other时默认为china
    if (indexPath.row !=countrys.count-1) {
        [[NSUserDefaults standardUserDefaults] setObject:countrys[indexPath.row] forKey:@"country"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"Chiana" forKey:@"country"];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSArray *cityArray;
    if (indexPath.row==0) {
        //美国
        cityArray= @[@"San Francisco",@"New York",@"Seattle",@"Chicago",@"Los Angeles",@"Boston",@"Washington",@"San Diego",@"San Jose",@"Philadelphia"];
        
    }else if (indexPath.row==1){
        //        uk
        cityArray= @[@"London",@"Cambridge",@"Manchester",@"Edinburgh",@"Bristol",@"Birmingham",@"Glasgow",@"Oxford",@"Newcastle",@"Leeds"];
    }else if (indexPath.row==2){
        //germany
        cityArray= @[@"Berlin",@"Munich",@"Hamburg",@"Cologne",@"Stuttgart",@"Dresden",@"Leipzig"];
    }else if (indexPath.row==3){
        cityArray= @[@"beijing",@"shanghai",@"shenzhen",@"hangzhou",@"guangzhou",@"chengdu",@"nanjing",@"wuhan",@"suzhou",@"xiamen",@"tianjin",@"chongqing",@"changsha"];
        
    }else if (indexPath.row==4){
        //        canada
        cityArray= @[@"Toronto",@"Vancouver",@"Montreal",@"ottawa",@"Calgary",@"Quebec"];
    }else if (indexPath.row==5){
        //        india
        cityArray= @[@"Chennai",@"Pune",@"Hyderabad",@"Mumbai",@"New Delhi",@"Noida",@"Ahmedabad",@"Gurgaon",@"Kolkata"];
    }else if (indexPath.row==6){
        //        france
        cityArray= @[@"paris",@"Lyon",@"Toulouse",@"Nantes"];
    }else if (indexPath.row==7){
        //        澳大利亚
        cityArray= @[@"sydney",@"Melbourne",@"Brisbane",@"Perth"];
    }else if (indexPath.row==8){
        //        other
        cityArray= @[@"Tokyo",@"Moscow",@"Singapore",@"Seoul"];
    }
    CityViewController *viewController = [[CityViewController alloc] init];
    viewController.pinyinCitys = cityArray;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
