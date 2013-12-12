//
//  Level_2.h
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_2 : CCLayer
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
    
}

+(id)scene;

@end