//
//  AddAlarmViewController.m
//  KAL
//
//  Created by 노재원 on 2015. 12. 20..
//  Copyright © 2015년 heroin. All rights reserved.
//

#import "AddAlarmViewController.h"
#import "NSDate+ZRExtension.h"
#import <ActionSheetPicker-3.0/ActionSheetPicker.h>
#import "AFNetworking.h"

@interface AddAlarmViewController (){
    BOOL isMon,isTue,isWed,isThu,isFri,isSat,isSun;
    BOOL isRecord,isPlaying;
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}

@end

@implementation AddAlarmViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        isMon = NO;
        isTue = NO;
        isWed = isThu = isFri = isSat = isSun = NO;
        isRecord = NO;
        isPlaying = NO;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"완료" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    [self.mon setBackgroundImage:[UIImage imageNamed:@"mon.png"] forState:UIControlStateNormal];
    
    [self.tue setBackgroundImage:[UIImage imageNamed:@"tue.png"] forState:UIControlStateNormal];
    
    [self.wed setBackgroundImage:[UIImage imageNamed:@"wed.png"] forState:UIControlStateNormal];
    
    [self.thu setBackgroundImage:[UIImage imageNamed:@"thu.png"] forState:UIControlStateNormal];
    
    [self.fri setBackgroundImage:[UIImage imageNamed:@"fri.png"] forState:UIControlStateNormal];
    
    [self.sat setBackgroundImage:[UIImage imageNamed:@"sat.png"] forState:UIControlStateNormal];
    
    [self.sun setBackgroundImage:[UIImage imageNamed:@"sun.png"] forState:UIControlStateNormal];
    
    // Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"sound.m4a",
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    NSLog(@"%@",outputFileURL);
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
}

- (void)done:(id)sender{
    NSString *string = self.titleTextfield.text;
    NSData *imageData = UIImagePNGRepresentation(_image);
    NSString *time = _time;
    NSString *dayArray = [NSString stringWithFormat:@"[%hhd,%hhd,%hhd,%hhd,%hhd,%hhd,%hhd]",isMon,isTue,isWed,isThu,isFri,isSat,isSun];
    NSData *audioData = _audioData;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *param = @{@"title" : string,
                            @"time" :time,
                            @"day" : dayArray
                            };
    
    [manager POST:@"http://dev.mozzet.com/sites/hyeonsu/kal/room/10" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        [formData appendPartWithFileData:imageData name:@"photo" fileName:@"photo.png" mimeType:@"image/png"];
        [formData appendPartWithFileData:audioData name:@"sound" fileName:@"sound.m4a" mimeType:@"audio/mp4"];
    }success:^(AFHTTPRequestOperation *operation, id responseObject){
        [self dismissViewControllerAnimated:YES completion:nil];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"시발 에러 %ld,%@", operation.response.statusCode,operation.responseString
              );
    }];
}

- (IBAction)imagePick:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePicker setAllowsEditing:YES];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    _image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.imageButton setBackgroundImage:_image forState:UIControlStateNormal];
    
    NSLog(@"%@",_image);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pickTime:(id)sender {
    [self.titleTextfield endEditing:YES];
    [ActionSheetDatePicker showPickerWithTitle:@"시간 선택"
                                datePickerMode:UIDatePickerModeTime
                                  selectedDate:[NSDate date]
                                     doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin){
                                         NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
                                         [dateFormater setDateFormat:@"HH:mm"];
                                         
                                         _time = [dateFormater stringFromDate:selectedDate];
                                         _timeLabel.text = _time;
                                        }
                                   cancelBlock:^(ActionSheetDatePicker *picker){
                                       NSLog(@"실패얌 시발");
                                        }
                                        origin:sender];
}

- (IBAction)dayClicked:(id)sender {
    [self.titleTextfield endEditing:YES];
    UIButton *button = sender;
    NSArray *day = @[@"mon.png",@"tue.png",@"wed.png",@"thu.png",@"fri.png",@"sat.png",@"sun.png"];
    NSArray *daySel = @[@"mon_sel.png",@"tue_sel.png",@"wed_sel.png",@"thu_sel.png",@"fri_sel.png",@"sat_sel.png",@"sun_sel.png"];
    
    NSInteger arrayTag = button.tag-1;
    NSLog(@"%d",button.tag);
    switch (button.tag) {
        case 1:
            [self.mon setBackgroundImage: [UIImage imageNamed:!isMon ? daySel[arrayTag] : day[arrayTag]] forState:UIControlStateNormal];
            if(isMon){
                isMon=NO;
            }else{
                isMon=YES;
            }
            break;
        case 2:
            [self.tue setBackgroundImage: [UIImage imageNamed:!isTue ? daySel[arrayTag] : day[arrayTag]] forState:UIControlStateNormal];
            if(isTue){
                isTue=NO;
            }else{
                isTue=YES;
            }

            break;

        case 3:
            [self.wed setBackgroundImage: [UIImage imageNamed:!isWed ? daySel[arrayTag] : day[arrayTag]] forState:UIControlStateNormal];
            if(isWed){
                isWed=NO;
            }else{
                isWed=YES;
            }
            break;

        case 4:
            [self.thu setBackgroundImage: [UIImage imageNamed:!isThu ? daySel[arrayTag] : day[arrayTag]] forState:UIControlStateNormal];
            if(isThu){
                isThu=NO;
            }else{
                isThu=YES;
            }

            break;

        case 5:
            [self.fri setBackgroundImage: [UIImage imageNamed:!isFri ? daySel[arrayTag] : day[arrayTag]] forState:UIControlStateNormal];
            if(isFri){
                isFri=NO;
            }else{
                isFri=YES;
            }

            break;

        case 6:
            [self.sat setBackgroundImage: [UIImage imageNamed:!isSat ? daySel[arrayTag] : day[arrayTag]] forState:UIControlStateNormal];
            if(isSat){
                isSat=NO;
            }else{
                isSat=YES;
            }

            break;

        case 7:
            [self.sun setBackgroundImage: [UIImage imageNamed:!isSun ? daySel[arrayTag] : day[arrayTag]] forState:UIControlStateNormal];
            if(isSun){
                isSun=NO;
            }else{
                isSun=YES;
            }

            break;

            
        default:
            break;
    }
}

- (IBAction)record:(id)sender {
    // Stop the audio player before recording
    if (player.playing) {
        [player stop];
    }
    
    if (!recorder.recording && !isPlaying) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [recorder record];
        isRecord = YES;
        [_recordButton setBackgroundImage:[UIImage imageNamed:@"rec_stop.png"] forState:UIControlStateNormal];
    }
    
    else if(isRecord){
        [recorder stop];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
    }
    if(isPlaying){
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self];
        [player play];
    }
}

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    [_recordButton setBackgroundImage:[UIImage imageNamed:@"rec_play.png"] forState:UIControlStateNormal];
    isRecord = NO;
    isPlaying = YES;
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Done"
                                                    message: @"녹음 완료"
                                                   delegate: nil
                                          cancelButtonTitle:@"확인"
                                          otherButtonTitles:nil];
    [alert show];
    isRecord = NO;
//    isPlaying = NO;
//    [_recordButton setBackgroundImage:[UIImage imageNamed:@"rec.png"] forState:UIControlStateNormal];
    
    NSData *data = [NSData dataWithContentsOfURL:recorder.url];
    NSData *d = [NSData dataWithData:data];
    _audioData = d;
}



//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 5;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    NSString *string = @" ";
//    return string;
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
//    view.tintColor = [UIColor clearColor];
//    
//    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
//    [footer.textLabel setTextColor:[UIColor blackColor]];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
