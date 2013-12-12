//
//  Level_20.m
//  GameplayPrototype30
//
//  Created by Артур on 14.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//#import "Level_24.h"
#import "Level_20.h"
#import "Level_22.h"

@implementation Level_20

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_20 *layer = [Level_20 node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    if((self = [super init]))
    {
        CGSize screen = [CCDirector sharedDirector].winSize;
        self.isTouchEnabled = YES;
        
        //------------------- LEVEL BACKGROUND -----------------
        backgroundSprite = [CCSprite spriteWithFile:@"level_24_ground.png"];
        float backgroundSpriteHeight = [backgroundSprite contentSize].height;
        backgroundSprite.position = ccp(screen.width/2,backgroundSpriteHeight/2);
        [self addChild:backgroundSprite z:1];
        
        //------------------ BOB -------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        float bobSpriteWidth = [bobSprite contentSize].width;
        bobSprite.position = ccp(bobSpriteWidth/2,screen.height*0.265);
        [self addChild:bobSprite z:10];
        
        wallSprite = [CCSprite spriteWithFile:@"level_24_wall.png"];
        float wallSpriteHeight = [wallSprite contentSize].height;
        wallSprite.position = ccp(screen.width/2, screen.height/2);
        [self addChild:wallSprite z:0];
        
        fallingWallSprite = [CCSprite spriteWithFile:@"falling_wall.png"];
        float fallingWallSpriteHeight = [fallingWallSprite contentSize].height;
        fallingWallSprite.position = ccp(screen.width/2,screen.height + fallingWallSpriteHeight/28);
        [self addChild:fallingWallSprite z:11];
        
        //[self schedule:@selector(bobRunningUpdate)];
        
        [self schedule:@selector(fallingWallUpdate)];
        
        
        [self schedule:@selector(earthQuakeDown) interval:0.1];
         [self schedule:@selector(earthQuakeUp) interval:0.3];
        
    }
    return self;
}

-(void)bobRunningUpdate
{
    //CCLOG(@"inside runningBobUpdate!!!");
    CGSize screen = [CCDirector sharedDirector].winSize;
    float bobSpriteWidth = [bobSprite contentSize].width;
    
    bobSprite.position = ccp(bobSprite.position.x + 100*0.116, bobSprite.position.y);
    
    if(bobSprite.position.x > screen.width-bobSpriteWidth/2)
    {
       // bobSprite.position = ccp(-bobSpriteWidth/2,bobSprite.position.y);
        
        [self unschedule:@selector(fallingWallSprite)];
        [self unschedule:@selector(earthQuakeDown)];
        [self unschedule:@selector(earthQuakeUp)];
        
       // [[CCDirector sharedDirector] sendCleanupToScene];
       // [[CCDirector sharedDirector]replaceScene:
       //  [CCTransitionFade transitionWithDuration:0.3 scene:[Level_20 node]]];
        [[CCDirector sharedDirector] replaceScene: [Level_22 node]];
    }
}

-(void)fallingWallUpdate
{
    CGSize screen = [CCDirector sharedDirector].winSize;
    
    if(fallingWallSprite.position.y > screen.height*0.60)
        fallingWallSprite.position = ccp(fallingWallSprite.position.x, fallingWallSprite.position.y - 100*0.003);
    
    CGRect bobSpriteRect = [bobSprite boundingBox];
    fallingWallSprite.scaleY = 0.7;
    CGRect fallingwallSpriteRect = [fallingWallSprite boundingBox];
    fallingWallSprite.scaleY = 1;
    
    if(CGRectIntersectsRect(fallingwallSpriteRect, bobSpriteRect))
    {
        CCLOG(@"WALL INTERSET BOB!!!");
        [[CCDirector sharedDirector] replaceScene: [Level_20 node]];
        
    }
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self bobRunningUpdate];
}

-(void)earthQuakeDown
{
    if (quakeBOOL == YES)
    {
        quakeBOOL = NO;
    }
    else
    {   
        quakeBOOL = YES;
    }
    if(quakeBOOL == YES)
    {
        bobSprite.position = ccp(bobSprite.position.x, bobSprite.position.y+0.5);
        backgroundSprite.position = ccp(backgroundSprite.position.x,backgroundSprite.position.y+0.5);
         wallSprite.position = ccp(wallSprite.position.x,wallSprite.position.y+1);
        fallingWallSprite.position = ccp(fallingWallSprite.position.x-0.5,fallingWallSprite.position.y+2.5);
    }
    else
    {
        bobSprite.position = ccp(bobSprite.position.x, bobSprite.position.y-0.5);
        backgroundSprite.position = ccp(backgroundSprite.position.x,backgroundSprite.position.y-0.5);
        wallSprite.position = ccp(wallSprite.position.x,wallSprite.position.y-1);
        fallingWallSprite.position = ccp(fallingWallSprite.position.x+0.5, fallingWallSprite.position.y-2.5); 
    }
    
}

-(void)earthQuakeUp
{
    if(quakeBOOL == YES)
    {
        //bobSprite.position = ccp(bobSprite.position.x, bobSprite.position.y-1);
        backgroundSprite.position = ccp(backgroundSprite.position.x,backgroundSprite.position.y+0.5);
        fallingWallSprite.position = ccp(fallingWallSprite.position.x, fallingWallSprite.position.y-0.25);
    }
    else
    {
        //bobSprite.position = ccp(bobSprite.position.x, bobSprite.position.y-1);
        backgroundSprite.position = ccp(backgroundSprite.position.x,backgroundSprite.position.y-0.5);
        fallingWallSprite.position = ccp(fallingWallSprite.position.x, fallingWallSprite.position.y+0.25);
    }
}



@end