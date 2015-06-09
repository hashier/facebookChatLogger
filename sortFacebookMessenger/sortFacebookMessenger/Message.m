//
//  Message.m
//  sortFacebookMessenger
//
//  Created by Christopher Loessl on 09/06/15.
//  Copyright (c) 2015 Christopher Loessl. All rights reserved.
//

#import "Message.h"

@implementation Message

- (instancetype)initWithSender:(NSString *)sender date:(NSDate *)date andMessage:(NSString *)message
{
    if (!sender || !date || !message) {
        NSLog(@"All ivars must be set to init obj");
        return nil;
    }
    
    self = [self init];
    if (self) {
        _sender = sender;
        _date = date;
        _message = message;
    }
    return self;
}

@end
