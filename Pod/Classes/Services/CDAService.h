//
//  Created by Tamara Bernad on 15/06/15.
//  Copyright (c) 2015 Code d'Azur. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CDAService <NSObject>
- (NSString *)baseUrl;
- (NSString *)listUrl;
- (NSString *)createUrl;
- (NSString *)resource;

- (void) createMixedMediaObject:(id)object WithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void) createObject:(id)object WithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void) deleteObject:(id)object WithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void) listObjectsWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void) editObject:(id)object WithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end