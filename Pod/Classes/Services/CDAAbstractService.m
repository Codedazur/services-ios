//
//  Created by Tamara Bernad on 15/06/15.
//  Copyright (c) 2015 Code d'Azur. All rights reserved.
//

#import "CDAAbstractService.h"
#import "CDAExceptionUtils.h"
#import "CDAParserProtocol.h"

@interface CDAAbstractService()

@property (nonatomic, strong) id<CDAConnector> connector;

@end

@implementation CDAAbstractService

#pragma mark - life cycle
-  (instancetype)initWithConnector:(id<CDAConnector>)connector{
    if (self = [super init]) {
        self.connector = connector;
    }
    return self;
}
#pragma mark - public
- (void)createMixedMediaObject:(id)object WithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [self.connector postWithUrlString:[self createUrl] Data:[self prepareDataObject:object]
                     AndMultipartData:[self prepareMediaObjects:object]
                          WithSuccess:^(id responseObject) {
                              success(responseObject);
                          } failure:^(NSError *error) {
                              failure(error);
                          }];
}
- (void)createObject:(id)object WithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [self.connector postWithUrlString:[self createUrl] Data:[self prepareDataObject:object] WithSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
- (void)listModelObjectsWithCompletion:(void (^)(NSArray *))completion failure:(void (^)(NSError *))failure{
    [self listObjectsWithSuccess:^(id responseObject) {
        [[self modelParser] processWithData:responseObject AndCompletion:completion];
    } failure:failure];
}
- (void)listObjectsWithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [self.connector requestWithUrlString:[self listUrl] WithSuccess:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
- (void)editObject:(id)object WithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //TODO implement
}
- (void)deleteObject:(id)object WithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //TODO implement
}

#pragma mark - protocol
- (NSString *)baseUrl{
    [CDAExceptionUtils throwOverrideExceptionWithMethodName:NSStringFromSelector(_cmd)];
    return nil;
}
- (NSString *)resource{
    [CDAExceptionUtils throwOverrideExceptionWithMethodName:NSStringFromSelector(_cmd)];
    return nil;
}
- (id)prepareDataObject:(id)object{
    [CDAExceptionUtils throwOverrideExceptionWithMethodName:NSStringFromSelector(_cmd)];
    return nil;
}
- (NSArray *)prepareMediaObjects:(id)object{
    [CDAExceptionUtils throwOverrideExceptionWithMethodName:NSStringFromSelector(_cmd)];
    return nil;
}
- (NSObject<CDAParserProtocol>*)modelParser{
    [CDAExceptionUtils throwOverrideExceptionWithMethodName:NSStringFromSelector(_cmd)];
    return nil;
}
- (NSString *)listUrl{
    return [[self baseUrl] stringByAppendingPathComponent:[self resource]];
}
- (NSString *)createUrl{
    return [self listUrl];
}

@end
