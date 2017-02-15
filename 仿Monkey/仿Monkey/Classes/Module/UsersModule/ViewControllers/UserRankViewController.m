//
//  UserRankViewController.m
//  仿Monkey
//
//  Created by 林林尤达 on 17/2/3.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "UserRankViewController.h"
//国家选择 城市  语言
#import "CountryViewController.h"
#import "LanguageViewController.h"
//选择框
#import "HeaderSegmentControl.h"
//排行榜
#import "UserRankDataSource.h"
//排行数据
#import "UserRankViewModel.h"

@interface UserRankViewController ()<UITableViewDelegate>{
    UIScrollView *scrollView;
    UILabel *titleText; //标题
    int currentIndex;   //segment选中的按钮
    UITableView *tableView1;
    UITableView *tableView2;
    UITableView *tableView3;
    
    float titleHeight;    //标题行高
    float bgViewHeight;    //内容的高度
    HeaderSegmentControl *segmentControl;
    YiRefreshHeader *refreshHeader1;
    YiRefreshFooter *refreshFooter1;
    
    YiRefreshHeader *refreshHeader2;
    YiRefreshFooter *refreshFooter2;
    
    YiRefreshHeader *refreshHeader3;
    YiRefreshFooter *refreshFooter3;
    
    NSString *language;
    
    NSString *tableView1Language;
    NSString *tableView2Language;
    NSString *tableView3Language;
    
    UserRankDataSource *userRankDataSource;
    UserRankViewModel *userRankViewModel;
}
@property(nonatomic,strong) DataSourceModel *DsOfPageListObject1;
@property(nonatomic,strong) DataSourceModel *DsOfPageListObject2;
@property(nonatomic,strong) DataSourceModel *DsOfPageListObject3;
@property(nonatomic,strong) MKNetworkOperation *apiOperation;
@end

@implementation UserRankViewController
#pragma mark - Lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         //Custom initialization
        self.DsOfPageListObject1 = [[DataSourceModel alloc]init];
        self.DsOfPageListObject2 = [[DataSourceModel alloc]init];
        self.DsOfPageListObject3 = [[DataSourceModel alloc]init];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //判断版本 如果版本过低所做的处理  暂未理解其功能
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    
    userRankViewModel = [[UserRankViewModel alloc]init];
    titleText = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-120)/2, 0, 120, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor = [UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:19.0]];
    titleText.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleText;
    
    language = [[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
    if (language ==nil || language.length<1) {
        language = NSLocalizedString(@"all languages", @"");
    }
    tableView1Language = language;
    tableView2Language = language;
    tableView3Language = language;
    if ([language isEqualToString:@"CPP"]) {
        titleText.text = @"C++";
    }else{
        titleText.text = language;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    titleHeight = 35;
    bgViewHeight = ScreenHeight-64-titleHeight-49;
    [self initScroll];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    segmentControl = [[HeaderSegmentControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, titleHeight)];
    [self.view addSubview:segmentControl];
    if ([language isEqualToString:NSLocalizedString(@"all languages", @"")]){
        segmentControl.buttonCount = 2;
        segmentControl.button3.hidden = YES;
    }else{
        segmentControl.buttonCount = 3;
        segmentControl.button3.hidden = NO;
    }
    
    currentIndex =1;
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    if (city ==nil ||city.length <1){
        city = NSLocalizedString(@"beijing", @"");
    }
    
    [segmentControl.button1 setTitle:city forState:UIControlStateNormal];
    
    NSString *country = [[NSUserDefaults standardUserDefaults] objectForKey:@"country"];
    if (country==nil || country.length <1) {
        country = @"China";
    }
    [segmentControl.button2 setTitle:country forState:UIControlStateNormal];
    [self inittable];
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"city", @"") style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem=left;
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"language", @"") style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem=right;

}

#pragma mark - Actions
- (void)leftAction
{
    CountryViewController *viewController = [[CountryViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)rightAction
{
    LanguageViewController *viewController = [[LanguageViewController alloc]init];
    viewController.languageEntranceType = UserLanguageEntranceType;
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark - private
- (void)initScroll
{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleHeight, ScreenWidth, bgViewHeight)];
    scrollView.alwaysBounceHorizontal = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    [scrollView setContentSize:CGSizeMake(ScreenWidth *3, bgViewHeight)];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [scrollView scrollRectToVisible:CGRectMake(0, 0, ScreenWidth, bgViewHeight) animated:NO];
    if ([language isEqualToString:NSLocalizedString(@"all languages", @"")]) {
        [scrollView setContentSize:CGSizeMake(ScreenWidth*2, bgViewHeight)];
    }else{
        [scrollView setContentSize:CGSizeMake(ScreenWidth*3, bgViewHeight)];
    }
}


- (void)inittable
{
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, bgViewHeight) style:UITableViewStylePlain];
    [scrollView addSubview:tableView1];
    userRankDataSource = [[UserRankDataSource alloc]init];
    tableView1.dataSource = userRankDataSource;
    tableView1.delegate = self;
    tableView1.tag = 11;
    tableView1.rowHeight = RankTableViewCellHeight;
    tableView1.separatorStyle = UITableViewCellSelectionStyleNone;
    [self addHeader:1];
    [self addFooter:1];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
    
    __weak typeof(self) weakSelf = self;
    segmentControl.ButtonActionBlock= ^(int buttonTag){
        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf ]
    }
}


- (void)addHeader:(int)type
{
    if (type==1) {
        
        //    YiRefreshHeader  头部刷新按钮的使用
        refreshHeader1=[[YiRefreshHeader alloc] init];
        refreshHeader1.scrollView=tableView1;
        [refreshHeader1 header];
        __weak typeof(self) weakSelf = self;
        refreshHeader1.beginRefreshingBlock=^(){
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf loadDataFromApiWithIsFirst:YES];
        };
        
        //    是否在进入该界面的时候就开始进入刷新状态
        
        [refreshHeader1 beginRefreshing];
    }else if (type==2){
        //    YiRefreshHeader  头部刷新按钮的使用
        refreshHeader2=[[YiRefreshHeader alloc] init];
        refreshHeader2.scrollView=tableView2;
        [refreshHeader2 header];
        @weakify(self);
        refreshHeader2.beginRefreshingBlock=^(){
            @strongify(self);
            [self loadDataFromApiWithIsFirst:YES];
        };
        
        //    是否在进入该界面的时候就开始进入刷新状态
        
        [refreshHeader2 beginRefreshing];
        
    }else if (type==3){
        //    YiRefreshHeader  头部刷新按钮的使用
        refreshHeader3=[[YiRefreshHeader alloc] init];
        refreshHeader3.scrollView=tableView3;
        [refreshHeader3 header];
        @weakify(self);
        refreshHeader3.beginRefreshingBlock=^(){
            @strongify(self);
            [self loadDataFromApiWithIsFirst:YES];
        };
        
        //    是否在进入该界面的时候就开始进入刷新状态
        
        [refreshHeader3 beginRefreshing];
        
    }
}

- (void)addFooter:(int)type
{
    @weakify(self);
    if (type==1) {
        //    YiRefreshFooter  底部刷新按钮的使用
        refreshFooter1=[[YiRefreshFooter alloc] init];
        refreshFooter1.scrollView=tableView1;
        [refreshFooter1 footer];
        refreshFooter1.beginRefreshingBlock=^(){
            @strongify(self);
            [self loadDataFromApiWithIsFirst:NO];
        };
    }else if (type==2){
        //    YiRefreshFooter  底部刷新按钮的使用
        refreshFooter2=[[YiRefreshFooter alloc] init];
        refreshFooter2.scrollView=tableView2;
        [refreshFooter2 footer];
        refreshFooter2.beginRefreshingBlock=^(){
            @strongify(self);
            [self loadDataFromApiWithIsFirst:NO];
        };
        
    }else if (type==3){
        //    YiRefreshFooter  底部刷新按钮的使用
        refreshFooter3=[[YiRefreshFooter alloc] init];
        refreshFooter3.scrollView=tableView3;
        [refreshFooter3 footer];
        refreshFooter3.beginRefreshingBlock=^(){
            @strongify(self);
            [self loadDataFromApiWithIsFirst:NO];
        };
    }
}

- (void)loadDataFromApiWithIsFirst:(BOOL)isFirst
{
    if (currentIndex ==1){
        tableView1Language = language;
    }else if (currentIndex ==2){
        tableView2Language = language;
    }else if (currentIndex ==3){
        tableView3Language = language;
    }
    __weak typeof (self) weakSelf = self;
    [userRankViewModel loadDataFromApiWithIsFirst:isFirst currentIndex:currentIndex firstTableData:^(DataSourceModel *DsOfPageListObject) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        strongSelf->userRankDataSource.DsOfPageListObject1=DsOfPageListObject;
        [strongSelf->segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",(long)DsOfPageListObject.totalCount] forState:UIControlStateNormal];
        [strongSelf->tableView1 reloadData];
        
        if (!isFirst) {
            [strongSelf->refreshFooter1 endRefreshing];
        }else{
            [strongSelf->refreshHeader1 endRefreshing];
        }
    } secondTableData:^(DataSourceModel *DsOfPageListObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf->userRankDataSource.DsOfPageListObject2=DsOfPageListObject;
        [strongSelf->segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",(long)DsOfPageListObject.totalCount] forState:UIControlStateNormal];
        [strongSelf->tableView2 reloadData];
        
        if (!isFirst) {
            [strongSelf->refreshFooter2 endRefreshing];
        }else
        {
            [strongSelf->refreshHeader2 endRefreshing];
        }
        
    } thirdTableData:^(DataSourceModel *DsOfPageListObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf->userRankDataSource.DsOfPageListObject3=DsOfPageListObject;
        [strongSelf->segmentControl.button4 setTitle:[NSString stringWithFormat:@"total:%ld",(long)DsOfPageListObject.totalCount] forState:UIControlStateNormal];
        [strongSelf->tableView3 reloadData];
        if (!isFirst) {
            [strongSelf->refreshFooter3 endRefreshing];
        }else
        {
            [strongSelf->refreshHeader3 endRefreshing];
        }
    }];
}

#pragma mark = UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

#pragma mark - UITableViewDataSource &UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
