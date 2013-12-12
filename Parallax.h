//
//  Parallax.h
//  GameplayPrototype30
//
//  Created by Артур on 13.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>
#import "CCParallaxNode.h"


@interface Parallax : CCLayer
{
    CCSprite *bobSprite;
    CCSprite *backgroundSprite;
    CCSprite *gridSprite;
    
    CCParallaxNode *parallax;
    CCSprite *backsideSprite1;
    CCSprite *backsideSprite2;
    CCSprite *backsideSprite3;
    CCSprite *backsideSprite4;
    
    CCSprite *mortalwallsSprite1;
    CCSprite *mortalwallsSprite2;
    CCSprite *mortalwallsSprite3;
    CCSprite *mortalwallsSprite4;
    
    
    CGSize screenSize;
    float bobSpriteWidth;
    float backgroundSpriteHeight;
    
}

+(id)scene;

@end