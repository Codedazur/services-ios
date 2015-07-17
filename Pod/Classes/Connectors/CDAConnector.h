//
//  Created by Tamara Bernad on 15/06/15.
//  Copyright (c) 2015 Code d'Azur. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CDAConnector <NSObject>
@property (nonatomic, strong) NSDictionary *httpHeaders;
- (void)postWithUrlString:(NSString *)urlString
                     Data:(NSDictionary *)data
         AndMultipartData:(NSArray *)multipartDatas
              WithSuccess:(void (^)(id))success
                  failure:(void (^)(NSError *))failure;

- (void) requestWithUrlString:(NSString *)urlString
                  WithSuccess:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

- (void) postWithUrlString:(NSString *)urlString Data:(NSDictionary *)data
               WithSuccess:(void (^)(id))success
                   failure:(void (^)(NSError *))failure;
@end
