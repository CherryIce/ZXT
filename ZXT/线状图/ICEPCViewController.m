//
//  ICEPCViewController.m
//  ZXT
//
//  Created by 1 on 2019/6/18.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEPCViewController.h"

#import "ICEPageScollerView.h"

@interface ICEPCViewController ()

@property (nonatomic,strong) ICEPageScollerView * v;

@end

@implementation ICEPCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    _v = [[ICEPageScollerView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 200)];
    [self.view addSubview:_v];
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
