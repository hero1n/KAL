//
//  WalkthroughViewController.h
//  KAL
//
//  Created by 노재원 on 2015. 12. 19..
//  Copyright © 2015년 heroin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface WalkthroughViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) UIPageViewController *pageViewController;



@end
