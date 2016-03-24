//
//  Room.m
//  KAL
//
//  Created by 노재원 on 2015. 12. 20..
//  Copyright © 2015년 heroin. All rights reserved.
//

#import "Room.h"

@implementation Room

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _soundURL = dictionary[@"sound"];
        _photoURL = dictionary[@"photo"];
        _day = dictionary[@"day"];
        _code = dictionary[@"code"];
        _idx = dictionary[@"idx"];
        _time = dictionary[@"time"];
        _title = dictionary[@"title"];
    }
    
    return self;
}

+ (NSMutableArray *)roomsWithResponseObject:(NSDictionary *)responseObject{
    NSMutableArray *returnArray = [NSMutableArray array];
    if(!responseObject){
        return returnArray;
    }
    for(NSDictionary *dictionary in responseObject[@"rooms"]){
        Room *room = [[Room alloc] initWithDictionary:dictionary];
        [returnArray addObject:room];
    }
    
    return returnArray;
}

@end
