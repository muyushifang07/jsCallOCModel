//
//  ELLiveJSModel.m
//  JavaScriptCoreDemo
//
//  Created by giifidev on 2018/8/21.
//  Copyright © 2018年 reborn. All rights reserved.
//

#import "ELLiveJSModel.h"

@implementation ELLiveJSModel

- (NSString *)description {
    // self.x = 7;
    // self.y = 9;
    // 这里可以看到前端赋的值20，前端直接可以操作OC 的model以及属性
    NSLog(@"打印model的X的值-----:%f",self.x);
    return @"description";
}

- (ELLiveJSModel *)makePointX:(double)x PointY:(double)y {
    ELLiveJSModel *model = [[ELLiveJSModel alloc]init];
    model.x = x;
    model.y = y;
    NSLog(@"返回一个新的model.x:%f model.y:%f",model.x,model.y);
    return model;
}

@end
