//
//  MainCardCell.h
//  KAL
//
//  Created by 노재원 on 2015. 12. 19..
//  Copyright © 2015년 heroin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface MainCardCell : UITableViewCell

@property (nonatomic) id data;
@property (strong, nonatomic) IBOutlet UIView *realContentView;
@property (strong, nonatomic) IBOutlet UIButton *mon;
@property (strong, nonatomic) IBOutlet UIButton *tue;
@property (strong, nonatomic) IBOutlet UIButton *wed;
@property (strong, nonatomic) IBOutlet UIButton *thu;
@property (strong, nonatomic) IBOutlet UIButton *fri;
@property (strong, nonatomic) IBOutlet UIButton *sat;
@property (strong, nonatomic) IBOutlet UIButton *sun;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *codeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@end
