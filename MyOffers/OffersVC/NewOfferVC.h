//
//  NewOfferVC.h
//  MyOffers
//
//  Created by Ivaylo Todorov on 12.06.18.
//  Copyright © 2018 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"

@interface NewOfferVC : ViewController
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *subtitleField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet UITextField *dateExpField;

@end
