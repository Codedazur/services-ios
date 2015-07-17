//
//  Created by Tamara Bernad on 15/06/15.
//  Copyright (c) 2015 Code d'Azur. All rights reserved.
//

#import "CDAAFHttpConnector.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

@implementation CDAAFHttpConnector
@synthesize httpHeaders = _httpHeaders;

- (void)postWithUrlString:(NSString *)urlString Data:(NSDictionary *)data AndMultipartData:(NSArray *)multipartDatas WithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [self serializer];
    
    [manager POST:urlString parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSDictionary *multipartData in multipartDatas) {
            [formData appendPartWithFileData:[multipartData valueForKey:@"data"]
                                        name:[multipartData valueForKey:@"name"]
                                    fileName:[multipartData valueForKey:@"fileName"]
                                    mimeType:[multipartData valueForKey:@"mimeType"]];
        }
        

    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)postWithUrlString:(NSString *)urlString Data:(NSDictionary *)data WithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [self serializer];
    
    [manager POST:urlString parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
}
- (void)requestWithUrlString:(NSString *)urlString WithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [self setAdditionalHeaders:serializer];
    manager.requestSerializer = serializer;
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
- (AFJSONRequestSerializer *)serializer{
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self setAdditionalHeaders:serializer];
    return serializer;
}
- (void)setAdditionalHeaders:(AFJSONRequestSerializer *)serializer{
    for (NSString *headerField in self.httpHeaders) {
        [serializer setValue:[self.httpHeaders valueForKey:headerField] forHTTPHeaderField:headerField];
    }
}
- (AFHTTPRequestOperation *) createOperationWithUrlString:(NSString *)urlString{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    return operation;
}
@end
