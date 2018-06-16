//
//  ViewController.h
//  MyOffers
//
//  Created by Ivaylo Todorov on 11.06.18.
//  Copyright © 2018 Ivaylo Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (nonatomic, strong) NSUserDefaults* defaults;

@property (nonatomic, strong) NSString* defaultsUser;
@property (nonatomic, strong) NSString* defaultsFirst;
@property (nonatomic, strong) NSString* defaultsLast;
@property (nonatomic, strong) NSString* defaultsEmail;
@property (nonatomic, strong) NSString* defaultsPicture;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@end

