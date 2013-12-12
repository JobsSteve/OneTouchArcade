//
//  Level_6.h
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_6 : CCLayer
{
    CCSprite *bobSprite;
    CCSprite *backgroundSprite;
    CCSprite *gridSprite;
    
    CCSprite *brickSprite;
    CCSprite *brickSprite2;
    CCSprite *brickSprite3;
    CCSprite *brickSprite4;
    CCSprite *brickSprite5;
    CCSprite *brickSprite6;
    CCSprite *brickSprite7;
    CCSprite *brickSprite8;
    CCSprite *brickSprite9;
    CCSprite *brickSprite10;
    CCSprite *brickSprite11;
    CCSprite *brickSprite12;
    
    CGRect bobRect;
    
    CGRect brickRect;
    CGRect brickRect2;
    CGRect brickRect3;
    CGRect brickRect4;
    CGRect brickRect5;
    CGRect brickRect6;
    
    CGSize screenSize;
    float bobSpriteWidth;
    float backgroundSpriteHeight;
    
    ccTime brickTime;
    ccTime brickTime2;
    ccTime brickTime3;
    ccTime brickTime4;
    ccTime brickTime5;
    ccTime brickTime6;

    CCSprite *earthSprite1;
    CCSprite *earthSprite2;
    
    /////// JUMP ///////
    CCSprite *redBarSprite;
    CCSprite *frameBarSprite;
    
    float jump;
    float currentTime;
    CCProgressTimer *progressTimer;
    ccTime time;
    CCLabelTTF *scoreLabel;
    
    
    ////////// -(void)BobDiedAnimation:(ccTime)delta //////////
    ccTime dieTime;
    float dieFloat;
    CCLabelTTF *dieTimeLabel;
    
    float timebrick; // 1.5 секунды - на исчезновение
    
}

+(id)scene;


@end