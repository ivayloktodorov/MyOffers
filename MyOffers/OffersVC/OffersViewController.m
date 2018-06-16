//
//  OffersViewController.m
//  MyOffers
//
//  Created by Ivaylo Todorov on 12.06.18.
//  Copyright © 2018 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"
#import "AlertView.h"
#import "OffersViewController.h"
#import "ProfileVC.h"
#import "NewOfferVC.h"
#import "DetailOfferVC.h"
//#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse.h>

@interface OffersViewController ()

@end

@implementation OffersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allOffersQuery];
    self.tableViewOutlet.delegate = self;
    self.tableViewOutlet.dataSource = self;
//    tableData = [NSArray arrayWithObjects:@"test", @"test1", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableViewOutlet setContentOffset:CGPointMake(0, 44)];
}

-(void)allOffersQuery{
    PFQuery *query = [PFQuery queryWithClassName:@"Offer"];
//    [query whereKey:@"sellerID" equalTo:@"ivaylo.k.todorov@me.com"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu categories.", (unsigned long)self.allOffers.count);
            self.allOffers = objects;
          
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableViewOutlet reloadData];
            });
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    if (_allOffers.count == 0) {
////         [AlertView showAlertViewWithTitle:@"Внимание!" message:@"До момента няма създадени оферти, моля добавете своята." controller:self];
//        [self goToNewOfferVC];
//    }
//    else {
        return _allOffers.count;
//    }
//    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    PFObject *offers = [self.allOffers objectAtIndex:indexPath.row];
    NSLog(@"%li index", (long)indexPath.row);
    cell.textLabel.text = [offers valueForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PFObject *offers = [self.allOffers objectAtIndex:indexPath.row];
    NSLog(@"%li index", (long)indexPath.row);
    NSLog(@"%@",offers);
    
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailOfferVC* goToDetailVC = [VC instantiateViewControllerWithIdentifier:@"detailVC"];
    
    goToDetailVC.titleStr = [offers valueForKey:@"title"];
    goToDetailVC.subTitleStr = [offers valueForKey:@"subtitle"];
    goToDetailVC.price = [offers valueForKey:@"price"];
    goToDetailVC.sellerIDStr = [offers valueForKey:@"sellerID"];
    goToDetailVC.locationStr = [offers valueForKey:@"location"];
    goToDetailVC.dateCreted = [offers valueForKey:@"createdAt"];
    goToDetailVC.dateExp = [offers valueForKey:@"expDate"];
    //        goToDetailVC.image = [UIImage imageWithData:[offers valueForKey:@"image"]];
    [self presentViewController:goToDetailVC animated:true completion:nil];
    }

- (IBAction)addButtonPress:(id)sender {
    [self goToNewOfferVC];
}

- (IBAction)profileButtonPress:(id)sender {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProfileVC* goProfileVC = [VC instantiateViewControllerWithIdentifier:@"ProfileVCid"];
    [self presentViewController:goProfileVC animated:true completion:nil];
}

-(void)goToNewOfferVC{
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewOfferVC* goToNewOfferVC = [VC instantiateViewControllerWithIdentifier:@"NewOfferVCid"];
    [self presentViewController:goToNewOfferVC animated:true completion:nil];
}


@end
