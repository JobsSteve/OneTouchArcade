//
//  Level_14.m
//  GameplayPrototype30
//
//  Created by Артур on 14.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_14.h"
#import "Level_15.h"

@implementation Level_14

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_14 *layer = [Level_14 node];
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
        CGSize screen = [CCDirector sharedDirector].winSize;
        self.isTouchEnabled = YES;
        
        backgroundSprite = [CCSprite spriteWithFile:@"level_19.png"];
        backgroundSprite.position = ccp(screen.width/2,screen.height/2);
        backgroundSprite.opacity = 255;
        [self addChild:backgroundSprite];
        
        //CCSprite *bobSprite;
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        float bobSpriteWidth = [bobSprite contentSize].width;
        float bobSpriteHeight = [bobSprite contentSize].height;
        bobSprite.position = ccp(bobSpriteWidth, screen.height*0.265);
        [self addChild:bobSprite z:10];
        
        stoneSprite = [CCSprite spriteWithFile:@"stone_ball.png"];
        float stoneSpriteWidth = [stoneSprite contentSize].width;
        float stoneSpriteHeight = [stoneSprite contentSize].height;
        stoneSprite.position = ccp(-stoneSpriteWidth/2-60, screen.height*0.3);
        [self addChild:stoneSprite z:15];
        
        [self schedule:@selector(runningStoneUpdate)];
        [self schedule:@selector(stoneCollideBob)];
        
        [self schedule:@selector(earthQuakeDown) interval:0.1];
        [self schedule:@selector(earthQuakeUp) interval:0.3];
        
        
        //[self pauseButtonFunction];
        
    }
    return self;
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
      backgroundSprite.position = ccp(backgroundSprite.position.x,backgroundSprite.position.y-2);
      stoneSprite.position = ccp(stoneSprite.position.x, stoneSprite.position.y+1.5);
    }
    else
    {
        bobSprite.position = ccp(bobSprite.position.x, bobSprite.position.y-0.5);
        backgroundSprite.position = ccp(backgroundSprite.position.x,backgroundSprite.position.y+2);
        stoneSprite.position = ccp(stoneSprite.position.x, stoneSprite.position.y-1.5); 
    }
    
}

-(void)earthQuakeUp
{
    if(quakeBOOL == YES)
    {
    //bobSprite.position = ccp(bobSprite.position.x, bobSprite.position.y-1);
    backgroundSprite.position = ccp(backgroundSprite.position.x,backgroundSprite.position.y+0.25);
    stoneSprite.position = ccp(stoneSprite.position.x, stoneSprite.position.y-0.25);
    }
    else
    {
        //bobSprite.position = ccp(bobSprite.position.x, bobSprite.position.y-1);
        backgroundSprite.position = ccp(backgroundSprite.position.x,backgroundSprite.position.y-0.25);
        stoneSprite.position = ccp(stoneSprite.position.x, stoneSprite.position.y+0.25);
    }
}

-(void)stoneCollideBob
{
    CGSize screen = [CCDirector sharedDirector].winSize;
    bobSprite.scaleX = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    CGRect stoneRect = [stoneSprite boundingBox];
    
    if(CGRectIntersectsRect(bobRect,stoneRect))
        
    {
        CCLOG(@"!!!!!!BOB INTERSECT BOMB1!!!!!");
        bobSprite.opacity = 0;
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:0.5 scene:[Level_14 node]]];
        
    }
    
}



-(void)runningStoneUpdate
{
    CGSize screen = [CCDirector sharedDirector].winSize;
    float stoneSpriteWidth = [stoneSprite contentSize].width;
    
    stoneSprite.position = ccp(stoneSprite.position.x + 0.010*100, stoneSprite.position.y);
    
    if(stoneSprite.position.x > screen.width+stoneSpriteWidth)
    {
        stoneSprite.position = ccp(0,stoneSprite.position.y);
        //bobSprite.opacity = 255;
        //arrowSprite.position = ccp(screen.width/2,screen.height*2/3);
        
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self runningByStep];
}

-(void)runningByStep
{
    CGSize screen = [CCDirector sharedDirector].winSize;
    bobSprite.position = ccp(bobSprite.position.x + 0.10*100 +1, bobSprite.position.y);
    
    if(bobSprite.position.x > screen.width)
    {
        //bobSprite.position = ccp(bobSpriteWidth,bobSprite.position.y);
        //bobSprite.opacity = 255;
        //arrowSprite.position = ccp(screen.width/2,screen.height*2/3);
        //[[CCDirector sharedDirector] sendCleanupToScene];
        //[[CCDirector sharedDirector]resume];
        
        [self unschedule:@selector(runningStoneUpdate)];
        [self unschedule:@selector(stoneCollideBob)];
        //[self removeChild:bobSprite cleanup:NO];
        
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:0.3 scene:[Level_15 node]]];
        
    }
    
    
}





@end
