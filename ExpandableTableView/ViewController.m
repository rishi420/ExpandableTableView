//
//  ViewController.m
//  ExpandableTableView
//
//  Created by Warif Akhand Rishi on 4/13/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"

@interface ViewController () <HeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *cells;
@property (nonatomic, strong) NSArray *headers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cells = @[@"Cell 1", @"Cell 2"];
    self.headers = @[@"Header 1", @"Header 2"];
    
    [self.tableView registerClass:[HeaderView class] forHeaderFooterViewReuseIdentifier:@"Header"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //HeaderView *headerView = (HeaderView *)[tableView headerViewForSection:section];
    HeaderView *headerView = (HeaderView *)[self tableView:tableView viewForHeaderInSection:section];
    
    NSLog(@"headerView = %@, section = %ld", headerView, (long)section);
    
    return (headerView.isCollapsed) ? 0 : self.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.cells[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.headers.count;
}

#pragma mark - UITableViewDelegate

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HeaderView *headerView  = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    if (!headerView) {
        CGRect frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 28);
        headerView = [[HeaderView alloc] initWithReuseIdentifier:@"header" andFrame:frame];
        headerView.delegate = self;
    }
    
    [headerView updateWithTitle:self.headers[section] andSection:section];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - HeaderViewDelegate

- (void)didTapHeader:(HeaderView *)headerView {
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.cells.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:headerView.section]];
    }
    
    [self.tableView beginUpdates];

    if (headerView.isCollapsed) {
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    } else {
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
    }
    
    [self.tableView endUpdates];
}

@end
