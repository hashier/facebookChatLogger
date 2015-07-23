//
//  Thread.h
//  sortFacebookMessenger
//
//  Created by Christopher Loessl on 09/06/15.
//  Copyright (c) 2015 Christopher Loessl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Thread : NSObject

@property NSString *participants;
@property (readonly) NSString *participantA;
@property (readonly) NSString *participantB;
@property (readonly) bool groupChat;
@property NSArray *messages;

@end
