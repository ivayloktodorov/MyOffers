//
//  DetailOfferVC.h
//  MyOffers
//
//  Created by Ivaylo Todorov on 12.06.18.
//  Copyright © 2018 Ivaylo Todorov. All rights reserved.
//

#import "ViewController.h"

@interface DetailOfferVC : ViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellerLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *expDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic,strong) NSString* titleStr;
@property (nonatomic,strong) NSString* subTitleStr;
@property (nonatomic,strong) NSNumber* price;
@property (nonatomic,strong) NSString* sellerIDStr;
@property (nonatomic,strong) NSString* locationStr;
@property (nonatomic,strong) NSDate* dateCreted;
@property (nonatomic,strong) NSDate* dateExp;


@end
