//
//  Created by Tamara Bernad on 15/06/15.
//  Copyright (c) 2015 Code d'Azur. All rights reserved.
//

#import "CDAAbstractParser.h"
#import "CDAExceptionUtils.h"
@interface CDAAbstractParser()
@end
@implementation CDAAbstractParser
@synthesize progress = _progress;
- (id)processRecord:(NSDictionary *)record{
    [CDAExceptionUtils throwOverrideExceptionWithMethodName:NSStringFromSelector(_cmd)];
    return nil;
}
- (void)processWithData:(id)data AndCompletion:(void (^)(id))completion{
    _progress = 0.0;
    int index = 0;
    NSMutableArray *items = [NSMutableArray new];
    for (NSDictionary *sRecord in data) {
        [items addObject:[self processRecord:sRecord]];
        index++;
        _progress = (float)index/(float)((NSArray *)data).count;
    }
    completion(items);
}
@end
