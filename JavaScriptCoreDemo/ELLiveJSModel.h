//
//  ELLiveJSModel.h
//  JavaScriptCoreDemo
//
//  Created by giifidev on 2018/8/21.
//  Copyright © 2018年 reborn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JSExport.h>

@class ELLiveJSModel;
@protocol MyPointExports <JSExport>

@property (nonatomic,assign) double x;
@property (nonatomic,assign) double y;

- (NSString *)description;

- (ELLiveJSModel *)makePointX:(double)x PointY:(double)y;

@end

@interface ELLiveJSModel : NSObject<MyPointExports>

@property (nonatomic,assign) double x;
@property (nonatomic,assign) double y;

- (NSString *)description;

- (ELLiveJSModel *)makePointX:(double)x PointY:(double)y;

@end
