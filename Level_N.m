//
//  Level_N.m
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_N.h"

@implementation Level_N
+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_N *layer = [Level_N node];
    [scene addChild:layer];
    return scene;
}

-(void)dealloc
{
    
    [super dealloc];
}

-(id)init
{
    if((self = [super init]))
    {
        screen = [CCDirector sharedDirector].winSize;
        
        //------------------- LEVEL BACKGROUND -----------------
        backgroundSprite = [CCSprite spriteWithFile:@"level_1.png"];
        backgroundSpriteHeight = [backgroundSprite contentSize].height;
        backgroundSprite.position = ccp(screen.width/2,backgroundSpriteHeight/2);
        [self addChild:backgroundSprite z:0];
        
        //------------------------- BOB -------------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        bobSpriteWidth = [bobSprite contentSize].width;
        bobSprite.position = ccp(-bobSpriteWidth/2,screen.height*0.315);
        [self addChild:bobSprite z:10];
        
        [self schedule:@selector(bobRunningUpdate)];
        [self schedule:@selector(bobRotateUpdate)];
        
        
    }
    return self;
}

-(void)bobRotateUpdate
{
    bobSprite.rotation +=10;
}

-(void)bobRunningUpdate
{
    screen = [CCDirector sharedDirector].winSize;
    bobSprite.position = ccp(bobSprite.position.x + 100*0.016, bobSprite.position.y);
    
    if(bobSprite.position.x > screen.width+bobSpriteWidth/2)
    {
        [[CCDirector sharedDirector] sendCleanupToScene];
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_N node]]];
    }
}

@end
