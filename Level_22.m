//
//  Level_22.m
//  GameplayPrototype30
//
//  Created by Артур on 16.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_22.h"
#import "Level_2.h"

@implementation Level_22

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_22 *layer = [Level_22 node];
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
        backgroundSprite = [CCSprite spriteWithFile:@"level_22.png"];
        backgroundSpriteHeight = [backgroundSprite contentSize].height;
        backgroundSprite.position = ccp(screen.width/2,backgroundSpriteHeight/2);
        [self addChild:backgroundSprite z:0];
        backgroundSprite.opacity = 0;
        
     
         
        
        //---------------------- EARTH 1 & EARTH 2 --------------------------
        earthSprite1 = [CCSprite spriteWithFile:@"level_22_earth_1.png"];
        earthSprite1.anchorPoint = ccp(0,0);
        earthSprite1.position = ccp(0,0);
      //  earthSprite1.opacity=0;
        [self addChild: earthSprite1 z:20];
        
        earthSprite2 = [CCSprite spriteWithFile:@"level_22_earth_3.png"];
        earthSprite2.anchorPoint = ccp(1,0);
        earthSprite2.position = ccp(screen.width,0);
        //earthSprite2.opacity = 0;
        [self addChild: earthSprite2 z:20];
        
        earthSprite3 = [CCSprite spriteWithFile:@"level_22_earth_2.png"];
        earthSprite3.anchorPoint = ccp(1,0);
        earthSprite3.position = ccp(screen.width/2,0);
        [self addChild: earthSprite3 z:20];
        
        //------------------------- BOB -------------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        bobSpriteWidth = [bobSprite contentSize].width;
        bobSprite.position = ccp(bobSpriteWidth/2,screen.height*0.265);
        [self addChild:bobSprite z:30];
        /* //----------------------- BOB ANIMATION ------------------------
         CCAnimation *bobAnim = [CCAnimation animation];
         [bobAnim addFrameWithFilename:@"bob_anim_1.png"]; 
         [bobAnim addFrameWithFilename:@"bob_anim_2.png"]; 
         
         id bobAnimationAction = [CCAnimate actionWithDuration:0.5f
         animation:bobAnim
         restoreOriginalFrame:YES];
         id repeatBobAnimationAction = 
         [CCRepeatForever actionWithAction:bobAnimationAction];
         [bobSprite runAction:repeatBobAnimationAction];
         */
        
        //------------------------- FRAME BAR -------------------------
        frameBarSprite = [CCSprite spriteWithFile:@"jump_frame_bar.png"];
        frameBarSprite.position = ccp(-bobSpriteWidth/2,screen.height*0.465);
        [self addChild:frameBarSprite z:10];
        
        //--------------------  JUMP BAR (progressTimer) ----------------
        progressTimer = [CCProgressTimer progressWithFile:@"jump_red_stripe.png"];
        progressTimer.type = kCCProgressTimerTypeHorizontalBarLR;
        progressTimer.scale = 0.9;
        progressTimer.percentage = 0;
        //  progressTimer.position = ccp(screen.width/2,screen.height/2);
        [self addChild:progressTimer z:11];
        
        //-------------------- LABEL (SENSITIVE JUMPING) -----------------------
        scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:15];
        scoreLabel.position = ccp(screen.width/2,screen.height*3/4);
        scoreLabel.opacity = 155;
        [self addChild:scoreLabel];
        
        //--------------------- TRAMPLINE -------------------------
        tramplineSprite = [CCSprite spriteWithFile:@"tramplin.png"];
        tramplineSprite.position = ccp(screen.width*7.5/10,screen.height*2/10+20-20);
        [self addChild:tramplineSprite z:10];
        //tramplineSprite.color = ccBLACK;
        //tramplineSprite.opacity = 100;
        
        //--------------------- TRAMPLINE 2 -------------------------
        tramplineSprite2 = [CCSprite spriteWithFile:@"tramplin.png"];
        tramplineSprite2.position = ccp(screen.width*9.5/10,screen.height*2/10+20-20);
        [self addChild:tramplineSprite2 z:10];
        
        [self schedule:@selector(bobRunningUpdate)];
        
        [self schedule:@selector(bobTramplineReaction)];
        [self schedule:@selector(bobTramplineCollide)];
        
        //[self schedule:@selector(bobEarthCollide)];
        
        
    }
    return self;
}

-(void)bobRunningUpdate
{
    //CCLOG(@"inside runningBobUpdate!!!");
   // screenSize = [CCDirector sharedDirector].winSize;
    
    if(bobSprite.position.x > bobSpriteWidth)
    {
        [self schedule:@selector(bobEarthCollide)];
    }
    
    
    bobSprite.position = ccp(bobSprite.position.x + 100*0.015, bobSprite.position.y);
    frameBarSprite.position = ccp(bobSprite.position.x + 100*0.016, bobSprite.position.y+50);
    progressTimer.position = ccp(bobSprite.position.x + 100*0.016, bobSprite.position.y+50);
    
    if(bobSprite.position.x > screen.width)
    {
        [[CCDirector sharedDirector] sendCleanupToScene];
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_2 node]]];
    }
}

-(void)bobEarthCollide
{
    bobSprite.scaleX = 0.3;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    
    CGRect earthRect1 = [earthSprite1 boundingBox];
    CGRect earthRect2 = [earthSprite2 boundingBox];
    CGRect earthRect3 = [earthSprite3 boundingBox];
    
    if([bobSprite numberOfRunningActions] == 0)
    {
        CCLOG(@"NUMBER OF RUNNIG ACTIONS == 0");
        if(CGRectIntersectsRect(bobRect, earthRect1)||
           CGRectIntersectsRect(bobRect, earthRect2)||
           CGRectIntersectsRect(bobRect, earthRect3))
        {
            CCLOG(@"BOB intersect EARTH1 or EARTH2");
        }
        else
        {
            CCLOG(@"BOB DIED!!! - NOT INTERSECT!!! ");
            bobSprite.opacity = 100;
            [[CCDirector sharedDirector] replaceScene:
             [CCTransitionFade transitionWithDuration:0.5 scene:[Level_22 node]]];
        }
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self schedule:@selector(sensitiveJumpingFunction:)];
    //[self unschedule:@selector(bobEarthCollide)];
    
}

-(void)sensitiveJumpingFunction:(ccTime)delta
{
    time +=delta;
    currentTime = (float)time;
    
    if(currentTime >= 0.3)
    {
        currentTime = 0.3;
    }
    
    progressTimer.percentage = currentTime*3*100+0.1;
    
    
    CCLOG(@" TIME %f",currentTime);
    
    [scoreLabel setString:[NSString stringWithFormat:@"%f",currentTime] ];
    
}

-(void)jumpFunction
{
    
    //float jump = (float)time+0.3;
    float jump = currentTime;
    id jumpBob = [CCJumpBy actionWithDuration:currentTime*1.6+0.15 position:ccp(260*jump,0) height:160*jump jumps:1];
    [bobSprite runAction:jumpBob];
    
    //[self schedule:@selector(bobEarthCollide) interval:0.5];
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self jumpFunction];
    
    //  self.isTouchEnabled = NO;
    //  [self schedule:@selector(bobCollideEarth)];
    
    
    bobSprite.scaleX = 0.5;
    //bobSprite.scaleY = 1;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    bobSprite.scaleY = 1;
    
    CGRect earthRect1 = [earthSprite1 boundingBox];
    CGRect earthRect2 = [earthSprite2 boundingBox];
    CGRect earthRect3 = [earthSprite3 boundingBox];
    
    if(CGRectIntersectsRect(bobRect, earthRect1)||
       CGRectIntersectsRect(bobRect, earthRect2)||
       CGRectIntersectsRect(bobRect, earthRect3))
    {
        CCLOG(@"BOB CAN JUMP");
        //[self jumpingFunction];
        [self jumpFunction];
        
    }
    else
    {
        
        CCLOG(@"NOT JUMP");
        //bobSprite.opacity = 100;
    }
    
    [self unschedule:@selector(sensitiveJumpingFunction:)];
    time=0;
    
}

#pragma mark ---------- TRAMPLINE METHODS ------------

-(void)tramplineAppear:(ccTime)delta;
{
    trampTime += delta;
    tramptime = (float)trampTime;
    if(tramptime > 2)
        tramptime = 2;
        
        if(tramplineSprite.position.y >= screen.height*0.26)
        {
            trampTime = 0;
            tramptime = 0;
            tramplineSprite.position = ccp(tramplineSprite.position.x,screen.height*0.26);
            [self unschedule:@selector(tramplineAppear:)];
        }
    tramplineSprite.position = ccp(tramplineSprite.position.x,tramplineSprite.position.y + 0.9);
}

-(void)tramplineAppear2:(ccTime)delta;
{
    trampTime += delta;
    tramptime = (float)trampTime;
    if(tramptime > 2)
        tramptime = 2;
    
    if(tramplineSprite2.position.y >= screen.height*0.26)
    {
        tramplineSprite2.position = ccp(tramplineSprite2.position.x,screen.height*0.26);
        [self unschedule:@selector(tramplineAppear2:)];
    }
    tramplineSprite2.position = ccp(tramplineSprite2.position.x,tramplineSprite2.position.y + 0.9);
}


-(void)bobTramplineReaction
{
    CGRect bobRect = [bobSprite boundingBox];
    
    tramplineSprite.scale = 8;
    CGRect trampRect = [tramplineSprite boundingBox];
    tramplineSprite.scale = 1;
    
    tramplineSprite2.scale = 8;
    CGRect trampRect2 = [tramplineSprite2 boundingBox];
    tramplineSprite2.scale = 1;
    
    if(CGRectIntersectsRect(bobRect, trampRect))
    {
        //[self unschedule:@selector(bobTramplineReaction)];
        [self trampFunction];
    }
    
    if(CGRectIntersectsRect(bobRect, trampRect2))
    {
        //[self unschedule:@selector(bobTramplineReaction)];
        [self trampFunction2];
    }
    
}

-(void)trampFunction
{
    [self schedule:@selector(tramplineAppear:)];
}

-(void)trampFunction2
{
    [self schedule:@selector(tramplineAppear2:)];
}

-(void)bobTramplineCollide
{
    bobSprite.scale = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scale = 1;
    
    
    CGRect trampRect = [tramplineSprite boundingBox];
     CGRect trampRect2 = [tramplineSprite2 boundingBox];
    tramplineSprite.scale = 1;
    
    if(CGRectIntersectsRect(bobRect, trampRect)||CGRectIntersectsRect(bobRect, trampRect2))
    {
        //bobSprite.opacity = 0;
        
        
        [self schedule:@selector(bobDiedAnimation:)];
        [self unschedule:@selector(bobRunningUpdate)];
        [self unschedule:@selector(bobEarthCollide)];
        frameBarSprite.opacity = 0;
        progressTimer.percentage = 0;
        [self unschedule:@selector(jumpFunction)];
        [self unschedule:@selector(bobTramplineCollide)];
        
        
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
    
    if(dieTime > 1.1)
    {
        [self unschedule:@selector(bobDiedAnimation:)];
        
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_22 node]]];
    }
}

@end