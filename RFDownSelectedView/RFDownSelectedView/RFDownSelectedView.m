//
//  RFDownSelectedView.m
//  RFDownSelectedView
//
//  Created by rocky on 2017/3/6.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "RFDownSelectedView.h"
@interface RFDownSelectedView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) CGRect bgFrame;
@end

@implementation RFDownSelectedView

- (instancetype)initWithFrame:(CGRect)frame
{
    // 设置成屏幕大小，方便使用点击收回
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
        _bgFrame = frame;
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(self.bgFrame.origin.x, self.bgFrame.origin.y, self.bgFrame.size.width, 0)];
        self.bgView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.tableView];
    }
    return self;
}

- (void)popView{
    self.tableView.hidden = YES;
    UIWindow *windowView = [UIApplication sharedApplication].keyWindow;
    [windowView addSubview:self];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf.bgView setFrame:self.bgFrame];
    } completion:^(BOOL finished) {
        weakSelf.tableView.hidden = NO;
    }];
}

- (void)dismiss
{
    self.tableView.hidden = YES;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.bgView.frame = CGRectMake(weakSelf.bgFrame.origin.x, weakSelf.bgFrame.origin.y, weakSelf.bgFrame.size.width, 0);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![[touches anyObject].view isEqual:self.bgView]) {
        [self dismiss];
    }
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bgFrame.size.width , self.bgFrame.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
    }
    return _tableView;
}
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
#pragma mark -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.rowHeight == 0) {
        return 44;
    }else{
        return self.rowHeight;
    }
}
#pragma mark -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cellIdentifier2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
//    cell.imageView.image = [UIImage imageNamed:self.images[indexPath.row]];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:self.fontSize];
    cell.textLabel.textColor = self.titleTextColor;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectIndexPathRow:)]) {
        
        [self dismiss];
        [self.delegate selectIndexPathRow:indexPath.row];
    }
}


@end
