//
//  Level_4.m
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "level_4.h"
#import "Level_5.h"


@implementation Level_4

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_4 *layer = [Level_4 node];
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
        self.isTouchEnabled = YES;
        
        CCSprite *backgroundSprite = [CCSprite spriteWithFile:@"level_4.png"];
        backgroundSprite.position = ccp(screen.width/2,screen.height/2);
        backgroundSprite.opacity = 255;
        [self addChild:backgroundSprite];
         backgroundSprite.scale = 1.01;
        
        //------------ BOB --------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        float bobSpriteWidth = [bobSprite contentSize].width;
        float bobSpriteHeight = [bobSprite contentSize].height;
        bobSprite.position = ccp(-bobSpriteWidth, screen.height*0.265);
        [self addChild:bobSprite z:10];
        //----------------------- BOB ANIMATION ------------------------
        CCAnimation *bobAnim = [CCAnimation animation];
        [bobAnim addFrameWithFilename:@"bob_anim_1.png"]; 
        [bobAnim addFrameWithFilename:@"bob_anim_2.png"]; 
        
        id bobAnimationAction = [CCAnimate actionWithDuration:0.3f
                                                    animation:bobAnim
                                         restoreOriginalFrame:YES];
        id repeatBobAnimationAction = 
        [CCRepeatForever actionWithAction:bobAnimationAction];
        [bobSprite runAction:repeatBobAnimationAction];
        
        
        //-------------- LADDER 2 & BOMB 2 ----------------
        ladderSprite1 = [CCSprite spriteWithFile:@"ladder.png"];
        float ladderSpriteWidth = [ladderSprite1 contentSize].width;
        float ladderSpriteHeight = [ladderSprite1 contentSize].height;
        ladderSprite1.position = ccp(screen.width*1/3, screen.height*0.35-5);
        [self addChild:ladderSprite1 z:5];
        
        ladderSprite2 = [CCSprite spriteWithFile:@"ladder.png"];
        ladderSprite2.position = ccp(screen.width*2/3, screen.height*0.35-5);
        [self addChild:ladderSprite2 z:5];
        
        bombSprite1 = [CCSprite spriteWithFile:@"bomb.png"];
        bombSprite1.position = ccp(screen.width*1/2, screen.height*0.25);
        [self addChild:bombSprite1 z:15];
        
        bombSprite2 = [CCSprite spriteWithFile:@"bomb.png"];
        bombSprite2.position = ccp(screen.width*5/6, screen.height*0.5);
        [self addChild:bombSprite2 z:15];
        
        
        
        
        
        [self schedule:@selector(runningBobUpdate)];
        [self schedule:@selector(bobCollideBomb)];
        
      //  [self pauseButtonFunction];
        
    }
    return self;
}

-(void)bobCollideBomb
{
    CGSize screen = [CCDirector sharedDirector].winSize;
    bobSprite.scaleX = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    CGRect bombRect1 = [bombSprite1 boundingBox];
    CGRect bombRect2 = [bombSprite2 boundingBox];
    
    if(CGRectIntersectsRect(bobRect,bombRect1))
        
    {
        CCLOG(@"!!!!!!BOB INTERSECT BOMB1!!!!!");
        [self unschedule:@selector(runningBobUpdate)];
        [self schedule:@selector(bobDiedAnimation:)];
        //explosion.position = ccp(screen.width*1/2, screen.height*0.25);
        explosionPosition = ccp(screen.width*1/2, screen.height*0.25);
        
        [self explosionEffect];
        bombSprite1.opacity = 0;
        
        
        //[[CCDirector sharedDirector] replaceScene:
        // [CCTransitionFade transitionWithDuration:0.5 scene:[Level_4 node]]];
        
    }
    
    if(CGRectIntersectsRect(bobRect,bombRect2))
        
    {
        [self unschedule:@selector(runningBobUpdate)];
        [self schedule:@selector(bobDiedAnimation:)];
        explosionPosition= ccp(screen.width*5/6, screen.height*0.5);
        [self explosionEffect];
         bombSprite2.opacity = 0;
        CCLOG(@"!!!!!!BOB INTERSECT BOMB2!!!!!");
        //bobSprite.opacity = 0;
        //[[CCDirector sharedDirector] replaceScene:
        // [CCTransitionFade transitionWithDuration:0.5 scene:[Level_4 node]]];
    }
    
}

-(void)runningBobUpdate
{
    CGSize screen = [CCDirector sharedDirector].winSize;
    float bobSpriteWidth = [bobSprite contentSize].width;
    
    bobSprite.position = ccp(bobSprite.position.x + 0.016*100, bobSprite.position.y);
    
    if(bobSprite.position.x > screen.width+bobSpriteWidth)
    {
        //bobSprite.position = ccp(bobSpriteWidth,bobSprite.position.y);
        bobSprite.opacity = 255;
        //arrowSprite.position = ccp(screen.width/2,screen.height*2/3);
        //[[CCDirector sharedDirector] sendCleanupToScene];
        //[[CCDirector sharedDirector]resume];
        [self unschedule:@selector(runningBobUpdate)];
        [self unschedule:@selector(bobCollideBomb)];
        [self removeChild:bobSprite cleanup:NO];
        
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_5 node]]];
        
    }
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    // [self schedule:@selector(bobCollideLadder)];
    [self bobCollideLadder];
}

-(void)bobCollideLadder
{
    
    CGSize screen = [CCDirector sharedDirector].winSize;
    bobSprite.scaleX = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    CGRect ladderRect1 = [ladderSprite1 boundingBox];
    CGRect ladderRect2 = [ladderSprite2 boundingBox];
    
    if(CGRectIntersectsRect(bobRect,ladderRect1))
        
    {
        CCLOG(@"!!!!!!BOB INTERSECT LADDER1!!!!!");
        //bobSprite.opacity = 0;
        CCLOG(@" %f ",bobSprite.position.y);
        CCLOG(@" %f ",screen.height*0.265);
        
        if(bobSprite.position.y < screen.height*0.3)
        {
            bobSprite.position = ccp(bobSprite.position.x,screen.height*0.5);
        }
        else if(bobSprite.position.y > screen.height*0.3)
        {
            bobSprite.position = ccp(bobSprite.position.x,screen.height*0.265);
        }
        
    }
    
    if(CGRectIntersectsRect(bobRect,ladderRect2))
        
    {
        CCLOG(@"!!!!!!BOB INTERSECT LADDER2!!!!!");
        //bobSprite.opacity = 0;
        if(bobSprite.position.y < screen.height*0.3)
        {
            bobSprite.position = ccp(bobSprite.position.x,screen.height*0.5);
        }
        else if(bobSprite.position.y > screen.height*0.3)
        {
            bobSprite.position = ccp(bobSprite.position.x,screen.height*0.265);
        }
    }
    
}

#pragma mark ---- BOB DIED ----
-(void)bobDiedAnimation:(ccTime)delta
{
    self.isTouchEnabled = NO;
    dieTime += delta;
    dieFloat = (float)dieTime;
    
    bobSprite.scale = 1 + 1*dieFloat*1.5;
    bobSprite.rotation +=11;
    
    if(dieFloat == 0.7)
    {
        dieFloat = 0.7;
    }
    if (dieFloat < 0.7)
    {
        //dieFloat = 1;
        bobSprite.opacity = 255 - 255*dieFloat*1.423;
    }
    
    
    //[dieTimeLabel setString:[NSString stringWithFormat:@"%0.2f", dieFloat]];
    
    if(dieTime > 1.1-0.3)
    {
        [self unschedule:@selector(bobDiedAnimation:)];
        
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_4 node]]];
    }
}

-(void)explosionEffect
{
    //------------------- EXPLOTION EFFECT ---------------------
    explosion = [CCParticleExplosion node];
    explosion.position = explosionPosition;
    explosion.texture = 
    [[CCTextureCache sharedTextureCache]addImage:@"bomb_particle.png"];
    //explosion.color = ccBLACK;
    //[explosion setStartColor:ccc3(255, 255, 255)];
    [explosion setDuration:0.01];
    [explosion setTotalParticles:40];
    [explosion setStartSize:1];
    [explosion setEndSize:0.1];
    ccColor4F startColor;
    startColor.r = 255.f;
    startColor.g = 255.f;
    startColor.b = 255.f;
    startColor.a = 1.f;
    
    ccColor4F endColor;
    endColor.r = 0.f;
    endColor.g = 0.f;
    endColor.b = 0.f;
    endColor.a = 0.f;
    
    [explosion setScale:0.5];
    
    [explosion setStartColor:startColor];
    [explosion setEndColor:endColor];
    
    //[explosion setGravity:ccp(0,-50)];
    
    [explosion setSpeed:200];
    [explosion setLife:0.001];
    
    [self addChild:explosion];
}



@end
