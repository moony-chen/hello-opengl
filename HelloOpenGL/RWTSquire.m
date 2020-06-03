//
//  RWTSquire.m
//  HelloOpenGL
//
//  Created by Moony Chen on 2020/6/3.
//  Copyright © 2020 Moony Chen. All rights reserved.
//

#import "RWTSquire.h"

const static RWTVertex vertices[] = {
    {{1.0, -1.0, 0}, {1, 0, 0, 1}},
    {{1.0, 1.0, 0}, {0, 1, 0, 1}},
    {{-1, 1, 0}, {0, 0, 1, 1}},
    {{-1, -1, 0}, {0, 0, 0, 0}}
};

const static GLubyte indices[] = {
    0, 1, 2,
    2, 3, 0
};

@implementation RWTSquire

- (instancetype)initWithShader:(RWTBaseEffect *)shader {
    if (self = [super initWithName:"square" shader:shader vertices:(RWTVertex *)vertices vertextCount:sizeof(vertices)/sizeof(vertices[0]) indices:(GLubyte *)indices indexCount:sizeof(indices)/sizeof(indices[0])]) {
        
    }
    return self;
}

@end
