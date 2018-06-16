//
//  ProfileVC.m
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
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse.h>

@interface ProfileVC ()

@end

@implementation ProfileVC

@synthesize tableViewOutlet;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self loadProfileData];
    [self myOffersQuery];
    self.tableViewOutlet.delegate = self;
    self.tableViewOutlet.dataSource = self;
}


-(void)viewWillAppear:(BOOL)animated {
    [self.tableViewOutlet setContentOffset:CGPointMake(0, 44)];
}

-(void)myOffersQuery{
PFQuery *query = [PFQuery queryWithClassName:@"Offer"];
[query whereKey:@"sellerID" equalTo:_emailLabel.text];
[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error) {
        NSLog(@"Successfully retrieved %lu categories.", (unsigned long)self.myOffers.count);
        self.myOffers = objects;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableViewOutlet reloadData];
        });
    } else {
        NSLog(@"Error: %@ %@", error, [error userInfo]);
    }
}];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.myOffers != nil) {
    return self.myOffers.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* indetified = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetified];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetified];
    }
    
    PFObject *offers = [self.myOffers objectAtIndex:indexPath.row];
    NSLog(@"%li index", (long)indexPath.row);
    cell.textLabel.text = [offers valueForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PFObject *offers = [self.myOffers objectAtIndex:indexPath.row];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OffersViewController* goToOffersVC = [VC instantiateViewControllerWithIdentifier:@"OffersTableVCid"];
    [self presentViewController:goToOffersVC animated:true completion:nil];
}

- (IBAction)logOutButtonPressed:(id)sender {
    UIAlertController* logOutAlert = [UIAlertController alertControllerWithTitle:@"Are you sure you want to logout?" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* logOutAgree = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.defaults removeObjectForKey:@"defaultsFirstName"];
        [self.defaults removeObjectForKey:@"defaultsLastName"];
        [self.defaults removeObjectForKey:@"defaultsEmail"];
        [self.defaults synchronize];
        
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logOut];
        
        UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController* goToMainVC = [VC instantiateViewControllerWithIdentifier:@"logInid"];
        [self presentViewController:goToMainVC animated:true completion:nil];
        
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [logOutAlert addAction:logOutAgree];
    [logOutAlert addAction:cancel];
    [self presentViewController:logOutAlert animated:YES completion:nil];
    
}

-(void)loadProfileData{
    _firstnameLabel.text = [self.defaults valueForKey:@"defaultsFirstName"];
    _lastnameLabel.text = [self.defaults valueForKey:@"defaultsLastName"];
    _emailLabel.text = [self.defaults valueForKey:@"defaultsEmail"];
    _pictureLabel.text = _picture;
}


@end
