//
//  DetailOfferVC.m
//  MyOffers
//
//  Created by Ivaylo Todorov on 12.06.18.
//  Copyright © 2018 Ivaylo Todorov. All rights reserved.
//

#import "DetailOfferVC.h"
#import "OffersViewController.h"
#import "ProfileVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse.h>

@interface DetailOfferVC ()

@end

@implementation DetailOfferVC

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDateFormatter* formatDate = [[NSDateFormatter alloc]init];
    [formatDate setDateFormat:@"dd/MM/yyyy"];
    NSString *crDateStr = [formatDate stringFromDate:_dateCreted];
    NSString *expDateStr = [formatDate stringFromDate:_dateExp];
    
    _titleLabel.text = _titleStr;
    _subtitleLabel.text = _subTitleStr;
    _priceLabel.text = [_price stringValue];
    _sellerLabel.text = _sellerIDStr;
    _locationLabel.text = _locationStr;
    _createdDateLabel.text = crDateStr;
    _expDateLabel.text = expDateStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonPressed:(id)sender {
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OffersViewController* goToProfileVC = [VC instantiateViewControllerWithIdentifier:@"OffersTableVCid"];
    [self presentViewController:goToProfileVC animated:true completion:nil];
}


@end
