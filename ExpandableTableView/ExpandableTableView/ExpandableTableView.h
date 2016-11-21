//
//  ExpandableTableView.h
//  ExpandableTableView
//
//  Created by Warif Akhand Rishi on 4/13/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HEADER_VIEW_HEIGHT 28

@interface ExpandableTableView : UITableView

@property (nonatomic, assign) BOOL allHeadersInitiallyCollapsed;
@property (nonatomic, assign) int initiallyExpandedSection;
@property (nonatomic, assign) BOOL singleSelectionEnable;

- (NSInteger)totalNumberOfRows:(NSInteger)total inSection:(NSInteger)section;
- (UIView *)headerWithTitle:(NSString *)title totalRows:(NSInteger)row inSection:(NSInteger)section;

@end
