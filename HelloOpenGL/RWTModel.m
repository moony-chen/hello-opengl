//
//  RWTModel.m
//  HelloOpenGL
//
//  Created by Moony Chen on 2020/6/3.
//  Copyright © 2020 Moony Chen. All rights reserved.
//

#import "RWTModel.h"
@import OpenGLES;
#import "RWTBaseEffect.h"


@implementation RWTModel {
    char *_name;
    GLuint _vao;
    GLuint _vertexBuffer;
    GLuint _indexBuffer;
    unsigned int _vertextCount;
    unsigned int _indexCount;
    RWTBaseEffect *_shader;
}

- (instancetype)initWithName:(char *)name shader:(RWTBaseEffect *)shader vertices: (RWTVertex *)vertices vertextCount:(unsigned int)vertexCount indices:(GLubyte *) indices indexCount:(unsigned int)indexCount {
    if (self = [super init]) {
        _name = name;
        _vertextCount = vertexCount;
        _indexCount = indexCount;
        _shader = shader;
        self.position = GLKVector3Make(0, 0, 0);
        self.rotationX = 0;
        self.rotationY = 0;
        self.rotationZ = 0;
        self.scale = 1.0;
         
        glGenVertexArraysOES(1, &_vao);
         glBindVertexArrayOES(_vao);
         
         
         glGenBuffers(1, &_vertexBuffer);
         glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
         glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(RWTVertex), vertices, GL_STATIC_DRAW);
         
         glGenBuffers(1, &_indexBuffer);
         glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
         glBufferData(GL_ELEMENT_ARRAY_BUFFER, indexCount * sizeof(GLubyte), indices, GL_STATIC_DRAW);
         
         glEnableVertexAttribArray(RWTVertexAttribPosition);
         glVertexAttribPointer(RWTVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *)offsetof(RWTVertex, Position));
         glEnableVertexAttribArray(RWTVertexAttribColor);
         glVertexAttribPointer(RWTVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *)offsetof(RWTVertex, Color));
        glEnableVertexAttribArray(RWTVertexAttribTexCoord);
        glVertexAttribPointer(RWTVertexAttribTexCoord, 2, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *)offsetof(RWTVertex, TexCoord));
        glEnableVertexAttribArray(RWTVertexAttribNormal);
        glVertexAttribPointer(RWTVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *)offsetof(RWTVertex, Normal));
         
         
         glBindVertexArrayOES(0);
         glBindBuffer(GL_ARRAY_BUFFER, 0);
         glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    }
    return self;
}

- (GLKMatrix4)modelMatrix {
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, self.position.z);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationX, 1, 0, 0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationY, 0, 1, 0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationZ, 0, 0, 1);
    modelMatrix = GLKMatrix4Scale(modelMatrix, self.scale, self.scale, self.scale);
    
    return modelMatrix;
}

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix {
    _shader.modelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, [self modelMatrix]);
    _shader.texture = self.texture;
    [_shader prepareToDraw];
        
        
    //    glDrawArrays(GL_TRIANGLES, 0, 3);
        glBindVertexArrayOES(_vao);
        glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
        glBindVertexArrayOES(0);
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    
}

- (void)loadTexture:(NSString *)filename {
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    NSDictionary *options = @{ GLKTextureLoaderOriginBottomLeft: @YES };
    
    GLKTextureInfo *info = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
    if (info == nil) {
        NSLog(@"Error loading file: %@", error.localizedDescription);
    } else {
        self.texture = info.name;
    }
    
}

@end
