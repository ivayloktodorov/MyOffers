//
//  OffersViewController.h
//  MyOffers
//
//  Created by Ivaylo Todorov on 12.06.18.
//  Copyright © 2018 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface OffersViewController : ViewController <UITableViewDelegate, UITableViewDataSource> 

@property (weak, nonatomic) IBOutlet UITableView *tableViewOutlet;
@property (nonatomic, strong) NSArray* allOffers;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;

@end
