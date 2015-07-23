//
//  main.m
//  sortFacebookMessenger
//
//  Created by Christopher Loessl on 02/06/15.
//  Copyright (c) 2015 Christopher Loessl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TFHpple.h"
#import "Thread.h"
#import "Message.h"

@implementation NSString (Extensions)
- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *xPath = @"//div[@class='thread']";
        NSData *file;
        NSDateFormatter *dateFormatterRead = [[NSDateFormatter alloc] init];
        NSDateFormatter *dateFormatterWrite = [[NSDateFormatter alloc] init];

        [dateFormatterRead setDateFormat:@"EEEE, MMMM d, yyyy 'at' h:mma 'UTC'Z"];
        [dateFormatterWrite setLocalizedDateFormatFromTemplate:@"yyMMddhhmm"];
        
        file = [NSData dataWithContentsOfFile:@"/Users/chl/Downloads/facebook-christopherloessl/html/messages.htm"];
//        file = [NSData dataWithContentsOfFile:@"/Users/chl/Desktop/test.html"];
//        file = [NSData dataWithContentsOfFile:@"/Users/chl/Desktop/test2.html"];
//        file = [NSData dataWithContentsOfFile:@"/Users/chl/Desktop/test3.html"];


        TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:file];

        NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:xPath];

        NSMutableArray *all = [[NSMutableArray alloc] init];
        for (TFHppleElement *element in tutorialsNodes) { // All threads
            Thread *aThread = [[Thread alloc] init];
            aThread.participants = [[element text] trim];
            NSLog(@"Thread: %@", aThread.participants); // User A with user B
            NSMutableArray *allMessagesInConversation = [[NSMutableArray alloc] init];

            NSArray *messagesArray = [element childrenWithClassName:@"message"]; // all meta information between two user
            NSArray *messagesText  = [element childrenWithTagName:@"p"]; // all messages between two users
            NSCAssert((messagesArray.count == messagesText.count), @"Metainformation count != message count");
            [messagesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                TFHppleElement *header = [obj firstChildWithClassName:@"message_header"];
                NSString *aUser = [[header firstChildWithClassName:@"user"] text];
                NSString *aDateString = [[header firstChildWithClassName:@"meta"] text];
                NSString *aMessage = [messagesText[idx] text] ?: @"";
                NSDate *aDate = [dateFormatterRead dateFromString:aDateString];
//                NSLog(@"User: %@ says at %@", aUser, [dateFormatter stringFromDate:aDate]);
//                NSLog(@"-> %@", aMessage);
                Message *theMessage = [[Message alloc] initWithSender:aUser date:aDate andMessage:aMessage];
                [allMessagesInConversation addObject:theMessage];
            }];
//            NSLog(@"\n");
            aThread.messages = [allMessagesInConversation copy];
            [all addObject:aThread];
        }

//        NSLog(@"Everything:\n%@", all);
    }

    return 0;
}
