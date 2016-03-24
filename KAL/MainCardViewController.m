//
//  MainCardViewController.m
//  KAL
//
//  Created by 노재원 on 2015. 12. 19..
//  Copyright © 2015년 heroin. All rights reserved.
//

#import "MainCardViewController.h"
#import "MainCardCell.h"
#import "AFNetworking.h"
#import "Room.h"

@interface MainCardViewController ()

@end

@implementation MainCardViewController

@synthesize user_idx;

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        self.dataArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"입력" style:UIBarButtonItemStylePlain   target:self action:@selector(typeCode:)];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    user_idx = 10;
    
    NSDictionary *param = @{@"user_idx" : @"10"
                            };
    
    NSMutableString *URL = @"http://dev.mozzet.com/sites/hyeonsu/kal/rooms/".mutableCopy;
    [URL appendFormat:@"%d",user_idx];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"%@",operation.responseString);
        NSData *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:nil];
        NSLog(@"%@",jsonResponse);
        self.dataArray = [Room roomsWithResponseObject:jsonResponse];
        dispatch_async(dispatch_get_main_queue(), ^(){
           [self.tableView reloadData];
        });
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@",error);
    }];
}

#pragma mark - Action

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (void)typeCode:(id)sender{
    
}

- (void)addAlarm:(id)sender{
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddAlarmViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([self.dataArray count] == 0){
        return 1;
    }
    return [self.dataArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCardCell" forIndexPath:indexPath];
    
    UIButton *view = [cell.contentView viewWithTag:-1];
    [view removeFromSuperview];

    if(indexPath.row == [self.tableView numberOfRowsInSection:indexPath.section]-1){
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, cell.contentView.frame.size.width - 20, cell.contentView.frame.size.height - 10)];
        [button setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(addAlarm:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = -1;
        
        [cell.contentView addSubview:button];
    }
    else{
        Room *room = self.dataArray[indexPath.row];
        [cell setData:room];
    }
    
    return cell;
}

 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
     // Return NO if you do not want the specified item to be editable.
     if(indexPath.row == [self.tableView numberOfRowsInSection:indexPath.section]-1){
         return NO;
     }
     return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 데이터 소스에서 해당 항목 삭제
        if([self.dataArray count]){
            Room *room = self.dataArray[indexPath.row];
            [self.dataArray removeObjectAtIndex:indexPath.row];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            NSMutableString *URL = @"http://dev.mozzet.com/sites/hyeonsu/kal/delete_room/".mutableCopy;
            [URL appendFormat:@"%@",room.idx];

            [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
                NSLog(@"%@ %d",operation.responseString,__LINE__);
            }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                NSLog(@"%@",error);
                NSLog(@"%@",operation.responseString);
            }];
        }
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if( editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

@end
