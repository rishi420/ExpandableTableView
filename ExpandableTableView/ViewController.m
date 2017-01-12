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
@property (nonatomic, strong) NSArray *headersAndCells;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headersAndCells = @[@{@"Header 1": @[@"Cell 1", @"Cell 2", @"Cell 3"]},
                     @{@"Header 2": @[@"Cell 1", @"Cell 2"]},
                     @{@"Header 3": @[@"Cell 1", @"Cell 2", @"Cell 3", @"Cell 4", @"Cell 5"]},
                     @{@"Header 4": @[]},
                     @{@"Header 5": @[@"Cell 1", @"Cell 2", @"Cell 3", @"Cell 4", @"Cell 5", @"Cell 6", @"Cell 7", @"Cell 8"]},
                     @{@"Header 6": @[@"Cell 1", @"Cell 2", @"Cell 3", @"Cell 4", @"Cell 5", @"Cell 6", @"Cell 7", @"Cell 8"]},
                     @{@"Header 7": @[@"Cell 1", @"Cell 2", @"Cell 3", @"Cell 4", @"Cell 5", @"Cell 6", @"Cell 7", @"Cell 8"]},
                     @{@"Header 8": @[@"Cell 1", @"Cell 2", @"Cell 3"]},
                     @{@"Header 9": @[@"Cell 1", @"Cell 2", @"Cell 3"]},
                     @{@"Header 10": @[@"Cell 1", @"Cell 2", @"Cell 3"]},
                     @{@"Header 11": @[@"Cell 1", @"Cell 2", @"Cell 3"]}];
    
    self.tableView.allHeadersInitiallyCollapsed = YES;
    self.tableView.initiallyExpandedSection = 0;
    self.tableView.singleSelectionEnable = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray *)cellsForSection:(NSInteger)section {
    NSDictionary *dic = self.headersAndCells[section];
    return dic.allValues.firstObject;
}

- (NSString *)sectionTextForSection:(NSInteger)section {
    NSDictionary *dic = self.headersAndCells[section];
    return dic.allKeys.firstObject;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *cells = [self cellsForSection:section];
    return [self.tableView totalNumberOfRows:cells.count inSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self cellsForSection:indexPath.section][indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headersAndCells.count;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HEADER_VIEW_HEIGHT;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.tableView headerWithTitle:[self sectionTextForSection:section] totalRows:[self cellsForSection:section].count inSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section-%ld, row-%ld", (long)indexPath.section, (long)indexPath.row);
}

@end
