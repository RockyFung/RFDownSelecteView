//
//  ViewController.m
//  RFDownSelectedView
//
//  Created by rocky on 2017/3/6.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import "ViewController.h"
#import "RFDownSelectedView.h"


@interface ViewController ()<RFDownSelectedViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController
- (IBAction)clickAction:(id)sender {
    self.dataArray = @[@"驾驶证", @"行驶证", @"身份证", @"资格证"];
    RFDownSelectedView *vc = [[RFDownSelectedView alloc]initWithFrame:CGRectMake(self.btn.frame.origin.x, self.btn.frame.origin.y + self.btn.frame.size.height, self.btn.frame.size.width, 40 * 4)];
    vc.dataArray = self.dataArray;
    vc.rowHeight = 40.0;
    vc.fontSize = 14.0;
    vc.titleTextColor = [UIColor darkGrayColor];
    vc.delegate = self;
    [vc popView];
    
    
}
- (void)selectIndexPathRow:(NSInteger)index{
    [self.btn setTitle:self.dataArray[index] forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
