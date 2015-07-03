//
//  main.m
//  sortFacebookMessenger
//
//  Created by Christopher Loessl on 02/06/15.
//  Copyright (c) 2015 Christopher Loessl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TFHpple.h"

@implementation NSString (Extensions)
- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *xPath = @"//div[@class='thread']";
        NSData *file;
        
        file = [NSData dataWithContentsOfFile:@"/Users/chl/Downloads/facebook-christopherloessl/html/messages.htm"];
//        file = [NSData dataWithContentsOfFile:@"/Users/chl/Desktop/test.html"];
//        file = [NSData dataWithContentsOfFile:@"/Users/chl/Desktop/test2.html"];
        file = [NSData dataWithContentsOfFile:@"/Users/chl/Desktop/test3.html"];
        

        TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:file];

        NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:xPath];
        
        
        for (TFHppleElement *element in tutorialsNodes) { // All threads
            NSLog(@"Thread: %@", [[element text] trim]); // User A with user B
            NSArray *messagesArray = [element childrenWithClassName:@"message"]; // all meta information between two user
            NSArray *messagesText  = [element childrenWithTagName:@"p"]; // all messages between two users
            
            [messagesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                TFHppleElement *header = [obj firstChildWithClassName:@"message_header"];
                NSString *aUser = [[header firstChildWithClassName:@"user"] text];
                NSString *aDateString = [[header firstChildWithClassName:@"meta"] text];
                NSString *aMessage = [messagesText[idx] text];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"EEEE, MMMM d, yyyy 'at' h:mma 'UTC'Z"];
                NSDate *aDate = [dateFormatter dateFromString:aDateString];
                [dateFormatter setLocalizedDateFormatFromTemplate:@"yyMMddhhmm"];
                NSLog(@"User: %@ says at %@", aUser, [dateFormatter stringFromDate:aDate]);
                NSLog(@"-> %@", aMessage);
            }];
            NSLog(@"\n");
        }
        
        
        
    }
    return 0;
}
