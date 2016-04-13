# ExpandableTableView

[![](http://img.shields.io/badge/iOS-7.0%2B-lightgrey.svg)]()
[![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/algolia/UILabel)

This subclass of UITableView makes the Headers to expand or collapse. 

## Setup

Simply drag and drop the "ExpandableTableView" directory in your project. This directory has 4 files.

1. `ExpandableTableView.h`
2. `ExpandableTableView.m`
3. `HeaderView.h`
4. `HeaderView.m`

## How to use

1. Change your `UITableView` class to `ExpandableTableView` class in storyboard.
2. #import "ExpandableTableView.h"
3. create an `IBOutlet` of ExpandableTableView
4. In `numberOfRowsInSection` call `totalNumberOfRows:inSection:` 
5. call `headerWithTitle:totalRows:inSection:` in `viewForHeaderInSection`

## Features
- To make all Headers start with collapsed state use `allHeadersInitiallyCollapsed`
- To make all Headers start with collapsed state execpt one section use `initiallyExpandedSection`

