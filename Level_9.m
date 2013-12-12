//
//  Level_9.m
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_9.h"
#import "Level_10.h"

@implementation Level_9

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_9 *layer = [Level_9 node];
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
        backgroundSprite = [CCSprite spriteWithFile:@"level_9.png"];
        backgroundSpriteHeight = [backgroundSprite contentSize].height;
        backgroundSprite.position = ccp(screenSize.width/2,backgroundSpriteHeight/2);
        [self addChild:backgroundSprite z:0];
        //backgroundSprite.opacity = 200;
        
        //------------------- UPSIDE -----------------
        upsideSprite = [CCSprite spriteWithFile:@"level_19_upside.png"];
        upsideSprite.anchorPoint = ccp(0,1);
        upsideSprite.position = ccp(0,screenSize.height-3);
        [self addChild:upsideSprite z:110];
        
        //------------------------- SPIDER -------------------------
        spiderSprite = [CCSprite spriteWithFile:@"spider.png"];
        spiderSprite.position = ccp(screenSize.width*1/4,screenSize.height*0.9);
        [self addChild:spiderSprite z:100];
        //------------------------- SPIDER ZONE -------------------------
        spiderZoneSprite = [CCSprite spriteWithFile:@"spider_zone.png"];
        spiderZoneSprite.position = ccp(screenSize.width*1/4,screenSize.height*0.9);
        [self addChild:spiderZoneSprite z:-1];
        //spiderZoneSprite.opacity = 0;
        
        //------------------------- SPIDER2 -------------------------
        spiderSprite2 = [CCSprite spriteWithFile:@"spider.png"];
        spiderSprite2.position = ccp(screenSize.width*3/4,screenSize.height*0.9);
        [self addChild:spiderSprite2 z:100];
        //------------------------- SPIDER2 ZONE -------------------------
        spiderZoneSprite2 = [CCSprite spriteWithFile:@"spider_zone.png"];
        spiderZoneSprite2.position = ccp(screenSize.width*3/4,screenSize.height*0.9);
        [self addChild:spiderZoneSprite2 z:-1];
        //spiderZoneSprite2.opacity = 0;
        
        //------------------------- BOB -------------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        bobSpriteWidth = [bobSprite contentSize].width;
        bobSprite.position = ccp(-bobSpriteWidth*2,screenSize.height*0.265);
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
        //float ratSpriteHeight = [bobSprite contentSize].height;
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
        
        
        //----------------------- TIME LABEL -----------------------
        timeLabel = [CCLabelTTF labelWithString:@"%f" fontName:@"Marker Felt" fontSize:20];
        timeLabel.position = ccp(screenSize.width/2,screenSize.height*99/100);
       // [self addChild:timeLabel z:100];
        
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
        
        //[self schedule:@selector(fireUpdate:)];
        [self schedule:@selector(bobSpiderReactionZone)];
        [self schedule:@selector(bobSpiderReactionZone2)];
       
        
        
    }
    return self;
}
-(void)bobSpiderReactionZone2
{
    CGRect bobRect = [bobSprite boundingBox];
    spiderZoneSprite2.scaleX = 5;
    spiderZoneSprite2.scaleY = 10;
    CGRect spiderZoneRect2 = [spiderZoneSprite2 boundingBox];
    
     if(CGRectIntersectsRect(bobRect, spiderZoneRect2))
    {
        
        [self schedule:@selector(getSpiderDown2)];
        [self unschedule:@selector(bobSpiderReactionZone2)];
    }
}
-(void)bobSpiderReactionZone
{
    CGRect bobRect = [bobSprite boundingBox];
    spiderZoneSprite.scaleX = 5;
    spiderZoneSprite.scaleY = 10;
    CGRect spiderZoneRect = [spiderZoneSprite boundingBox];
    
    
    
    if(CGRectIntersectsRect(bobRect, spiderZoneRect))
    {
        
         [self schedule:@selector(getSpiderDown)];
         [self unschedule:@selector(bobSpiderReactionZone)];
    }
  
    
    
}

-(void)getSpiderDown
{
    
    spiderSprite.position = ccp(spiderSprite.position.x,spiderSprite.position.y-4);
    
    if(spiderSprite.position.y < screenSize.height*0.47)
    {
        [self unschedule:@selector(getSpiderDown)];
        
    }
}

-(void)getSpiderUp
{
    
    spiderSprite.position = ccp(spiderSprite.position.x,spiderSprite.position.y+5);
    
    if(spiderSprite.position.y > screenSize.height*0.9)
    {
        [self unschedule:@selector(getSpiderUp)];
        
    }
}

-(void)getSpiderDown2
{
    
    spiderSprite2.position = ccp(spiderSprite2.position.x,spiderSprite2.position.y-4);
    
    if(spiderSprite2.position.y < screenSize.height*0.47)
    {
        [self unschedule:@selector(getSpiderDown2)];
        
    }
}
-(void)getSpiderUp2
{
    
    spiderSprite2.position = ccp(spiderSprite2.position.x,spiderSprite2.position.y+5);
    
    if(spiderSprite2.position.y > screenSize.height*0.9)
    {
        [self unschedule:@selector(getSpiderUp2)];
        
    }
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
         [CCTransitionFade transitionWithDuration:1 scene:[Level_10 node]]];
    }
}

-(void)ratCollideBob
{
    //CCLOG(@"inside didCollide!!!");
    bobSprite.scale = 0.3;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scale = 1;
    CGRect ratRect = [ratSprite boundingBox];
    CGRect spiderRect = [spiderSprite boundingBox];
    CGRect spiderRect2 = [spiderSprite2 boundingBox];
    
    if((CGRectIntersectsRect(bobRect, ratRect))||
        (CGRectIntersectsRect(bobRect, spiderRect))||
        (CGRectIntersectsRect(bobRect, spiderRect2)))
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
    
    bumerangSprite.scale = 0.5;
    CGRect bumerangRect = [bumerangSprite boundingBox];
    bumerangSprite.scale = 1;
    CGRect ratRect = [ratSprite boundingBox];
    CGRect spiderRect = [spiderSprite boundingBox];
    CGRect spiderRect2 = [spiderSprite2 boundingBox];
    if(CGRectIntersectsRect(spiderRect, bumerangRect))
    {
        [self schedule:@selector(getSpiderUp)];
    }
    if(CGRectIntersectsRect(spiderRect2, bumerangRect))
    {
        [self schedule:@selector(getSpiderUp2)];
    }
    
    if(CGRectIntersectsRect(bumerangRect, ratRect))
    {
        [self schedule:@selector(ratDiedAnimation:)];
        [self unschedule:@selector(ratCollideBob)];
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
    if(ratSprite.position.y > screenSize.height*0.32)
    {
        [self unschedule:@selector(ratFlyUp)];
        [self schedule:@selector(ratFlyDown)];
        
    }
}

-(void)ratFlyDown
{
    
    ratSprite.position = ccp(ratSprite.position.x, ratSprite.position.y - 100*0.005);
    if(ratSprite.position.y < screenSize.height*0.27)
    {
        [self unschedule:@selector(ratFlyDown)];
        [self schedule:@selector(ratFlyUp)];
        
    }
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
    
    if(dieTime > 1.1)
    {
        [self unschedule:@selector(bobDiedAnimation:)];
        
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_9 node]]];
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

-(void)restartLevel
{
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:0.5 scene:[Level_9 node]]];
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