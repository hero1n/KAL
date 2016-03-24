//
//  PageContentViewController.h
//  KAL
//
//  Created by 노재원 on 2015. 12. 19..
//  Copyright © 2015년 heroin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIButton *button;

@property NSUInteger pageIndex;
@property NSString *imageFile;


@end
