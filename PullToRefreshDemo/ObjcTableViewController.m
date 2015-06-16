//
//  ObjcTableViewController.m
//  PullToRefreshDemo
//
//  Created by dasdom on 16.06.15.
//  Copyright (c) 2015 Dominik Hauser. All rights reserved.
//

#import "ObjcTableViewController.h"
#import "PullToRefreshDemo-Swift.h"

@interface ObjcTableViewController () <BreakOutToRefreshDelegate>
@property (nonatomic, strong) BreakOutToRefreshView *refreshView;
@end

@implementation ObjcTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.refreshView = [[BreakOutToRefreshView alloc] initWithScrollView:self.tableView];
  self.refreshView.delegate = self;
  
  [self.tableView addSubview:self.refreshView];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemoCell" forIndexPath:indexPath];
  
  cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
  
  return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [self.refreshView scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  [self.refreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
  [self.refreshView scrollViewWillBeginDecelerating:scrollView];
}

- (void)refreshViewDidRefresh:(BreakOutToRefreshView * __nonnull)refreshView {
  // this code is to simulage the loading from the internet
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 3), dispatch_get_main_queue(), ^{
    [self.refreshView endRefreshing];
  });
}

@end
