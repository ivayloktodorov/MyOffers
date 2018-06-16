//
//  NewOfferVC.m
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
#import <Parse.h>

@interface NewOfferVC ()

@end

@implementation NewOfferVC

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self textFieldDidBeginEditing:_priceField];
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.defaultsEmail = [self.defaults stringForKey:@"defaultsEmail"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveButtonPress:(id)sender {
    
    PFObject* offers = [PFObject objectWithClassName:@"Offer"];
    
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *price = [format numberFromString:_priceField.text];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [dateFormatter dateFromString:_dateExpField.text];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [calendar dateByAddingUnit:NSCalendarUnitMonth value:0 toDate:[NSDate date] options:0];
    NSDate *expDateCheck = [calendar dateByAddingUnit:NSCalendarUnitMonth value:6 toDate:[NSDate date] options:0];
    NSComparisonResult result;
    result = [expDateCheck compare:now];
    
    if ([_titleField.text isEqualToString:@""] || [_priceField.text isEqualToString:@""] || [_locationField.text isEqualToString:@""] || [_dateExpField.text isEqualToString:@""]) {
        [AlertView showAlertViewWithTitle:@"Error" message:@"Please type any *REQUIRED fields!" controller:self];
        return;
    }
    else {
        offers[@"title"] = _titleField.text;
        offers[@"price"] = price;
        offers[@"image"] = @"z";
        offers[@"sellerID"] = self.defaultsEmail;
        offers[@"location"] = _locationField.text;
    }
    if ([dateFromString timeIntervalSinceDate:expDateCheck] < 0){
        if ([dateFromString timeIntervalSinceDate:now] >= 0) {
            offers[@"expDate"] = dateFromString;
            offers[@"subtitle"] = _subtitleField.text;
            offers[@"description"] = _descriptionField.text;
            [offers saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    UIAlertController* newOfferSavedAlert = [UIAlertController alertControllerWithTitle:@"Successful" message:@"Do you wanna create a new Offer?" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* New = [UIAlertAction actionWithTitle:@"Create new Offer" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        self.titleField.text = @"";
                        self.subtitleField.text = @"";
                        self.priceField.text = @"";
                        self.locationField.text = @"";
                        self.dateExpField.text = @"";
                    }];
                    UIAlertAction* goBack = [UIAlertAction actionWithTitle:@"Go to All Offers" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self goToAllOffersVC];
                    }];
                    [newOfferSavedAlert addAction:goBack];
                    [newOfferSavedAlert addAction:New];
                    [self presentViewController:newOfferSavedAlert animated:YES completion:nil];
                    NSLog(@"OK sme");
                } else {
                }
            }];
        }
        else {
                [AlertView showAlertViewWithTitle:@"Error" message:@"Exp.Date cannot be less then today." controller:self];
                return;
        }
    }
}

//-(void)afasf{
//    if ([dateFromString timeIntervalSinceDate:expDateCheck] > 6) {
//        NSLog(@"poveche");
//        [AlertView showAlertViewWithTitle:@"Error" message:@"Exp.Date cannot be more then 6 months after creation." controller:self];
//        return;
//    }
//    else {
//        [AlertView showAlertViewWithTitle:@"Error" message:@"Exp.Date cannot be less then today." controller:self];
//        return;
//    }
//}
//}

//}

- (IBAction)backButtonPress:(id)sender {
    [self goToAllOffersVC];
}

-(void)goToAllOffersVC{
    UIStoryboard *VC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OffersViewController* goToSignUpVC = [VC instantiateViewControllerWithIdentifier:@"OffersTableVCid"];
    [self presentViewController:goToSignUpVC animated:true completion:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.priceField.text = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
}


@end
