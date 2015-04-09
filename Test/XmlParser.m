//
//  XmlParser.m
//  Test
//
//  Created by Luis Gómez on 4/9/15.
//  Copyright (c) 2015 Luis Gómez. All rights reserved.
//

#import "XmlParser.h"
#import "AFHTTPRequestOperationManager.h"
#import "Rss.h"

@implementation XmlParser

-(void) getRssFromServer{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFXMLParserResponseSerializer new]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/rss+xml"];
    [manager GET:@"http://webassets.scea.com/pscomauth/groups/public/documents/webasset/rss/playstation/Games_PS3.rss" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [responseObject setDelegate:self];
        [responseObject parse];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.rssArray = [[NSMutableArray alloc]init];
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    self.element=elementName;
   
    if ( [elementName isEqualToString:@"item"])
    {
        self.tempTitle   = [[NSMutableString alloc] init];
        self.tempLink    = [[NSMutableString alloc] init];
        self.tempDescription    = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"]) {
        Rss *temp=[[Rss alloc]initWithTitle:self.tempTitle andDescription:[self getFisrtSentenceFrom:self.tempDescription] andUrl:self.tempLink];
        [self.rssArray addObject:temp];
    }
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([self.element isEqualToString:@"title"]) {
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet nonBaseCharacterSet]];
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [self.tempTitle appendString:string];
    } else if ([self.element isEqualToString:@"link"]) {
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet nonBaseCharacterSet]];
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [self.tempLink appendString:string];
    }else if ([self.element isEqualToString:@"description"]) {
        [self.tempDescription appendString:string];
    }
    
}
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    self.tempDescription=nil;
    self.tempLink=nil;
    self.tempTitle=nil;
    [(NSObject *) self.delegate performSelector:@selector(xmlParserDidFinished:) withObject:self.rssArray];
}
-(NSString*) getFisrtSentenceFrom:(NSString*)fullDescription{
    return [[fullDescription componentsSeparatedByString: @"."] objectAtIndex:0];
}
@end
