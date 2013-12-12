//
//  Level_1.m
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_1.h"
#import "Level_2.h"

@implementation Level_1

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_1 *layer = [Level_1 node];
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
        screenSize = [CCDirector sharedDirector].winSize;
           self.isTouchEnabled = YES;
        
        //------------------- LEVEL BACKGROUND -----------------
        backgroundSprite = [CCSprite spriteWithFile:@"level_1.png"];
        backgroundSpriteHeight = [backgroundSprite contentSize].height;
        backgroundSprite.position = ccp(screenSize.width/2,backgroundSpriteHeight/2);
        [self addChild:backgroundSprite z:0];
        
        //------------------------- BOB -------------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        bobSpriteWidth = [bobSprite contentSize].width;
        bobSprite.position = ccp(-bobSpriteWidth/2,screenSize.height*0.315);
        [self addChild:bobSprite z:10];
        //----------------------- BOB ANIMATION ------------------------
        CCAnimation *bobAnim = [CCAnimation animation];
        [bobAnim addFrameWithFilename:@"bob_anim_1.png"]; 
        [bobAnim addFrameWithFilename:@"bob_anim_3.png"]; 
        
        id bobAnimationAction = [CCAnimate actionWithDuration:0.5f
                                                    animation:bobAnim
                                         restoreOriginalFrame:YES];
        id repeatBobAnimationAction = 
        [CCRepeatForever actionWithAction:bobAnimationAction];
        [bobSprite runAction:repeatBobAnimationAction];
        
        //------------------------------ RAT ---------------------------------
        ratSprite = [CCSprite spriteWithFile:@"rat_anim_1.png"];
        float ratSpriteWidth = [ratSprite contentSize].width;
        ratSprite.position = ccp(screenSize.width+ratSpriteWidth,screenSize.height*0.33);
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
        
        //-------------------------------- TORCH (FIRE) -------------------------------
        torchSprite = [CCSprite spriteWithFile:@"fire_anim_1.png"];
        torchSprite.position = ccp(screenSize.width*0.925,screenSize.height*0.4);
        torchSprite.scale = 0.9;
        //torchSprite.opacity = 100;
        [self addChild:torchSprite z:5];
        
        fireBackgroundSprite = [CCSprite spriteWithFile:@"fire_background.png"];
        fireBackgroundSprite.position = ccp(screenSize.width*0.925,screenSize.height*0.4);
        fireBackgroundSprite.scale = 1.2;
        [self addChild:fireBackgroundSprite z:1];
        
        fireLightSprite = [CCSprite spriteWithFile:@"fire_light.png"];
        fireLightSprite.position = ccp(screenSize.width*0.925,screenSize.height*0.4);
        fireLightSprite.opacity = 100;
        fireLightSprite.scale = 1;
        //[self addChild:fireLightSprite z:4];
        
        fireLightSprite1 = [CCSprite spriteWithFile:@"fire_light.png"];
        fireLightSprite1.position = ccp(screenSize.width*0.925,screenSize.height*0.4);
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
        
        //----------------------- TIME LABEL -----------------------
        timeLabel = [CCLabelTTF labelWithString:@"%f" fontName:@"Marker Felt" fontSize:20];
        timeLabel.position = ccp(screenSize.width/2,screenSize.height*3/4);
        [self addChild:timeLabel z:100];
        
        //----------------------- BUMERANG --------------------------
        bumerangSprite = [CCSprite spriteWithFile:@"bumerang.png"];
        [self addChild:bumerangSprite z:20];
        
        accelBumerang = 1;
        decelBumerang = 1;
        //currentTime = 0;
        totalTime = 0;
        
        bumerangDirection = NO;
        
        [self schedule:@selector(bobRunningUpdate)];
        [self schedule:@selector(updateBumerang)];
        [self schedule:@selector(shootBumerang)];
        [self schedule:@selector(bumerangRotateUpdate)];
        
        
        [self schedule:@selector(ratFlyingUpdate)];
        [self schedule:@selector(ratFlyUp)];
        
        [self schedule:@selector(ratCollideBob)];
        
        [self schedule:@selector(fireUpdate:)];
        
        
    }
    return self;
}

-(void)bobRunningUpdate
{
    screenSize = [CCDirector sharedDirector].winSize;
  
    bobSprite.position = ccp(bobSprite.position.x + 100*0.016, bobSprite.position.y);
    
    if(bobSprite.position.x > screenSize.width+bobSpriteWidth/2)
    {
        [self unschedule:@selector(bobRunningUpdate)];
        [self unschedule:@selector(updateBumerang)];
        
        [[CCDirector sharedDirector] sendCleanupToScene];
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_2 node]]];
    }
}

-(void)ratCollideBob
{
    //CCLOG(@"inside didCollide!!!");
    CGRect bobRect = [bobSprite boundingBox];
    CGRect ratRect = [ratSprite boundingBox];
    
    if(CGRectIntersectsRect(bobRect, ratRect))
    {
        bumerangSprite.visible = 0;
        
        //[self bobDied];
        [self schedule:@selector(bobDiedAnimation:) ];
        [self restartWithDelay];
        [self unschedule:@selector(bobRunningUpdate)];
        [self unschedule:@selector(ratCollideBob)];
    }
}


#pragma mark --- BUMERANG METHODS ---
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //sif([shootBumerang activate])
    [self bumerangFinalFlyPosition];
    [self unschedule:@selector(updateBumerang)];
    [self schedule:@selector(shootBumerang)];
    [self schedule:@selector(bumerangRotateUpdate)];
    
}

-(void)updateBumerang
{
    bumerangSprite.position = ccp(bobSprite.position.x+15,bobSprite.position.y-5);
}

-(float)bumerangFinalFlyPosition
{
    finalBumerangPosX =  (float)bumerangSprite.position.x+115;
    //CCLOG(@"CURRENT POS %f %f",currentPosX,currentPosX+515);
}

-(void)shootBumerang
{
    self.isTouchEnabled = NO;
    bumerangDirection = YES;
    //[self bumerangSound];
    
    bumerangSprite.position = ccp(bumerangSprite.position.x+100*0.03,bumerangSprite.position.y);
    
    //CCLOG(@"BUMERANG POS %f", bumerangSprite.position.x);
    CCLOG(@"GOAL POS %f", finalBumerangPosX);
    
    bumerangSprite.scale = 2.5;
    CGRect bumerangRect = [bumerangSprite boundingBox];
    bumerangSprite.scale = 1;
    CGRect ratRect = [ratSprite boundingBox];
    if(CGRectIntersectsRect(bumerangRect, ratRect))
    {
        //CCLOG(@"COLLIDE COLLIDE!!!");
        // [self unschedule:@selector(ratFlyingUpdate)];
        
        
        //[self ratDied];
        [self schedule:@selector(ratDiedAnimation:)];
        
        //ratSprite.visible = 0;
        
        [self unschedule:@selector(ratCollideBob)];
        //    [self soundRatDied];
        
        //bumerangSprite.visible = 0;
    }
    
    if(bumerangSprite.position.x > finalBumerangPosX)
    {
        //CCLOG(@"BUMERANG BACK");
        [self unschedule:@selector(shootBumerang)];
        [self schedule:@selector(returnBumerang)];
        
        accelBumerang = 1;
        accelRotateBum = 1;
        decelRotateBum = 1;
    }
}


-(void)returnBumerang
{
    bumerangDirection = NO;
    
    accelBumerang *= 1.03;
    bumerangSprite.position = ccp(bumerangSprite.position.x-100*0.03*accelBumerang,bumerangSprite.position.y);
    
    bobSprite.scaleX = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    CGRect bumerangRect = [bumerangSprite boundingBox];
    
    if(CGRectIntersectsRect(bobRect, bumerangRect))
    {
        CCLOG(@"BOB BUMERANG");
        [self unschedule:@selector(returnBumerang)];
        [self schedule:@selector(updateBumerang)];
        [self unschedule:@selector(bumerangRotateUpdate)];
        bumerangSprite.rotation = 0;
        self.isTouchEnabled = YES;
    }
} 

-(void)bumerangRotateUpdate
{
    accelRotateBum *= 1.025;
    decelRotateBum *= 1.002;
    if(bumerangDirection == YES)
    {
        bumerangSprite.rotation +=10*accelRotateBum;
    }
    else if(bumerangDirection == NO)
    {
        bumerangSprite.rotation +=10/decelRotateBum;
    }
}

#pragma mark -- RAT MOVING METHODS --

-(void)ratFlyingUpdate
{
    //screenSize = [CCDirector sharedDirector].winSize;
    float ratSpriteWidth = [ratSprite contentSize].width;
    
    ratSprite.position = ccp(ratSprite.position.x - 100*0.01, ratSprite.position.y);
    
    //[self schedule:@selector(ratFlyUp)];
    
    if(ratSprite.position.x < ratSpriteWidth)
    {
        ratSprite.position = ccp(screenSize.width,ratSprite.position.y);
    }
}

-(void)ratFlyUp
{
    ratSprite.position = ccp(ratSprite.position.x, ratSprite.position.y + 100*0.003);
    if(ratSprite.position.y > screenSize.height*0.36)
    {
        [self unschedule:@selector(ratFlyUp)];
        [self schedule:@selector(ratFlyDown)];
        
    }
}

-(void)ratFlyDown
{
    
    ratSprite.position = ccp(ratSprite.position.x, ratSprite.position.y - 100*0.005);
    if(ratSprite.position.y < screenSize.height*0.30)
    {
        [self unschedule:@selector(ratFlyDown)];
        [self schedule:@selector(ratFlyUp)];
        
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

#pragma mark --- LAST METHODS ---

/*-(void)bobDied
{
    
    id spawnAction = 
    [CCSpawn actions:
     [CCRotateBy actionWithDuration:1 angle:360],
     [CCScaleBy actionWithDuration:1 scale:3],
     [CCFadeOut actionWithDuration:1],
     nil];
    [bobSprite runAction:spawnAction];
}
 */
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
         [CCTransitionFade transitionWithDuration:1 scene:[Level_1 node]]];
    }
}

-(void)ratDiedAnimation:(ccTime)delta
{
    
    dieTime1 += delta;
    dieFloat1 = (float)dieTime1;
    
    ratSprite.scale = 1 + 1*dieFloat1*1.5;
    ratSprite.rotation +=12 ;
    if (dieFloat1 < 1)
    {
        //dieFloat = 1;
        ratSprite.opacity = 255 - 255*dieFloat1;
    }
    
    
    //[dieTimeLabel setString:[NSString stringWithFormat:@"%0.2f", dieFloat]];
    
    if(dieTime > 1.1)
    {
        [self unschedule:@selector(ratDiedAnimation:)];
        
        //[[CCDirector sharedDirector]replaceScene:
        // [CCTransitionFade transitionWithDuration:1 scene:[Level_1 node]]];
    }
}

/*-(void)ratDied
{
    
    id spawnAction = 
    [CCSpawn actions:
     [CCRotateBy actionWithDuration:0.5 angle:360],
     [CCScaleBy actionWithDuration:0.5 scale:3],
     [CCFadeOut actionWithDuration:0.5],
     nil];
    [ratSprite runAction:spawnAction];
}*/

-(void)restartLevel
{
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:0.5 scene:[Level_1 node]]];
}

-(void)restartWithDelay
{
    id callDelay =[CCDelayTime actionWithDuration:1.1];
    id callrestartLevel =[CCCallFunc actionWithTarget:self selector:@selector(restartLevel)];
    id sequenceMethod =
    [CCSequence actions: callDelay,callrestartLevel, nil];
    [bobSprite runAction:sequenceMethod];
}



-(void)Method
{
    id callBobDied = [CCCallFunc actionWithTarget:self selector:@selector(bobDied)];
    id callrestartLevel =[CCCallFunc actionWithTarget:self selector:@selector(restartLevel)];
    id sequenceMethod =
    [CCSequence actions: callBobDied,callrestartLevel, nil];
}



@end
