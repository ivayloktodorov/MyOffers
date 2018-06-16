//
//  ViewController.m
//  MyOffers
//
//  Created by Ivaylo Todorov on 11.06.18.
//  Copyright © 2018 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"
#import "AlertView.h"
#import "OffersViewController.h"
#import "ProfileVC.h"
#import "NewOfferVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.defaultsUser = [self.defaults stringForKey:@"defaultsFirstName"];

    if (self.defaultsUser != nil) {
        NSLog(@"automated login");
    }
}

- (IBAction)logInButtonPressed:(id)sender {
    [self logInFunc];
}

-(void)logInFunc{
  
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
        } else if (result.isCancelled) {
            // Handle cancellations
        } else {
            if ([result.grantedPermissions containsObject:@"email"]) {
                
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, email, picture"}]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         self.defaultsFirst = [NSString stringWithFormat:@"%@",[result objectForKey:@"first_name"]];
                         self.defaultsLast = [NSString stringWithFormat:@"%@",[result objectForKey:@"last_name"]];
                         self.defaultsEmail = [NSString stringWithFormat:@"%@",[result objectForKey:@"email"]];
                         self.defaultsPicture = [NSString stringWithFormat:@"%@",[result objectForKey:@"picture"]];
                         [self userDefaultsFunc];
                         [self createNewUser];
                     }
                     [self goToAllOffersVC];
                 }];
            } else {
            }
        }
    }];
}

-(void)goToAllOffersVC {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OffersViewController* goToOffersVC = [VC instantiateViewControllerWithIdentifier:@"OffersTableVCid"];
    [self presentViewController:goToOffersVC animated:NO completion:nil];
}

-(void)userDefaultsFunc{
    [self.defaults setValue: _defaultsFirst forKey:@"defaultsFirstName"];
    [self.defaults setValue: _defaultsLast forKey:@"defaultsLastName"];
    [self.defaults setValue: _defaultsEmail forKey:@"defaultsEmail"];
    [self.defaults setValue: _defaultsPicture forKey:@"defaultsPicture"];
    [self.defaults synchronize];
    
}

-(void)createNewUser{
    PFObject* newUser = [PFObject objectWithClassName:@"Users"];
    newUser[@"firstname"] = self.defaultsFirst;
    newUser[@"lastname"] = self.defaultsLast;
    newUser[@"email"] = self.defaultsEmail;
    newUser[@"picture"] = self.defaultsPicture;

    [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
        } else {
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
