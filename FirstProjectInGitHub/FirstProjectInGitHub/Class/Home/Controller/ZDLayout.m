//
//  ZDLayout.m
//  FirstProjectInGitHub
//
//  Created by zd on 2018/5/17.
//  Copyright © 2018年 zd. All rights reserved.
//

#import "ZDLayout.h"

static const NSUInteger ZDDefautColumnCount = 3;
static const CGFloat ZDDefaultColumnMargin = 10;
static const CGFloat ZDDefaultRowMargin = 10;
static const UIEdgeInsets ZDDefaultEdgeInsets = {10,10,10,10};

@interface ZDLayout()
@property (nonatomic, strong) NSMutableArray *attrsArr;
@property (nonatomic, strong) NSMutableArray *columnHeights;
@property (nonatomic, assign) CGFloat contentHeight;

- (NSUInteger)columnCount;
- (CGFloat)columnMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)edgeInsets;

@end

@implementation ZDLayout

- (void)prepareLayout{
    [super prepareLayout];
    self.contentHeight = 0;
    [self.columnHeights removeAllObjects];
    
    for (NSInteger i = 0; i < [self columnCount]; i ++) {
        [self.columnHeights addObject:@([self edgeInsets].top)];
    }
    
    [self.attrsArr removeAllObjects];
    
    //如果有heder
    
    //cell
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArr addObject:attr];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionWidth = self.collectionView.bounds.size.width;
    CGFloat cellWidth = (collectionWidth-self.edgeInsets.left-self.edgeInsets.right-(self.columnCount-1)*self.columnMargin)/self.columnCount;
    CGFloat cellHeight = [self.zDelegate waterFallLayout:self heightForItemAtIndexPath:indexPath itemWidth:cellWidth];

    NSInteger minColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    CGFloat maxColumnHeight = 0;
    for (NSInteger i = 0; i < self.columnHeights.count; i ++) {
        CGFloat tmpHeight = [self.columnHeights[i] doubleValue];
        if (tmpHeight<minColumnHeight) {
            minColumnHeight = tmpHeight;
            minColumn = i;
        }
        if (tmpHeight>maxColumnHeight) {
            maxColumnHeight = tmpHeight;
        }
    }

    CGFloat cellX = self.edgeInsets.left + minColumn*(self.columnMargin+cellWidth);
    CGFloat cellY = minColumnHeight;
    if (cellY != self.edgeInsets.top) {
        cellY += self.rowMargin;
    }
    attr.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
    self.columnHeights[minColumn] = @(CGRectGetMaxY(attr.frame));
    
    maxColumnHeight = CGRectGetMaxY(attr.frame)>maxColumnHeight ? CGRectGetMaxY(attr.frame) : maxColumnHeight;
    
    if (self.contentHeight<maxColumnHeight) {
        self.contentHeight = maxColumnHeight;
    }
    
    return attr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArr;
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(0, self.contentHeight+self.edgeInsets.bottom);
}

- (NSUInteger)columnCount{
    if ([self.zDelegate respondsToSelector:@selector(columnCountInZDLayout:)]) {
        return [self.zDelegate columnCountInZDLayout:self];
    }else{
        return ZDDefautColumnCount;
    }
}

- (CGFloat)columnMargin{
    if ([self.zDelegate respondsToSelector:@selector(columnMarginInZDLayout:)]) {
        return [self.zDelegate columnMarginInZDLayout:self];
    }else{
        return ZDDefaultColumnMargin;
    }
}

- (CGFloat)rowMargin{
    if ([self.zDelegate respondsToSelector:@selector(rowMarginInZDLayou:)]) {
        return [self.zDelegate rowMarginInZDLayou:self];
    }else{
        return ZDDefaultRowMargin;
    }
}

- (UIEdgeInsets)edgeInsets{
    if ([self.zDelegate respondsToSelector:@selector(edgeInsetsInZDLayout:)]) {
        return [self.zDelegate edgeInsetsInZDLayout:self];
    }else{
        return ZDDefaultEdgeInsets;
    }
}

- (NSMutableArray *)attrsArr{
    if (!_attrsArr) {
        _attrsArr = [[NSMutableArray alloc] init];
    }
    return _attrsArr;
}

- (NSMutableArray *)columnHeights{
    if (!_columnHeights) {
        _columnHeights = [[NSMutableArray alloc] init];
    }
    return _columnHeights;
}

@end
