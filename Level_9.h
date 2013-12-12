//
//  Level_9.h
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_9 : CCLayer
{ 
    CCSprite *bobSprite;
    CCSprite *backgroundSprite;
    CCSprite *bumerangSprite;
    CCSprite *ratSprite;
    
    CCSprite *spiderSprite;
    CCSprite *spiderZoneSprite;
    CCSprite *spiderSprite2;
    CCSprite *spiderZoneSprite2;
    
     CCSprite *upsideSprite;
    
    
    
    CGSize screenSize;
    float bobSpriteWidth;
    float backgroundSpriteHeight;
    
    float finalBumerangPosX;
    
    float accelBumerang;
    float decelBumerang;
    float accelRotateBum;
    float decelRotateBum;
    BOOL bumerangDirection;
    
    
    
    /////// BOB DIED //////
    ccTime dieTime;
    float dieFloat;
    ccTime dieTime1;
    float dieFloat1;
    
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