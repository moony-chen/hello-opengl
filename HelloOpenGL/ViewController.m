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
#import "RWTSquire.h"
#import "RWTCube.h"

@import OpenGLES;

@interface ViewController ()

@end

@implementation ViewController {
    RWTBaseEffect *_shader;
    RWTSquire *_square;
    RWTCube *_cube;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *view = (GLKView *)self.view;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    [EAGLContext setCurrentContext:view.context];
    [self setupScene];
}

- (void)setupScene {
    _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
    _square = [[RWTSquire alloc] initWithShader:_shader];
    _cube = [[RWTCube alloc] initWithShader:_shader];
//    _square.position = GLKVector3Make(0.5, -1, 0);
    _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
     
    GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0, 0, -5);
    viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(20), 1, 0, 0);
//    [_square renderWithParentModelViewMatrix:viewMatrix];
    [_cube renderWithParentModelViewMatrix:viewMatrix];
    
     
}

- (void)update {
//    [_square updateWithDelta:self.timeSinceLastUpdate];
    [_cube updateWithDelta:self.timeSinceLastUpdate];
}


@end
