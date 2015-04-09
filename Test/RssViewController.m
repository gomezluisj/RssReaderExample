//
//  RssViewController.m
//  Test
//
//  Created by Luis Gómez on 4/8/15.
//  Copyright (c) 2015 Luis Gómez. All rights reserved.
//

#import "RssViewController.h"
#import "WebViewController.h"
#import "Rss.h"

@interface RssViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *rssArray;
@property (nonatomic) UIActivityIndicatorView *spinner;

@end

@implementation RssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XmlParser *parser=[[XmlParser alloc] init];
    parser.delegate=self;
    [parser getRssFromServer];
    self.spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(160, 240);
    self.spinner.hidesWhenStopped = YES;
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rssArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    Rss *rowData= self.rssArray[row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    UILabel *lbTitle = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *lbDescription = (UILabel *)[cell.contentView viewWithTag:2];
    lbTitle.text=rowData.rssTitle;
    lbDescription.text=rowData.rssDescription;
    [lbDescription sizeToFit];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    return UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Rss *selected=self.rssArray[indexPath.row];
    WebViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"WebView"];
    controller.url=selected.rssUrl;
    [self.navigationController pushViewController:controller animated:YES];
    }
-(void)xmlParserDidFinished:(NSMutableArray *)resultParsed{
    [self.spinner stopAnimating];
    self.rssArray=resultParsed;
    [self.tableView reloadData];
}

@end
