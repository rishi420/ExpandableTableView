//
//  ViewController.m
//  ExpandableTableView
//
//  Created by Warif Akhand Rishi on 4/13/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//

#import "ViewController.h"
#import "ExpandableTableView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ExpandableTableView *tableView;

@property (nonatomic, strong) NSArray *cells;
@property (nonatomic, strong) NSArray *headers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cells = @[@"Cell 1", @"Cell 2", @"Cell 3", @"Cell 4", @"Cell 5", @"Cell 6", @"Cell 7", @"Cell 8"];
    self.headers = @[@"Header 1", @"Header 2", @"Header 3", @"Header 4", @"Header 5", @"Header 6", @"Header 7", @"Header 8", @"Header 9", @"Header 10", @"Header 11", @"Header 12", @"Header 13", @"Header 14"];
    
    self.tableView.allHeadersInitiallyCollapled = YES;
    self.tableView.initiallyExpandedSection = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.tableView totalNumberOfRows:self.cells.count inSection:section];
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
    
    return [self.tableView headerWithTitle:self.headers[section] totalRows:self.cells.count inSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section-%ld, row-%ld", (long)indexPath.section, (long)indexPath.row);
}

@end
