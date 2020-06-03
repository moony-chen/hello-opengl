//
//  ViewController.m
//  HelloOpenGL
//
//  Created by Moony Chen on 2020/6/3.
//  Copyright © 2020 Moony Chen. All rights reserved.
//

#import "ViewController.h"
#import "RWTVertex.h"
#import "RWTBaseEffect.h"
@import OpenGLES;

@interface ViewController ()

@end

@implementation ViewController {
    GLuint _vertexBuffer;
    GLuint _indexBuffer;
    RWTBaseEffect *_shader;
    GLsizei _indexCount;
    GLuint _vao;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *view = (GLKView *)self.view;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [EAGLContext setCurrentContext:view.context];
    [self setupShader];
    [self setupVertexBuffer];
}

- (void)setupVertexBuffer {
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
    
    _indexCount = sizeof(indices) / sizeof(indices[0]);
    
    glGenVertexArraysOES(1, &_vao);
    glBindVertexArrayOES(_vao);
    
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(RWTVertexAttribPosition);
    glVertexAttribPointer(RWTVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *)offsetof(RWTVertex, Position));
    glEnableVertexAttribArray(RWTVertexAttribColor);
    glVertexAttribPointer(RWTVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *)offsetof(RWTVertex, Color));
    
    
    glBindVertexArrayOES(0);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}

- (void)setupShader {
    _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    
    [_shader prepareToDraw];
    
    
//    glDrawArrays(GL_TRIANGLES, 0, 3);
    glBindVertexArrayOES(_vao);
    glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
    glBindVertexArrayOES(0);
    
     
}


@end
