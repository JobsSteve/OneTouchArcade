//
//  Level_8.h
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_8 : CCLayer

{
    CCSprite *bobSprite;
    CCSprite *backgroundSprite;
    CCSprite *brickSprite;
    
    CGSize screen;
    float bobSpriteWidth;
    float bobSpriteHeight;
    float backgroundSpriteHeight;
    
    BOOL flyingBOOL;
    
    /////// RAT ///////
    CCSprite *ratSprite;
    
    /////// BOB DIED //////
    ccTime dieTime;
    float dieFloat;
    
    //////// TORCH /////////
    CCSprite *torchSprite;
    CCSprite *fireBackgroundSprite;
    CCSprite *fireLightSprite;
    CCSprite *fireLightSprite1;
    float timeFloat;
    ccTime totalTime;
    CCLabelTTF *timeLabel;
    float buffTime;
}

+(id)scene;

@end
