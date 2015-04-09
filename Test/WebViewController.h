//
//  WebViewController.h
//  Test
//
//  Created by Luis Gómez on 4/8/15.
//  Copyright (c) 2015 Luis Gómez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>
@property (nonatomic) NSString *url;
@end
