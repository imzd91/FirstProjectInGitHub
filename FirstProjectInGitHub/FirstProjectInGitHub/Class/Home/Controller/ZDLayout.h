//
//  ZDLayout.h
//  FirstProjectInGitHub
//
//  Created by zd on 2018/5/17.
//  Copyright © 2018年 zd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDLayout;

@protocol ZDLayoutDelegate<NSObject>

@required
- (CGFloat)waterFallLayout:(ZDLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

@optional
- (NSUInteger)columnCountInZDLayout:(ZDLayout *)layout;
- (CGFloat)columnMarginInZDLayout:(ZDLayout *)layout;
- (CGFloat)rowMarginInZDLayou:(ZDLayout *)layout;
- (UIEdgeInsets)edgeInsetsInZDLayout:(ZDLayout *)layout;

@end

@interface ZDLayout : UICollectionViewLayout

@property (nonatomic, weak) id<ZDLayoutDelegate> zDelegate;

@end
