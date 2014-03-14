//
//  SCHttpRequest.h
//  ServerCheck
//
//  Created by Shuang on 14-3-14.
//  Copyright (c) 2014年 Shuang. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface SCHttpRequest : NSObject{

}


@property(nonatomic,copy)void (^successBlock)(NSString *rString);
@property(nonatomic,copy)void (^failBlock)();

+(id)requestWithUrl:(NSString *)urlstring Success:(void(^)(NSString *rString))sblock Fail:(void(^)())fblock;
+(id)requestWithUrl:(NSString *)urlstring Success:(void(^)(NSString *rString))sblock;


@end



