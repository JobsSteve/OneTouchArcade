//
//  Level_10.h
//  GameplayPrototype30
//
//  Created by Артур on 13.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_10 : CCLayer
{
    CCSprite *bobSprite;
    CCSprite *backgroundSprite;
    CCSprite *earthSprite;
    
    CCSprite *redBarSprite;
    CCSprite *frameBarSprite;
    
    CCSprite *earthSprite1;
    CCSprite *earthSprite2;
    
    float jump;
    float currentTime;
    CCProgressTimer *progressTimer;
    
    
    CGSize screenSize;
    float bobSpriteWidth;
    float backgroundSpriteHeight;
    
    ccTime time;
    float score;
    CCLabelTTF *scoreLabel;
    
    //////// TRAMPLINE ////////
    CCSprite *tramplineSprite;
    ccTime trampTime;
    float tramptime;
    
    CGSize screen;
    
    /////// BOB DIED //////
    ccTime dieTime;
    float dieFloat;
    ccTime dieTime1;
    float dieFloat1;
    
    
}

+(id)scene;

@end