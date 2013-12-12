//
//  Level_13.h
//  GameplayPrototype30
//
//  Created by Артур on 13.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "CCLayer.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_13 : CCLayer
{
    CCSprite *bobSprite;
    CCSprite *backgroundSprite;
    CCSprite *corridorSprite;
    CCSprite *gridSprite;
    
    CCSprite *leftWindowSprite;
    CCSprite *rightWindowSprite;
    CCSprite *windowBacksideSprite;
    CCSprite *leftWindowSprite2;
    CCSprite *rightWindowSprite2;
    CCSprite *windowBacksideSprite2;
    
    
    
    CGSize screenSize;
    float bobSpriteWidth;
    float backgroundSpriteHeight;
    
    ccTime dieTime;
    float dieFloat;
    CCLabelTTF *dieTimeLabel;
    
    
    int counter;
    
}

+(id)scene;

@end