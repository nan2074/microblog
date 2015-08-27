//
//  SNHomeTableViewController.m
//  网贷
//
//  Created by 普伴 on 15/8/10.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNHomeTableViewController.h"
#import "SNTitleBtn.h"
#import "SNPopMenu.h"
#import "AFNetworking.h"
#import "SNAccount.h"
#import "SNAccountTool.h"
#import "SNStatus.h"
#import "SNUser.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "SNLoadMoreFooter.h"
#import "SNUserTool.h"
#import "SNStatusTool.h"
#import "SNStatusCell.h"
#import "SNStatusFrame.h"


@interface SNHomeTableViewController ()<SNPopMenuDelegate>

@property (weak, nonatomic) UIButton *leftBtn;


@property (weak, nonatomic) SNTitleBtn *titleButton;

@property (nonatomic, strong) NSMutableArray *statusesFrames;
@property (weak, nonatomic) SNLoadMoreFooter *footer;


@end

@implementation SNHomeTableViewController


- (NSMutableArray *)statusesFrames
{
    if (_statusesFrames == nil) {
        _statusesFrames = [NSMutableArray array];
    }
    return _statusesFrames;
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = SNColor(211, 211, 211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupNavBar];
    
    [self setPersonIcon];
    
    
    [self setupRefresh];
    
    [self setupUserInfo];
    
    
}
/**
 *  获取用户信息
 */
- (void)setupUserInfo
{
    // 1.封装请求参数
    SNUserInfoParam *param = [SNUserInfoParam param];
    param.uid = [SNAccountTool account].uid;
    
    // 2.加载用户信息
    [SNUserTool userInfoWithParam:param success:^(SNUserInfoResult *user) {
        
        // 设置用户的昵称为标题
        SNAccount *account = [SNAccountTool account];
        account.name = user.name;
        [SNAccountTool save:account];
    } failure:^(NSError *error) {
        SNLog(@"请求失败-------%@", error);
    }];
}


/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    
    // 2.监听状态
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    // 3.让刷新控件自动进入刷新状态
    [refreshControl beginRefreshing];
    
    // 4.加载数据
    [self refreshControlStateChange:refreshControl];

    // 5.添加上拉加载更多控件
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 44;
    CGRect rect = CGRectMake(0, 0, width, height);
    SNLoadMoreFooter *footer = [[SNLoadMoreFooter alloc] initWithFrame:rect];
    self.tableView.tableFooterView = footer;
    self.footer = footer;
 
//    NSLog(@"footer = %@",footer);
}

- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    [self loadNewStatuses:refreshControl];
}

/**
 *  加载新数据
 */
- (void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
//    // 1.获得请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//    // 2.封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [SNAccountTool account].access_token;
//    SNStatus *firstStatus = [self.statuses firstObject];
//    if (firstStatus) {
//        params[@"since_id"] = firstStatus.idstr;
//    }
//    
//    // 3.发生GET请求
//    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json"  parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *resultDict) {
//        
//        // 微博字典转模型
//        NSArray *statusDictArray = resultDict[@"statuses"];
//    
//        
//        // 微博字典数组 ----> 微博模型数组
//        NSArray *newStatuses = [SNStatus objectArrayWithKeyValuesArray:statusDictArray];
//        
//        
//        // 将新数组插入到旧数据的最前面
//        NSRange range = NSMakeRange(0, newStatuses.count);
//     
//        
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
//   
//        
//        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
//        
//        // 从新刷新表格
//        [self.tableView reloadData];
//        
//        // 让刷新控件停止刷新
//        [refreshControl endRefreshing];
//        
//        // 提示用户最新的微博数量
//        [self showNewStatusesCount:newStatuses.count];
//    
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        SNLog(@"请求失败--------%@",error);
//        [refreshControl endRefreshing];
//    }];
    
    // 1.封装请求参数
    SNHomeStatusesParam *param = [SNHomeStatusesParam param];
    SNStatusFrame *firstStatusFrame = [self.statusesFrames firstObject];
    SNStatus *firstStatus = firstStatusFrame.status;
    if (firstStatus) {
        param.since_id = @([firstStatus.idstr longLongValue]);
    }
    
    // 2.加载微博数据
    [SNStatusTool homeStatusesWithParam:param success:^(SNHomeStatusesResult *result) {
        
        // 获得最新的微博数组
        NSArray *newStatuses = result.statuses;
        
//        将最新的数据插入到旧数据前面
        NSRange range = NSMakeRange(0, newStatuses.count);

        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];

        [self.statusesFrames insertObjects:newStatuses atIndexes:indexSet];

        // 从新刷新表格
        [self.tableView reloadData];

        // 让刷新控件停止刷新
        [refreshControl endRefreshing];
        
        // 提示用户最新的微博数量
        [self showNewStatusesCount:newStatuses.count];

    } failure:^(NSError *error) {
        
        SNLog(@"请求失败--------%@",error);
                [refreshControl endRefreshing];

    }];

}

/**
 *  提示用户最新的微博数量
 *
 *  @return 最新的微博数量
 */
- (void)showNewStatusesCount:(NSUInteger)count
{
    // 1.创建一个UILabel
    UILabel *label = [[UILabel alloc] init];
    
    // 2.显示文字
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%lu条新的微博数据",count];
    }
    else {
        label.text = @"没有最新的微博数据";
    }
    
    // 3.设置背景
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    // 4.设置frame
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    
    // 5.添加到导航控制器的view
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 6.动画
    CGFloat duration = 0.75;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        
    } completion:^(BOOL finished) {
        
        // 延迟x秒后，再执行动画
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
            // 回复到原来位置
            label.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            //删除控件
            [label removeFromSuperview];
        }];
    }];
}

/**
 *  加载更多微博数据
 */
- (void)loadMoreStatuses
{
//    // 1.获得请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//    // 2.封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [SNAccountTool account].access_token;
//    SNStatus *lastStatus = [self.statuses lastObject];
//    if (lastStatus) {
//        
//        params[@"max_id"] = @([lastStatus.idstr longLongValue] - 1);
//    }
//    
//    // 3.发送GET请求
//    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *resultDict) {
//  
//        // 微博字典数组
//        NSArray *statusDictArray = resultDict[@"statuses"];
//        // 微博字典数组 ---> 微博模型数组
//        NSArray *newStatuses = [SNStatus objectArrayWithKeyValuesArray:statusDictArray];
//        
//        // 将新数据插入到旧数据的最后面
//        [self.statuses addObjectsFromArray:newStatuses];
//        
//        // 重新刷新表格
//        [self.tableView reloadData];
//        
//        // 让刷新控件停止刷新（恢复默认的状态）
//        [self.footer endRefreshing];
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        SNLog(@"请求失败--%@", error);
//        // 让刷新控件停止刷新（恢复默认的状态）
//        [self.footer endRefreshing];
//
//    }];
    // 1.封装请求参数
    SNHomeStatusesParam *param = [SNHomeStatusesParam param];
    SNStatus *lastStatus = [self.statusesFrames lastObject];
    if (lastStatus) {
        param.max_id = @([lastStatus.idstr longLongValue] - 1);
    }
    
    // 2.加载微博数据
    [SNStatusTool homeStatusesWithParam:param success:^(SNHomeStatusesResult *result) {
        
        // 微博模型数组
        NSArray *newStatuses = result.statuses;
        
        //将新数据插入的旧数据的最后面
        [self.statusesFrames addObjectsFromArray:newStatuses];
        
        // 从新刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止刷新
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        
        [self.footer endRefreshing];
        SNLog(@"请求失败");
    }];
}

- (void)setPersonIcon
{
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 33, 33);
    [self.leftBtn addTarget:self action:@selector(myAccountBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.leftBtn setImage:[[UIImage imageNamed:@"me"] getRoundImage] forState:UIControlStateNormal];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];

}

- (void)setupNavBar
{

    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" highImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 设置导航栏中间的标题按钮
    SNTitleBtn *titleButton = [[SNTitleBtn alloc] init];
    // 设置尺寸
    titleButton.height = 35;
    titleButton.width = 100;
    NSString *name = [SNAccountTool account].name;
    [titleButton setTitle:name?name : @"首页" forState:UIControlStateNormal];
    // 设置文字
//    NSString *name = [HMAccountTool account].name;
//    [titleButton setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    // 设置图标
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 设置背景
    [titleButton setBackgroundImage:[UIImage resizedImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    // 监听按钮点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;


}
- (void)pop
{
    
    [self.titleButton setTitle:@"哈哈哈" forState:UIControlStateNormal];
}

- (void)myAccountBtn
{
    if ([self.SNHomeDelegate respondsToSelector:@selector(myAccountBtnclk)]) {
        [self.SNHomeDelegate myAccountBtnclk];
    }

}

- (void)titleClick:(UIButton *)titleButton
{
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    // 弹出菜单
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.backgroundColor = [UIColor blueColor];
    
    SNPopMenu *menu = [[SNPopMenu alloc] initWithContentView:nil];
    menu.delegate = self;
    menu.arrowPosition = SNPopMenuArrowPositionCenter;
    [menu showInRect:CGRectMake(100, 0, 200, 400)];
}
- (void)popMenuDidDismissed:(SNPopMenu *)popMenu
{
    SNTitleBtn *titleButton = (SNTitleBtn *)self.navigationItem.titleView;
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    
    self.footer.hidden = self.statusesFrames.count == 0;
    return self.statusesFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
//    
//    // 取出这行对应的微博
//    SNStatus *status = self.statuses[indexPath.row];
//    cell.textLabel.text = status.text;
//    
//    // 取出用户
//    SNUser *user = status.user;
//    cell.detailTextLabel.text = user.name;
//    
//    // 下载头像
//    NSString *imageUrlStr = user.profile_image_url;
//    [cell.imageView setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    
    SNStatusCell *cell = [SNStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusesFrames[indexPath.row];
    
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statusesFrames.count <= 0 || self.footer.refreshing) {
        return;
    }
    
    // 1.差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    
    SNLog(@"scrollView.contentSize.height = %f\nscrollView.contentOffset.y = %f",scrollView.contentSize.height,scrollView.contentOffset.y);
    // 刚好能完整看到footer的高度
    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    SNLog(@"delta = %f--------sawFooterH = %f",delta,sawFooterH);
    // 2.如果能看见整个footer
    if (delta <= (sawFooterH - 0)) {
        
        // 进入上拉状态
        [self.footer beginRefreshing];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            // 加载更多微博数据
            [self loadMoreStatuses];
        });
        
    }
}


- (void)refresh:(BOOL)fromSelf
{
    if (self.tabBarItem.badgeValue) {
        
        [self.refreshControl beginRefreshing];
        
        [self loadNewStatuses:self.refreshControl];
        
        self.tabBarItem.badgeValue = nil;
    }
    else if (fromSelf){
        NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:firstRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
