//
//  MainCardCell.m
//  KAL
//
//  Created by 노재원 on 2015. 12. 19..
//  Copyright © 2015년 heroin. All rights reserved.
//

#import "MainCardCell.h"

@interface MainCardCell (){
    BOOL isMon,isTue,isWed,isThu,isFri,isSat,isSun;
}

@end

@implementation MainCardCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        isMon = NO;
        isTue = NO;
        isWed = isThu = isFri = isSat = isSun = NO;
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(id)data{
    Room *room = data;
    
    [self.mon setBackgroundImage:[UIImage imageNamed:@"mon.png"] forState:UIControlStateNormal];
    
    [self.tue setBackgroundImage:[UIImage imageNamed:@"tue.png"] forState:UIControlStateNormal];
    
    [self.wed setBackgroundImage:[UIImage imageNamed:@"wed.png"] forState:UIControlStateNormal];
    
    [self.thu setBackgroundImage:[UIImage imageNamed:@"thu.png"] forState:UIControlStateNormal];
    
    [self.fri setBackgroundImage:[UIImage imageNamed:@"fri.png"] forState:UIControlStateNormal];
    
    [self.sat setBackgroundImage:[UIImage imageNamed:@"sat.png"] forState:UIControlStateNormal];
    
    [self.sun setBackgroundImage:[UIImage imageNamed:@"sun.png"] forState:UIControlStateNormal];
    
    if(!room){
        return;
    }
    
    NSData *photoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:room.photoURL]];
    UIImage *image = [UIImage imageWithData:photoData];
    
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.clipsToBounds = YES;
    self.imgView.image = image;
    
    NSString *subString = [room.day substringFromIndex:1];
    subString = [subString substringToIndex:subString.length-1];
    NSArray *sepArray = [subString componentsSeparatedByString:@","];
    NSLog(@"%@",sepArray);
    
    for(NSInteger index = 0 ; index < sepArray.count ; index++){
        if([sepArray[index]  isEqualToString:@"1"]){
            switch (index) {
                case 0:
                    [self.mon setBackgroundImage:[UIImage imageNamed:@"mon_sel.png"] forState:UIControlStateNormal];
                    break;
                case 1:
                    [self.tue setBackgroundImage:[UIImage imageNamed:@"tue_sel.png"] forState:UIControlStateNormal];
                    break;
                case 2:
                    [self.wed setBackgroundImage:[UIImage imageNamed:@"wed_sel.png"] forState:UIControlStateNormal];
                    break;
                case 3:
                    [self.thu setBackgroundImage:[UIImage imageNamed:@"thu_sel.png"] forState:UIControlStateNormal];
                    break;
                case 4:
                    [self.fri setBackgroundImage:[UIImage imageNamed:@"fri_sel.png"] forState:UIControlStateNormal];
                    break;
                case 5:
                    [self.sat setBackgroundImage:[UIImage imageNamed:@"sat_sel.png"] forState:UIControlStateNormal];
                    break;
                case 6:
                    [self.sun setBackgroundImage:[UIImage imageNamed:@"sun_sel.png"] forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
        }
    }
    
    self.timeLabel.text = room.time;
    self.codeLabel.text = room.code;
}

@end
