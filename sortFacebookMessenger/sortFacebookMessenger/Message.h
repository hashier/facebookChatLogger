//
//  Message.h
//  sortFacebookMessenger
//
//  Created by Christopher Loessl on 09/06/15.
//  Copyright (c) 2015 Christopher Loessl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property NSString *sender;
@property NSDate *date;
@property NSString *message;

- (instancetype)initWithSender:(NSString *)sender date:(NSDate *)date andMessage:(NSString *)message;

@end
