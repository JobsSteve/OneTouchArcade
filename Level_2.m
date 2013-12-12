//
//  Level_2.m
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_2.h"
#import "Level_3.h"

@implementation Level_2

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_2 *layer = [Level_2 node];
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
        
        //------------------- LEVEL BACKGROUND -----------------
        backgroundSprite = [CCSprite spriteWithFile:@"level_2.png"];
        backgroundSpriteHeight = [backgroundSprite contentSize].height;
        backgroundSprite.position = ccp(screen.width/2,backgroundSpriteHeight/2);
        [self addChild:backgroundSprite z:0];
       // backgroundSprite.opacity = 200;
        
        /*//------------------- LEVEL EARTH -----------------
        earthSprite = [CCSprite spriteWithFile:@"level_9_earth.png"];
        earthSprite.anchorPoint = ccp(0,0);
        //earthSprite.position = ccp(0,0);
        [self addChild:earthSprite z:1];
        */
        
        //---------------------- EARTH 1 & EARTH 2 --------------------------
        earthSprite1 = [CCSprite spriteWithFile:@"level_2_earth_1.png"];
        earthSprite1.position = 
        ccp([earthSprite1 contentSize].width/2,[earthSprite1 contentSize].height/2+2);
        [self addChild: earthSprite1];
        
        earthSprite2 = [CCSprite spriteWithFile:@"level_2_earth_2.png"];
        float earthSprite2Width = [earthSprite2 contentSize].width;
        earthSprite2.opacity = 105;
        earthSprite2.position = 
        ccp(screen.width - earthSprite2Width/2,[earthSprite2 contentSize].height/2);
        [self addChild: earthSprite2];
        
        //------------------------- BOB -------------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        bobSpriteWidth = [bobSprite contentSize].width;
        bobSprite.position = ccp(bobSpriteWidth/2,screen.height*0.265);
        [self addChild:bobSprite z:10];
      /*  //----------------------- BOB ANIMATION ------------------------
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
        
        [self schedule:@selector(bobRunningUpdate)];
        
         //[self schedule:@selector(bobEarthCollide)];
        
        
    }
    return self;
}

/*-(void)bobCollideEarth
{
    bobSprite.scale = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scale = 1;
   
    CGRect earthRect1 = [earthSprite1 boundingBox];
    CGRect earthRect2 = [earthSprite2 boundingBox];
    
    if([bobSprite numberOfRunningActions] == 0)
    {
        CCLOG(@"NUMBER OF RUNNIG ACTIONS == 0");
        if(CGRectIntersectsRect(bobRect, earthRect1)||
           CGRectIntersectsRect(bobRect, earthRect2))
        {
            CCLOG(@"BOB intersect EARTH1 or EARTH2");
        }
        else
        {
            CCLOG(@"BOB DIED!!! - NOT INTERSECT!!! ");
            bobSprite.opacity = 100;
            [[CCDirector sharedDirector] replaceScene:
             [CCTransitionFade transitionWithDuration:0.5 scene:[Level_2 scene]]];
        }
    }
}
 */

-(void)bobRunningUpdate
{
    //CCLOG(@"inside runningBobUpdate!!!");
    screenSize = [CCDirector sharedDirector].winSize;
    
    if(bobSprite.position.x > bobSpriteWidth)
    {
        [self schedule:@selector(bobEarthCollide)];
    }
    
    
    bobSprite.position = ccp(bobSprite.position.x + 100*0.016, bobSprite.position.y);
    frameBarSprite.position = ccp(bobSprite.position.x + 100*0.016, bobSprite.position.y+50);
    progressTimer.position = ccp(bobSprite.position.x + 100*0.016, bobSprite.position.y+50);
    
    if(bobSprite.position.x > screenSize.width)
    {
        [self unschedule:@selector(bobRunningUpdate)];
        [self unschedule:@selector(bobEarthCollide)];
        [[CCDirector sharedDirector] sendCleanupToScene];
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_3 node]]];
    }
}

-(void)bobEarthCollide
{
    bobSprite.scaleX = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    
    CGRect earthRect1 = [earthSprite1 boundingBox];
    CGRect earthRect2 = [earthSprite2 boundingBox];
    
    if([bobSprite numberOfRunningActions] == 0)
    {
        CCLOG(@"NUMBER OF RUNNIG ACTIONS == 0");
        if(CGRectIntersectsRect(bobRect, earthRect1)||
           CGRectIntersectsRect(bobRect, earthRect2))
        {
            CCLOG(@"BOB intersect EARTH1 or EARTH2");
        }
        else
        {
            CCLOG(@"BOB DIED!!! - NOT INTERSECT!!! ");
            bobSprite.opacity = 100;
            [[CCDirector sharedDirector] replaceScene:
             [CCTransitionFade transitionWithDuration:0.5 scene:[Level_2 node]]];
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
    id jumpBob = [CCJumpBy actionWithDuration:currentTime*1.6+0.15 position:ccp(250*jump,0) height:150*jump jumps:1];
    [bobSprite runAction:jumpBob];
    
     //[self schedule:@selector(bobEarthCollide) interval:0.5];
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self jumpFunction];
    
    //  self.isTouchEnabled = NO;
    //  [self schedule:@selector(bobCollideEarth)];
    
    
    bobSprite.scale = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    bobSprite.scaleY = 1;
    
    CGRect earthRect1 = [earthSprite1 boundingBox];
    CGRect earthRect2 = [earthSprite2 boundingBox];
    
    if(CGRectIntersectsRect(bobRect, earthRect1)||
       CGRectIntersectsRect(bobRect, earthRect2))
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




@end
