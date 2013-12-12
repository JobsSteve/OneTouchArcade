//
//  Level_11.h
//  GameplayPrototype30
//
//  Created by Артур on 14.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"

#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_11 : CCLayer
{
    CCSprite *bobSprite;
    CCSprite *arrowSprite;
    CCSprite *arrowSprite2;
    CGSize screen;
    
    CCSprite *ratSprite;
    
    ccTime time;
    float score;
    
    CCLabelTTF *scoreLabel;
    
    /////// Bob Died //////
    ccTime dieTime;
    float dieFloat;
    
}
+(id)scene;

@end