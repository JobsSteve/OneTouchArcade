//
//  Level_4.h
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"

#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_4 : CCLayer
{
    CGSize screen;
    CCSprite *bobSprite;
    
    CCSprite *ladderSprite1;
    CCSprite *ladderSprite2;
    CCSprite *bombSprite1;
    CCSprite *bombSprite2;
    
    ccTime time;
    float score;
    CCLabelTTF *scoreLabel;
    
    /////// Bob Died //////
    ccTime dieTime;
    float dieFloat;
    
    ///// Explosion ///////
      CCParticleExplosion *explosion;
    CGPoint explosionPosition;

}

+(id)scene;

@end