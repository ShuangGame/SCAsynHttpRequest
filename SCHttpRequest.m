//
//  SCHttpRequest.m
//  ServerCheck
//
//  Created by Shuang on 14-3-14.
//  Copyright (c) 2014年 Shuang. All rights reserved.
//

#import "SCHttpRequest.h"


#if __has_feature(objc_arc)
#define SCAutoRelease(x) (x)
#else
#define SCAutoRelease(x) [(x) autorelease]
#endif

@implementation SCHttpRequest
+(id)requestWithUrl:(NSString *)urlstring Success:(void(^)(NSString *rString))sblock Fail:(void(^)())fblock{
    SCHttpRequest *reque=[[self alloc] initWithUrl:urlstring Success:sblock Fail:fblock];
    return SCAutoRelease(reque);
}

+(id)requestWithUrl:(NSString *)urlstring Success:(void(^)(NSString *rString))sblock{
    SCHttpRequest *reque=[[self alloc] initWithUrl:urlstring Success:sblock Fail:nil];
    return SCAutoRelease(reque);
}



-(id)initWithUrl:(NSString *)urlstring Success:(void(^)(NSString *rString))sblock Fail:(void(^)())fblock{
    self=[super init];
    if (self) {
        self.successBlock=sblock;
        self.failBlock=fblock;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                   NSLog(@"code %d",[httpResponse statusCode] );
                                   if ([data length] >0 && error == nil && [httpResponse statusCode] == 200)
                                   {
                                       NSString *astr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                       self.successBlock(SCAutoRelease(astr));   
                                   }else{
                                       if (self.failBlock!=nil) {
                                           self.failBlock();
                                       }
                                   }
                               }];


    }
    return self;
}


#if __has_feature(objc_arc)
#else
-(void)dealloc{
    [_successBlock release];
    [_failBlock release];
    [super dealloc];
}
#endif

@end
