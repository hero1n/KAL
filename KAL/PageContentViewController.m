//
//  PageContentViewController.m
//  KAL
//
//  Created by 노재원 on 2015. 12. 19..
//  Copyright © 2015년 heroin. All rights reserved.
//

#import "PageContentViewController.h"
#import "MainCardViewController.h"
//#import "KeychainItemWrapper.h"
#import <Toast/UIView+Toast.h>

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    
    self.textField.hidden = YES;
    self.button.hidden = YES;
    
    if(_pageIndex == 3){
        self.textField.hidden = NO;
        self.button.hidden = NO;
        
        [self.button addTarget:self action:@selector(nextViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//- (NSString*) getUUID
//{
//    // initialize keychaing item for saving UUID.
//    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID" accessGroup:nil];
//    
//    NSString *uuid = [wrapper objectForKey:(__bridge id)(kSecAttrAccount)];
//    
//    if( uuid == nil || uuid.length == 0)
//    {
//        // if there is not UUID in keychain, make UUID and save it.
//        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
//        CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
//        CFRelease(uuidRef);
//        uuid = [NSString stringWithString:(__bridge NSString *) uuidStringRef];
//        CFRelease(uuidStringRef);
//        
//        // save UUID in keychain
//        [wrapper setObject:uuid forKey:(__bridge id)(kSecAttrAccount)];
//    }
//    
//    return uuid;
//}

- (void)nextViewController:(id)sender{
    if (self.textField.text.length < 3){
        [self.view makeToast:@"닉네임이 너무 짧습니다. (3자)" duration:1.5f position:CSToastPositionCenter];
        return;
    }else if(self.textField.text.length > 20){
        [self.view makeToast:@"닉네임이 너무 깁니다. (20자)" duration:1.5f position:CSToastPositionCenter];
        return;
    }
    if([[NSUserDefaults standardUserDefaults] stringForKey: @"uuid"] == NULL){
        
        CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
        
//        NSString *string = (NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
        
//        [[NSUserDefaults standardUserDefaults] setObject:string forKey: @"uuid"];
        
    }
    
    NSString *uniqueid = [[NSUserDefaults standardUserDefaults] stringForKey: @"uuid"];
    
    NSLog(@"uuid : %@", uniqueid);

    MainCardViewController *nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainCardNavigationController"];
    [self presentViewController:nextView animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self nextViewController:self];
    return NO;
}


@end
