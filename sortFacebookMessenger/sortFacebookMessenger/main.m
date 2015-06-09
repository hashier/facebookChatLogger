//
//  main.m
//  sortFacebookMessenger
//
//  Created by Christopher Loessl on 02/06/15.
//  Copyright (c) 2015 Christopher Loessl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Ono.h"

#import "TFHpple.h"

@implementation NSString (Extensions)
- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *error;
        NSString *xPath = @"//div[@class='thread']";
        NSData *file;
        __block int i;
        i = 0;
        __block NSString *a = @"", *b = @"";
        ONOXMLDocument *document;
        
        file = [NSData dataWithContentsOfFile:@"/Users/chl/Downloads/facebook-christopherloessl/html/messages.htm"];
//        file = [NSData dataWithContentsOfFile:@"/Users/chl/Desktop/test.html"];
//        file = [NSData dataWithContentsOfFile:@"/Users/chl/Desktop/test2.html"];
        file = [NSData dataWithContentsOfFile:@"/Users/chl/Desktop/test3.html"];
        
        
        document = [ONOXMLDocument XMLDocumentWithData:file error:&error];
        

        for (ONOXMLElement *element in document.rootElement.children) {
            i++;
            NSLog(@"1: %@: %@", element.tag, element.attributes);
        }
//        NSLog(@"End: %d", i);
        
        ONOXMLElement *tmp = [document.rootElement firstChildWithTag:@"thread"];
        i = 0;
        for (ONOXMLElement *element in tmp.children) {
            i++;
//            NSLog(@"%@: %@", element.tag, element.attributes);
        }
//        NSLog(@"End: %d", i);
        
        __block NSMutableString *tmpString = [NSMutableString new];
        NSLog(@"hashier: time 0");
//        NSLog(@"XPath Search: %@", XPath);
        [document enumerateElementsWithXPath:xPath usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
//            NSLog(@"%@", [element stringValue]);
            [tmpString appendString:[element stringValue]];
            //*stop = idx < 3;
            i++;
        }];
        NSLog(@"entries: = %d and length = %lu", i, tmpString.length);
        
        [document enumerateElementsWithXPath:xPath usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
            NSLog(@"\n%@", [element stringValue]);
            a = [a stringByAppendingString:[element stringValue]];
        }];
        
        NSLog(@"hashier: time 1");
        TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:file];
        NSLog(@"hashier: time 2");
        NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:xPath];
        NSLog(@"hashier: time 3");
        
        for (TFHppleElement *element in tutorialsNodes) {
//            NSLog(@"%@", [[element firstChild] content].trim);
        }
        NSLog(@"elements: %lu", tutorialsNodes.count);
        
        
        putchar('\n');
        putchar('\n');
        putchar('\n');
        putchar('\n');
        putchar('\n');

        
        file = [NSData dataWithContentsOfFile:@"/Users/chl/Desktop/test3.html"];
        
        NSLog(@"XPathQuery: %@", xPath);
        
        
        NSLog(@"\n\n\nhpple\n\n\n");

        tutorialsParser = [TFHpple hppleWithHTMLData:file];
        tutorialsNodes = [tutorialsParser searchWithXPathQuery:xPath];
        
        for (TFHppleElement *element in tutorialsNodes) {
            NSLog(@"%@", [[element firstChild] content].trim);
        }
        
        
        NSLog(@"\n\n\nOno\n\n\n");
        
        document = [ONOXMLDocument HTMLDocumentWithData:file error:&error];
        
        [document enumerateElementsWithXPath:xPath usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
            NSLog(@"\n%@", [element stringValue]);
            b = [b stringByAppendingString:[element stringValue]];
        }];
        
        if ([a isEqualToString:b])
            NSLog(@"same");
        else
            NSLog(@"not same");
        
        
        
    }
    return 0;
}
