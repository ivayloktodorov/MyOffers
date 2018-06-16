//
//  AlertView.m
//  MyOffers
//
//  Created by Ivaylo Todorov on 12.06.18.
//  Copyright © 2018 Ivaylo Todorov. All rights reserved.
//

#import "AlertView.h"
#import "ViewController.h"

@implementation AlertView

+(void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message controller:(UIViewController*)controller {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okButton];
    [controller presentViewController:alert animated:NO completion:nil];
}

@end
