//
//  Level_14.h
//  GameplayPrototype30
//
//  Created by Артур on 14.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"

#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_14 : CCLayer
{
    CCSprite *bobSprite;
    CCSprite *stoneSprite;
    CCSprite *backgroundSprite;
    
    BOOL quakeBOOL;
    
    ccTime time;
    float score;
    
    CCLabelTTF *scoreLabel;
    
    
    CCMenu *pauseMenu;   
    CCMenu *PauseButton;
}

+(id)scene;

@end