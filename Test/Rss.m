//
//  Rss.m
//  Test
//
//  Created by Luis Gómez on 4/8/15.
//  Copyright (c) 2015 Luis Gómez. All rights reserved.
//

#import "Rss.h"

@implementation Rss
-(id) initWithTitle:(NSString*)title andDescription:(NSString*) description andUrl:(NSString*) url{
    if ((self = [super init])) {
        self.rssTitle = title;
        self.rssDescription = description;
        self.rssUrl=url;
    }
    return self;
}

@end
