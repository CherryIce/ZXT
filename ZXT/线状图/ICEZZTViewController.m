//
//  ICEZZTViewController.m
//  ZXT
//
//  Created by doman on 2019/5/8.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEZZTViewController.h"

@interface ICEZZTViewController ()

@end

@implementation ICEZZTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSData * data = [@"0123456789" dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@">>>%@",[[data MD5Digest]  base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
