//
//  RssViewController.h
//  Test
//
//  Created by Luis Gómez on 4/8/15.
//  Copyright (c) 2015 Luis Gómez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XmlParser.h"
@interface RssViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,XmlParserDelegate>

@end
