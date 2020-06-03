//
//  RWTModel.h
//  HelloOpenGL
//
//  Created by Moony Chen on 2020/6/3.
//  Copyright © 2020 Moony Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTVertex.h"
@import GLKit;

@class RWTBaseEffect;

NS_ASSUME_NONNULL_BEGIN

@interface RWTModel : NSObject

@property (nonatomic, strong) RWTBaseEffect *shader;
@property (nonatomic, assign) GLKVector3 position;
@property (nonatomic) float rotationX;
@property (nonatomic) float rotationY;
@property (nonatomic) float rotationZ;
@property (nonatomic) float scale;

- (instancetype)initWithName:(char *)name shader:(RWTBaseEffect *)shader vertices: (RWTVertex *)vertices vertextCount:(unsigned int)vertexCount indices:(GLubyte *) indices indexCount:(unsigned int)indexCount;

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix;
- (void)updateWithDelta:(NSTimeInterval)dt;

@end

NS_ASSUME_NONNULL_END
