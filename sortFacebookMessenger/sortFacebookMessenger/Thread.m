//
//  Thread.m
//  sortFacebookMessenger
//
//  Created by Christopher Loessl on 09/06/15.
//  Copyright (c) 2015 Christopher Loessl. All rights reserved.
//

#import "Thread.h"

@implementation Thread

- (NSString *)description
{
    NSString *description = [NSMutableString stringWithFormat:@"%@", self.messages];

    return description;
}

#pragma mark - Getter / Setter

- (bool)groupChat
{
    return false;
}

- (NSString *)participantA
{
    return nil;
}

- (NSString *)participantB
{
    return nil;
}

@end
