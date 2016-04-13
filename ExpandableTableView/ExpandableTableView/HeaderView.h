//
//  HeaderView.h
//  ExpandableTableView
//
//  Created by Warif Akhand Rishi on 4/13/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeaderView;

@protocol HeaderViewDelegate <NSObject>

- (void)didTapHeader:(HeaderView *)view;

@end

@interface HeaderView : UITableViewHeaderFooterView

@property (nonatomic, assign) id<HeaderViewDelegate> delegate;
@property (nonatomic, readonly) NSInteger section;
@property (nonatomic, readonly) NSInteger totalRows;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame;
- (void)updateWithTitle:(NSString *)title isCollapsed:(BOOL)isCollapsed totalRows:(NSInteger)row andSection:(NSInteger)section;

@end
