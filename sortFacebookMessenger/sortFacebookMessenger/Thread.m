//
//  Thread.m
//  sortFacebookMessenger
//
//  Created by Christopher Loessl on 09/06/15.
//  Copyright (c) 2015 Christopher Loessl. All rights reserved.
//

#import "Thread.h"

@implementation Thread

- (id)initWithMessages:(NSArray *)messages
{
    self = [self init];
    if (self) {
        _messages = messages;
    }
    
    return self;
}

@end
