//
//  Created by Tamara Bernad on 15/06/15.
//  Copyright (c) 2015 Code d'Azur. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CDADataProcessorProtocol <NSObject>
@required
@property (nonatomic, readonly) double progress;
- (void)processWithData:(id)data AndCompletion:(void (^)(id))completion;
@end

