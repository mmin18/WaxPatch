//
//  MainViewController.m
//  WaxPatch
//
//  Created by Yimin Tu on 12-8-10.
//  Copyright (c) 2012年 dianping.com. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    return cell;
}

@end
