//
//  Rss.h
//  Test
//
//  Created by Luis Gómez on 4/8/15.
//  Copyright (c) 2015 Luis Gómez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rss : NSObject
@property (nonatomic) NSString *rssTitle;
@property (nonatomic) NSString *rssDescription;
@property (nonatomic) NSString *rssUrl;
-(id) initWithTitle:(NSString*)title andDescription:(NSString*) description andUrl:(NSString*) url;
@end
