//
//  Level_3.h
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"

#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface Level_3 : CCLayer
{
    CCSprite *bobSprite;
    CCSprite *arrowSprite;
    
    ccTime time;
    float score;
    
    CCLabelTTF *scoreLabel;
    
    /////// Bob Died //////
    ccTime dieTime;
    float dieFloat;
    
}
+(id)scene;

@end