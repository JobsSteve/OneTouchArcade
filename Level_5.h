//
//  Level_5.h
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "CCLayer.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_5 : CCLayer
{
    CCSprite *bobSprite;
    CCSprite *backgroundSprite;
    CCSprite *gridSprite;
    CCSprite *backsideSprite;
    
    CCSprite *windowSkeletonSprite;
    CCSprite *leftWindowSprite;
    CCSprite *rightWindowSprite;
    CCSprite *windowBacksideSprite;
    CCSprite *finishDoorSprite;
    
    
    
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