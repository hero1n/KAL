//
//  AddAlarmViewController.h
//  KAL
//
//  Created by 노재원 on 2015. 12. 20..
//  Copyright © 2015년 heroin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AddAlarmViewController : UITableViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (strong, nonatomic) IBOutlet UITextField *titleTextfield;

@property (strong, nonatomic) IBOutlet UIButton *imageButton;
- (IBAction)imagePick:(id)sender;
@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) IBOutlet UIButton *timePicker;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) NSString *time;




@property (strong, nonatomic) IBOutlet UIButton *mon;
@property (strong, nonatomic) IBOutlet UIButton *thu;
@property (strong, nonatomic) IBOutlet UIButton *fri;
@property (strong, nonatomic) IBOutlet UIButton *sat;
@property (strong, nonatomic) IBOutlet UIButton *sun;
@property (strong, nonatomic) IBOutlet UIButton *tue;
@property (strong, nonatomic) IBOutlet UIButton *wed;

- (IBAction)dayClicked:(id)sender;


@property (strong, nonatomic) IBOutlet UIImageView *photoButton;
- (IBAction)pickTime:(id)sender;


@property (strong, nonatomic) NSData *audioData;
@property (strong, nonatomic) IBOutlet UIButton *recordButton;
- (IBAction)record:(id)sender;

@end
