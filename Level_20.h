//
//  Level_20.h
//  GameplayPrototype30
//
//  Created by Артур on 14.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_20 : CCLayer
{
    CCSprite *bobSprite;
    CCSprite *wallSprite;
    CCSprite *backgroundSprite;
    
    CCSprite *fallingWallSprite;
    
     BOOL quakeBOOL;
}

+(id)scene;

@end
