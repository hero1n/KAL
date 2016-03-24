//
//  Room.h
//  KAL
//
//  Created by 노재원 on 2015. 12. 20..
//  Copyright © 2015년 heroin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Room : NSObject

@property (strong, nonatomic) NSString *soundURL;
@property (strong, nonatomic) NSString *photoURL;
@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *idx;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *title;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (NSMutableArray *)roomsWithResponseObject:(NSDictionary *)responseObject;
@end
