//
//  Level_15.h
//  GameplayPrototype30
//
//  Created by Артур on 13.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>
//#import "Parallax.h"

@interface Level_15 : CCLayer

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
    
    CCSprite *ratSprite2;
    CCSprite *ratSprite3;
    
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