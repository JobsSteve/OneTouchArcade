//
//  Level_N.h
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_N : CCLayer
{
    CCSprite *bobSprite;
    CCSprite *backgroundSprite;
    
    
    CGSize screen;
    float bobSpriteWidth;
    float backgroundSpriteHeight;
    
}

+(id)scene;

@end
