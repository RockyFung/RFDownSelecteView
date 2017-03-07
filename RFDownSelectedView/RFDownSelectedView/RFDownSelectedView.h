//
//  RFDownSelectedView.h
//  RFDownSelectedView
//
//  Created by rocky on 2017/3/6.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RFDownSelectedViewDelegate <NSObject>

- (void)selectIndexPathRow:(NSInteger )index;

@end

@interface RFDownSelectedView : UIView
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, strong) UIColor *titleTextColor;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, weak) id<RFDownSelectedViewDelegate> delegate;

- (void)popView;
@end
