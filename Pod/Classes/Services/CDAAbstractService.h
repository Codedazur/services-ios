//
//  Created by Tamara Bernad on 15/06/15.
//  Copyright (c) 2015 Code d'Azur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDAService.h"
#import "CDAConnector.h"

@interface CDAAbstractService : NSObject<CDAService>
-  (instancetype)initWithConnector:(id<CDAConnector>)connector;
- (void)listModelObjectsWithCompletion:(void (^)(NSArray *modelObjects))completion failure:(void (^)(NSError *error))failure;
@end