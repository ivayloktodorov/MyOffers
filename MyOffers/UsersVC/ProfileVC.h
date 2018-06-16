//
//  ProfileVC.h
//  MyOffers
//
//  Created by Ivaylo Todorov on 12.06.18.
//  Copyright © 2018 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"

@interface ProfileVC : ViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UILabel *firstnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *pictureLabel;

@property (nonatomic,strong) NSString* firstname;
@property (nonatomic,strong) NSString* lastname;
@property (nonatomic,strong) NSString* email;
@property (nonatomic,strong) NSString* picture;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *logOutButton;

//@property (nonatomic, strong) NSUserDefaults* defaults;
@property (weak, nonatomic) IBOutlet UITableView *tableViewOutlet;
@property (nonatomic, strong) NSArray* myOffers;


@end


