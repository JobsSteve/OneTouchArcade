//
//  Level_18.h
//  GameplayPrototype30
//
//  Created by Артур on 14.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_18 : CCLayer
{
    CCSprite *bobSprite;
    
    CCSprite *ladderSprite1;
    CCSprite *ladderSprite2;
    CCSprite *ladderSprite3;
    
    CCSprite *bombSprite1;
    CCSprite *bombSprite2;
    CCSprite *bombSprite3;
    
    ccTime bombTime;
    float bombFloat;
    
    ccTime bombTime2;
    float bombFloat2;
    
    ccTime bombTime3;
    float bombFloat3;
    
}

+(id)scene;

@end