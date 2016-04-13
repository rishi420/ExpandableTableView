//
//  HeaderView.m
//  ExpandableTableView
//
//  Created by Warif Akhand Rishi on 4/13/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger totalRows;
@property (nonatomic, strong) UIButton *headerButton;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isCollapsed;

@end

@implementation HeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.frame = frame;
        
        [self addHeaderButton];
    }

    return self;
}

- (void)addHeaderButton {
    
    _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headerButton.frame = self.bounds;
    self.headerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.headerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.headerButton addTarget:self action:@selector(headerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.headerButton];
}

- (void)headerButtonAction:(UIButton *)headerButton {
    
    self.isCollapsed = !self.isCollapsed;
    [self setHeaderText];
    
    if ([self.delegate respondsToSelector:@selector(didTapHeader:)]) {
        [self.delegate didTapHeader:self];
    }
}

- (void)updateWithTitle:(NSString *)title isCollapsed:(BOOL)isCollapsed totalRows:(NSInteger)row andSection:(NSInteger)section {
    
    self.title = title;
    self.isCollapsed = isCollapsed;
    self.section = section;
    self.totalRows = row;
    
    [self setHeaderText];
}

- (void)setHeaderText {
    
    NSString *plusOrMinus = (self.isCollapsed) ? @" +\t" : @" -\t";
    [self.headerButton setTitle:[plusOrMinus stringByAppendingString:self.title] forState:UIControlStateNormal];
}

@end
