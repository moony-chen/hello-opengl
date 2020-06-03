//
//  RWTCube.m
//  HelloOpenGL
//
//  Created by Moony Chen on 2020/6/3.
//  Copyright © 2020 Moony Chen. All rights reserved.
//

#import "RWTCube.h"


const static RWTVertex vertices[] = {
    // Front
    {{1, -1, 1}, {1, 0, 0, 1}},
    {{1, 1, 1}, {0, 1, 0, 1}},
    {{-1, 1, 1}, {0, 0, 1, 1}},
    {{-1, -1, 1}, {0, 0, 0, 0}},
    
    //Back
    {{-1, -1, -1}, {1, 0, 0, 1}},
    {{-1, 1, -1}, {0, 1, 0, 1}},
    {{1, 1, -1}, {0, 0, 1, 1}},
    {{1, -1, -1}, {0, 0, 0, 0}}
    
};

const static GLubyte indices[] = {
    0, 1, 2,
    2, 3, 0,
    
    4,5,6,
    6,7,4,
    
    3,2,5,
    5,4,3,
    
    7,6,1,
    1,0,7,
    
    1,6,5,
    5,2,1,
    
    3,4,7,
    7,0,3
};


@implementation RWTCube

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
    if (self = [super initWithName:"cube" shader:shader vertices:(RWTVertex *)vertices vertextCount:sizeof(vertices)/sizeof(vertices[0]) indices:(GLubyte *)indices indexCount:sizeof(indices)/sizeof(indices[0])]) {
        
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    self.rotationZ += M_PI * dt;
    self.rotationY += M_PI * dt;
}


@end
