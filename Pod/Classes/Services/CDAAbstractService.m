/*
 
 Copyright (c) 2015 Code d'Azur <info@codedazur.nl>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

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
