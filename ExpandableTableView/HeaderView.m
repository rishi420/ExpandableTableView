//
//  HeaderView.m
//  ExpandableTableView
//
//  Created by Warif Akhand Rishi on 4/13/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (nonatomic, assign) BOOL isCollapsed;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) UIButton *headerButton;
@property (nonatomic, strong) NSString *title;

@end

@implementation HeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.frame = frame;
        
        _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headerButton.frame = self.bounds;
        self.headerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.headerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.headerButton addTarget:self action:@selector(headerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.headerButton];
        
        self.isCollapsed = YES;
    }

    return self;
}

- (void)setHeaderText {
    
    NSString *plusOrMinus = (self.isCollapsed) ? @" + " : @" - ";
    [self.headerButton setTitle:[plusOrMinus stringByAppendingString:self.title] forState:UIControlStateNormal];
}

- (void)updateWithTitle:(NSString *)title andSection:(NSInteger)section {
    
    self.section = section;
    self.title = title;
    [self setHeaderText];
}

- (void)headerButtonAction:(UIButton *)headerButton {
    
    self.isCollapsed = !self.isCollapsed;
    [self setHeaderText];
    
    if ([self.delegate respondsToSelector:@selector(didTapHeader:)]) {
        [self.delegate didTapHeader:self];
    }
}

@end
