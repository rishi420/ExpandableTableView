//
//  ExpandableTableView.m
//  ExpandableTableView
//
//  Created by Warif Akhand Rishi on 4/13/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//

#import "ExpandableTableView.h"
#import "HeaderView.h"

@interface ExpandableTableView () <HeaderViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *sectionStatusDic;
@property (nonatomic, strong) HeaderView *prevHeaderView;

@end

@implementation ExpandableTableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self setup];
    }
 
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    _sectionStatusDic = [[NSMutableDictionary alloc] init];
    self.initiallyExpandedSection = -1;
}

- (HeaderView *)headerView {
    
    HeaderView *headerView  = [self dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    
    if (!headerView) {
        CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), HEADER_VIEW_HEIGHT);
        headerView = [[HeaderView alloc] initWithReuseIdentifier:@"Header" andFrame:frame];
        headerView.delegate = self;
    }
    
    return headerView;
}

- (NSArray *)indexPathsForHeaderView:(HeaderView *)headerView {
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < headerView.totalRows; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:headerView.section]];
    }
    
    return indexPaths;
}

- (BOOL)collapsedForSection:(NSInteger)section {
    
    NSString *key = [NSString stringWithFormat:@"%ld", (long)section];

    if (self.sectionStatusDic[key]) {
        return ((NSNumber *)self.sectionStatusDic[key]).boolValue;
    }
    
    return (self.initiallyExpandedSection == section) ? NO : self.allHeadersInitiallyCollapsed;
}

- (NSInteger)totalNumberOfRows:(NSInteger)total inSection:(NSInteger)section; {
    
    return ([self collapsedForSection:section]) ? 0 : total;
}

- (UIView *)headerWithTitle:(NSString *)title totalRows:(NSInteger)row inSection:(NSInteger)section {

    BOOL isCollapsed = [self collapsedForSection:section];
    
    HeaderView *headerView = self.headerView;
    [headerView updateWithTitle:title isCollapsed:isCollapsed totalRows:row andSection:section];
    
    if (!self.prevHeaderView && self.initiallyExpandedSection == section) {
        self.prevHeaderView = headerView;
    }
    
    return headerView;
}

#pragma mark - HeaderViewDelegate

- (void)didTapHeader:(HeaderView *)headerView {
    
    NSString *key = [NSString stringWithFormat:@"%ld", (long)headerView.section];
    BOOL isCollapsed = [self collapsedForSection:headerView.section];
    isCollapsed = !isCollapsed;
    
    [self.sectionStatusDic setObject:@(isCollapsed) forKey:key];

    [self beginUpdates];

    if (self.singleSelectionEnable && self.prevHeaderView != headerView && ![self collapsedForSection:self.prevHeaderView.section]) {
        
        NSArray *indexPaths = [self indexPathsForHeaderView:self.prevHeaderView];
        [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        
        NSString *key = [NSString stringWithFormat:@"%ld", (long)self.prevHeaderView.section];
        [self.sectionStatusDic setObject:@(YES) forKey:key];
        
        [self.prevHeaderView updateWithTitle:self.prevHeaderView.title isCollapsed:YES totalRows:self.prevHeaderView.totalRows andSection:self.prevHeaderView.section];
    }
    
    NSArray *indexPaths = [self indexPathsForHeaderView:headerView];
    
    if (isCollapsed) {
        [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    } else {
        [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    }
    
    [self endUpdates];
    
    self.prevHeaderView = headerView;
}

@end
