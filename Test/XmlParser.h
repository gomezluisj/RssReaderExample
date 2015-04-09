//
//  XmlParser.h
//  Test
//
//  Created by Luis Gómez on 4/9/15.
//  Copyright (c) 2015 Luis Gómez. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol XmlParserDelegate;
@interface XmlParser : NSObject <NSXMLParserDelegate>
@property (nonatomic) NSMutableString *tempTitle;
@property (nonatomic) NSMutableString *tempLink;
@property (nonatomic) NSMutableString *tempDescription;
@property (nonatomic) NSString *element;
@property (nonatomic) NSMutableArray *rssArray;
@property (nonatomic, weak) id <XmlParserDelegate> delegate;
-(void) getRssFromServer;

@end

@protocol XmlParserDelegate <NSObject>
-(void) xmlParserDidFinished:(NSMutableArray *) resultParsed;

@end
