//
//  Level_15.m
//  GameplayPrototype30
//
//  Created by Артур on 13.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_15.h"
#import "Level_17.h"

@implementation Level_15

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_15 *layer = [Level_15 node];
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
        
        //------------------- LEVEL BACKGROUND -----------------
        backgroundSprite = [CCSprite spriteWithFile:@"level_8.png"];
        backgroundSpriteHeight = [backgroundSprite contentSize].height;
        backgroundSprite.position = ccp(screen.width/2,backgroundSpriteHeight/2);
        [self addChild:backgroundSprite z:0];
        
        //------------------------- BOB -------------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        bobSpriteWidth = [bobSprite contentSize].width;
        //bobSpriteHeight = [bobSprite contentSize].height;
        bobSprite.position = ccp(-bobSpriteWidth/2,screen.height*0.615);
        [self addChild:bobSprite z:10];
        //----------------------- BOB ANIMATION ------------------------
        CCAnimation *bobAnim = [CCAnimation animation];
        [bobAnim addFrameWithFilename:@"bob_anim_1.png"]; 
        [bobAnim addFrameWithFilename:@"bob_anim_2.png"]; 
        
        id bobAnimationAction = [CCAnimate actionWithDuration:0.35f
                                                    animation:bobAnim
                                         restoreOriginalFrame:YES];
        id repeatBobAnimationAction = 
        [CCRepeatForever actionWithAction:bobAnimationAction];
        [bobSprite runAction:repeatBobAnimationAction];
        
        //------------------------- BRICK ------------------------
        brickSprite = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite.position = ccp(bobSprite.position.x - bobSpriteWidth/2, bobSprite.position.y -bobSpriteHeight/2);
        [self addChild:brickSprite z:9];
        
        //------------------------------ RAT ---------------------------------
        ratSprite = [CCSprite spriteWithFile:@"rat_anim_1.png"];
        float ratSpriteWidth = [ratSprite contentSize].width;
        //float ratSpriteHeight = [bobSprite contentSize].height;
        ratSprite.position = ccp(screen.width*3/3,screen.height*0.4);
        [self addChild:ratSprite z:11];
        //------------------------- RAT ANIMATION ---------------------------
        CCAnimation *ratAnim = [CCAnimation animation];
        [ratAnim addFrameWithFilename:@"rat_anim_1.png"];
        [ratAnim addFrameWithFilename:@"rat_anim_2.png"];
        
        id ratAnimationAction = [CCAnimate actionWithDuration:0.3f
                                                    animation:ratAnim
                                         restoreOriginalFrame:YES];
        id repeatRatAnimationAction = 
        [CCRepeatForever actionWithAction:ratAnimationAction];
        [ratSprite runAction:repeatRatAnimationAction];
        
        //------------------------------ RAT2 ---------------------------------
        ratSprite2 = [CCSprite spriteWithFile:@"rat_anim_1.png"];
        float ratSpriteWidth2 = [ratSprite2 contentSize].width;
        //float ratSpriteHeight = [bobSprite contentSize].height;
        ratSprite2.position = ccp(screen.width*4/3,screen.height*0.5);
        [self addChild:ratSprite2 z:11];
        //------------------------- RAT2 ANIMATION ---------------------------
        CCAnimation *ratAnim2 = [CCAnimation animation];
        [ratAnim2 addFrameWithFilename:@"rat_anim_1.png"];
        [ratAnim2 addFrameWithFilename:@"rat_anim_2.png"];
        
        id ratAnimationAction2 = [CCAnimate actionWithDuration:0.3f
                                                    animation:ratAnim2
                                         restoreOriginalFrame:YES];
        id repeatRatAnimationAction2 = 
        [CCRepeatForever actionWithAction:ratAnimationAction2];
        [ratSprite2 runAction:repeatRatAnimationAction2];
        
        //------------------------------ RAT3 ---------------------------------
        ratSprite3 = [CCSprite spriteWithFile:@"rat_anim_1.png"];
        float ratSpriteWidth3 = [ratSprite3 contentSize].width;
        //float ratSpriteHeight = [bobSprite contentSize].height;
        ratSprite3.position = ccp(screen.width*5/3,screen.height*0.3);
        [self addChild:ratSprite3 z:11];
        //------------------------- RAT3 ANIMATION ---------------------------
        CCAnimation *ratAnim3 = [CCAnimation animation];
        [ratAnim3 addFrameWithFilename:@"rat_anim_1.png"];
        [ratAnim3 addFrameWithFilename:@"rat_anim_2.png"];
        
        id ratAnimationAction3 = [CCAnimate actionWithDuration:0.3f
                                                     animation:ratAnim3
                                          restoreOriginalFrame:YES];
        id repeatRatAnimationAction3 = 
        [CCRepeatForever actionWithAction:ratAnimationAction3];
        [ratSprite3 runAction:repeatRatAnimationAction3];
       
       
        
        //-------------------------------- TORCH (FIRE) -------------------------------
        torchSprite = [CCSprite spriteWithFile:@"fire_anim_1.png"];
        torchSprite.position = ccp(screen.width*1/3,screen.height*0.45);
        torchSprite.scale = 0.7;
        //torchSprite.opacity = 100;
        [self addChild:torchSprite z:5];
        
        fireBackgroundSprite = [CCSprite spriteWithFile:@"fire_background.png"];
        fireBackgroundSprite.position = ccp(screen.width*1/3,screen.height*0.45);
        fireBackgroundSprite.scale = 1.2;
        [self addChild:fireBackgroundSprite z:1];
        
        fireLightSprite = [CCSprite spriteWithFile:@"fire_light.png"];
        fireLightSprite.position = ccp(screen.width*1/3,screen.height*0.45);
        fireLightSprite.opacity = 100;
        fireLightSprite.scale = 1;
        //[self addChild:fireLightSprite z:4];
        
        fireLightSprite1 = [CCSprite spriteWithFile:@"fire_light.png"];
        fireLightSprite1.position = ccp(screen.width*1/3,screen.height*0.45);
        fireLightSprite1.opacity = 100;
        fireLightSprite1.scale = 1;
        [self addChild:fireLightSprite1 z:3];
        //----------------------------- FIRELIGHT ANIMATION -------------------------------
        CCAnimation *fireAnim = [CCAnimation animation];
        [fireAnim addFrameWithFilename:@"fire_anim_1.png"];
        [fireAnim addFrameWithFilename:@"fire_anim_2.png"];
        [fireAnim addFrameWithFilename:@"fire_anim_3.png"];
        [fireAnim addFrameWithFilename:@"fire_anim_4.png"];
        [fireAnim addFrameWithFilename:@"fire_anim_5.png"];
        [fireAnim addFrameWithFilename:@"fire_anim_4.png"];
        [fireAnim addFrameWithFilename:@"fire_anim_3.png"];
        [fireAnim addFrameWithFilename:@"fire_anim_2.png"];
        //[fireAnim addFrameWithFilename:@"fire_anim_1.png"];
        
        id fireAnimationAction = [CCAnimate actionWithDuration:0.7f
                                                     animation:fireAnim
                                          restoreOriginalFrame:YES];
        id repeatFireAnimationAction = 
        [CCRepeatForever actionWithAction:fireAnimationAction];
        [torchSprite runAction:repeatFireAnimationAction];
        
        
        flyingBOOL = YES;
        
        
        [self schedule:@selector(bobFlyingUpdate)];
        
        [self schedule:@selector(ratFlyingUpdate)];
        [self schedule:@selector(ratFlyUp)];
        [self schedule:@selector(ratCollideBob)];
        
        [self schedule:@selector(fireUpdate:)];
        
        
        
    }
    return self;
}

-(void)bobFlyingUpdate
{
    
    
    brickSprite.position = ccp(bobSprite.position.x, bobSprite.position.y -bobSpriteHeight/2-20);
    
    if(flyingBOOL == YES)
    {
        bobSprite.position = ccp(bobSprite.position.x + 1.2, bobSprite.position.y - 0.6);
    }
    
    if(flyingBOOL == NO)
    {
        bobSprite.position = ccp(bobSprite.position.x + 1.2, bobSprite.position.y + 0.6);
    }
    
    
    if(bobSprite.position.x > screen.width+bobSpriteWidth/2)
    {
        [[CCDirector sharedDirector] sendCleanupToScene];
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_17 node]]];
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(flyingBOOL == YES)
    {
        flyingBOOL = NO;
    }
    else
    {
        flyingBOOL = YES;
    }
}


#pragma mark -- RAT MOVING METHODS --

-(void)ratFlyingUpdate
{
    //screenSize = [CCDirector sharedDirector].winSize;
    float ratSpriteWidth = [ratSprite contentSize].width;
    
    ratSprite.position = ccp(ratSprite.position.x - 0.9, ratSprite.position.y);
     ratSprite2.position = ccp(ratSprite2.position.x - 0.9, ratSprite2.position.y);
     ratSprite3.position = ccp(ratSprite3.position.x - 0.9, ratSprite3.position.y);
    
    //[self schedule:@selector(ratFlyUp)];
    
    if(ratSprite.position.x < ratSpriteWidth)
    {
        ratSprite.position = ccp(screen.width,ratSprite.position.y);
    }
    
}

-(void)ratFlyUp
{
    ratSprite.position = ccp(ratSprite.position.x, ratSprite.position.y + 0.5);
    ratSprite2.position = ccp(ratSprite2.position.x, ratSprite2.position.y + 0.5);
    ratSprite3.position = ccp(ratSprite3.position.x, ratSprite3.position.y + 0.5);
    
    if((ratSprite.position.y > screen.height*0.48)||
       (ratSprite2.position.y > screen.height*0.58)||
       (ratSprite3.position.y > screen.height*0.38))
    {
        [self unschedule:@selector(ratFlyUp)];
        [self schedule:@selector(ratFlyDown)];
        
    }
}

-(void)ratFlyDown
{
    
    ratSprite.position = ccp(ratSprite.position.x, ratSprite.position.y - 0.5);
    ratSprite2.position = ccp(ratSprite2.position.x, ratSprite2.position.y - 0.5);
    ratSprite3.position = ccp(ratSprite3.position.x, ratSprite3.position.y - 0.5);
    
    if((ratSprite.position.y < screen.height*0.37)||
       (ratSprite2.position.y < screen.height*0.47)||
       (ratSprite3.position.y < screen.height*0.27))
    {
        [self unschedule:@selector(ratFlyDown)];
        [self schedule:@selector(ratFlyUp)];
        
    }
}

-(void)ratCollideBob
{
    //CCLOG(@"inside didCollide!!!");
    bobSprite.scale = 0.7;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scale = 1;
    CGRect ratRect = [ratSprite boundingBox];
    CGRect ratRect2 = [ratSprite2 boundingBox];
    CGRect ratRect3 = [ratSprite3 boundingBox];
    
    if(bobSprite.position.y > screen.height*0.65)
    {
        [self schedule:@selector(bobDiedAnimation:) ];
        //[self restartWithDelay];
        [self unschedule:@selector(bobFlyingUpdate)];
        [self unschedule:@selector(ratCollideBob)];
    }
    
    if(bobSprite.position.y < screen.height*0.25)
    {
        [self schedule:@selector(bobDiedAnimation:) ];
        //[self restartWithDelay];
        [self unschedule:@selector(bobFlyingUpdate)];
        [self unschedule:@selector(ratCollideBob)];
    }
    
    if((CGRectIntersectsRect(bobRect, ratRect))||
       (CGRectIntersectsRect(bobRect, ratRect2))||
        (CGRectIntersectsRect(bobRect, ratRect3)))
    {
        //bumerangSprite.visible = 0;
        
        //[self bobDied];
        brickSprite.opacity = 0;
        [self schedule:@selector(bobDiedAnimation:) ];
        //[self restartWithDelay];
        [self unschedule:@selector(bobFlyingUpdate)];
        [self unschedule:@selector(ratCollideBob)];
    }
}

-(void)bobDiedAnimation:(ccTime)delta
{
    self.isTouchEnabled = NO;
    dieTime += delta;
    dieFloat = (float)dieTime;
    
    bobSprite.scale = 1 + 1*dieFloat*1.5;
    bobSprite.rotation +=7 ;
    if (dieFloat < 1)
    {
        //dieFloat = 1;
        bobSprite.opacity = 255 - 255*dieFloat;
    }
    
    
    //[dieTimeLabel setString:[NSString stringWithFormat:@"%0.2f", dieFloat]];
    
    if(dieTime > 1.1)
    {
        [self unschedule:@selector(bobDiedAnimation:)];
        
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_15 node]]];
    }
}

#pragma mark -- TORCH METHODS --

-(void)fireUpdate:(ccTime)delta
{
    totalTime += delta;
    float currentTime = (float)totalTime;
    buffTime = 0;
    buffTime += currentTime;
    
    if(timeFloat != buffTime)
    {
        timeFloat = buffTime;
        [timeLabel setString:[NSString stringWithFormat:@"%0.2f",timeFloat]]; 
        
    }
    if(buffTime > 0.5)
    {
        //totalTime = 0;
        // currentTime = 0;
        //buffTime = 0;
        [self unschedule:@selector(fireUpdate:)];
        [self schedule:@selector(fireDown:)];
    }
    
    fireLightSprite1.scale = 1*buffTime/5 + 0.73;
    // fireLightSprite1.opacity = 200 - 100*buffTime;
}

-(void)fireDown:(ccTime)delta
{
    totalTime = 0;
    totalTime += delta;
    float currentTime = (float)totalTime;
    buffTime -=currentTime;
    if(timeFloat != buffTime)
    {
        timeFloat = buffTime;
        [timeLabel setString:[NSString stringWithFormat:@"%0.2f",timeFloat]];
    }    
    if(buffTime < 0)
    {
        //totalTime = 0;
        //currentTime = 0;
        // buffTime = 0;
        [self unschedule:@selector(fireDown:)];
        [self schedule:@selector(fireUpdate:)];
    }
    fireLightSprite1.scale = 1*buffTime/2 + 0.7;
    fireLightSprite1.opacity = 150 - 100*buffTime;
}



@end
