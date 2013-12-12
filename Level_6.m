//
//  Level_6.m
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_6.h"
#import "Level_7.h"

@implementation Level_6

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_6 *layer = [Level_6 node];
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
        backgroundSprite = [CCSprite spriteWithFile:@"level_7.png"];
        backgroundSpriteHeight = [backgroundSprite contentSize].height;
        backgroundSprite.position = ccp(screen.width/2,backgroundSpriteHeight/2);
        [self addChild:backgroundSprite z:0];
        
        //---------------------- EARTH 1 & EARTH 2 --------------------------
        earthSprite1 = [CCSprite spriteWithFile:@"level_7_earth_1.png"];
        earthSprite1.position = 
        ccp([earthSprite1 contentSize].width/2,[earthSprite1 contentSize].height/2+2);
        [self addChild: earthSprite1];
        
        earthSprite2 = [CCSprite spriteWithFile:@"level_7_earth_2.png"];
        float earthSprite2Width = [earthSprite2 contentSize].width;
        earthSprite2.opacity = 105;
        earthSprite2.position = 
        ccp(screen.width - earthSprite2Width/2,[earthSprite2 contentSize].height/2);
        [self addChild: earthSprite2];
        
        //------------------------- BOB -------------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        bobSpriteWidth = [bobSprite contentSize].width;
        bobSprite.position = ccp(+bobSpriteWidth/2,screen.height*0.256);
        [self addChild:bobSprite z:100];
        /*//----------------------- BOB ANIMATION ------------------------
        CCAnimation *bobAnim = [CCAnimation animation];
        [bobAnim addFrameWithFilename:@"bob_anim_1.png"]; 
        [bobAnim addFrameWithFilename:@"bob_anim_2.png"]; 
        
        id bobAnimationAction = [CCAnimate actionWithDuration:0.4f
                                                    animation:bobAnim
                                         restoreOriginalFrame:YES];
        id repeatBobAnimationAction = 
        [CCRepeatForever actionWithAction:bobAnimationAction];
        [bobSprite runAction:repeatBobAnimationAction];
         */
        
        //------------------ GRID (WHITE/BLACK) -----------------
        gridSprite = [CCSprite spriteWithFile:@"black_grid.png"];
        gridSprite.position = ccp(screen.width/2,screen.height/2);
        //[self addChild:gridSprite z:1000];
        gridSprite.opacity = 50;
        
        //----------------------- 12BRICKS -------------------------
        brickSprite = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite.position = ccp(screen.width*2.3/15+30,screen.height*2/10);
        [self addChild:brickSprite z:10];
        
        brickSprite2 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite2.position = ccp(screen.width*3.3/15-2+55 ,screen.height*2/10);
        [self addChild:brickSprite2 z:10];
        
        brickSprite3 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite3.position = ccp(screen.width*4.3/15-4+80,screen.height*2/10);
        [self addChild:brickSprite3 z:10];
        
        brickSprite4 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite4.position = ccp(screen.width*5.3/15-6+105,screen.height*2/10);
        [self addChild:brickSprite4 z:10];
        
        brickSprite5 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite5.position = ccp(screen.width*6.3/15-8+130,screen.height*2/10);
        [self addChild:brickSprite5 z:10];
        
        brickSprite6 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite6.position = ccp(screen.width*7.3/15-10+155,screen.height*2/10);
        [self addChild:brickSprite6 z:10];
        
        
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
        timebrick = 1.5;
        
        //[self schedule:@selector(bobBrickCollide:)]; 
        
    }
    return self;
}

-(void)bobRunningUpdate
{
    //CCLOG(@"inside runningBobUpdate!!!");
    screenSize = [CCDirector sharedDirector].winSize;
    
    //if(bobSprite.position.x > 0)
    //{
        [self schedule:@selector(bobEarthCollide)];
    //}
    
     //bobSprite.position = ccp(bobSprite.position.x + 100*0.016, bobSprite.position.y);
    frameBarSprite.position = ccp(bobSprite.position.x + 100*0.016, bobSprite.position.y+50);
    progressTimer.position = ccp(bobSprite.position.x + 100*0.016, bobSprite.position.y+50);
    
    if(bobSprite.position.x > screenSize.width)
    {
        [[CCDirector sharedDirector] sendCleanupToScene];
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_7 node]]];
    }
}

-(void)bobEarthCollide
{
    CGRect earthRect1 = [earthSprite1 boundingBox];
    CGRect earthRect2 = [earthSprite2 boundingBox];

    bobSprite.scaleX = 0.1;
    bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    bobSprite.scaleY = 1;
    
    brickRect = [brickSprite boundingBox];
    brickRect2 = [brickSprite2 boundingBox];
    brickRect3 = [brickSprite3 boundingBox];
    brickRect4 = [brickSprite4 boundingBox];
    brickRect5 = [brickSprite5 boundingBox];
    brickRect6 = [brickSprite6 boundingBox];
    
    if([bobSprite numberOfRunningActions] == 0)
    {
        if(CGRectIntersectsRect(bobRect, earthRect1)||
           CGRectIntersectsRect(bobRect, earthRect2)||
           CGRectIntersectsRect(bobRect, brickRect)||
           CGRectIntersectsRect(bobRect, brickRect2)||
           CGRectIntersectsRect(bobRect, brickRect3)||
           CGRectIntersectsRect(bobRect, brickRect4)||
           CGRectIntersectsRect(bobRect, brickRect5)||
           CGRectIntersectsRect(bobRect, brickRect6))
        
        {
            CCLOG(@"BOB intersect EARTH1 or EARTH2");
        }
        else
        {
            [self schedule:@selector(bobDiedAnimation:)];
            CCLOG(@"BOB DIED!!! - NOT INTERSECT!!! ");
            //bobSprite.opacity = 100;
           // [[CCDirector sharedDirector] replaceScene:
            // [CCTransitionFade transitionWithDuration:0.5 scene:[Level_6 node]]];
        }
    }
    
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self schedule:@selector(sensitiveJumpingFunction:)];
    
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
    
    
    //CCLOG(@" TIME %f",currentTime);
    
    //[scoreLabel setString:[NSString stringWithFormat:@"%f",currentTime] ];
    
}

-(void)jumpFunction
{
    
    //float jump = (float)time+0.3;
    float jump = currentTime;
    id jumpBob = [CCJumpBy actionWithDuration:currentTime*1.6+0.15 position:ccp(450*jump,0) height:200*jump jumps:1];
    [bobSprite runAction:jumpBob];
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self jumpFunction];
    
    //  self.isTouchEnabled = NO;
    //  [self schedule:@selector(bobCollideEarth)];
    
    
    bobSprite.scaleX = 0.1;
    bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    bobSprite.scaleY = 1;
    
    CGRect earthRect1 = [earthSprite1 boundingBox];
    CGRect earthRect2 = [earthSprite2 boundingBox];
    
    brickRect = [brickSprite boundingBox];
    brickRect2 = [brickSprite2 boundingBox];
    brickRect3 = [brickSprite3 boundingBox];
    brickRect4 = [brickSprite4 boundingBox];
    brickRect5 = [brickSprite5 boundingBox];
    brickRect6 = [brickSprite6 boundingBox];
    
    if(CGRectIntersectsRect(bobRect, earthRect1)||
       CGRectIntersectsRect(bobRect, earthRect2)||
       CGRectIntersectsRect(bobRect, brickRect)||
       CGRectIntersectsRect(bobRect, brickRect2)||
       CGRectIntersectsRect(bobRect, brickRect3)||
       CGRectIntersectsRect(bobRect, brickRect4)||
       CGRectIntersectsRect(bobRect, brickRect5)||
       CGRectIntersectsRect(bobRect, brickRect6))
    {
       // CCLOG(@"BOB CAN JUMP");
        //[self jumpingFunction];
        
        [self jumpFunction];
        
    }
    else
    {
        //CCLOG(@"NOT JUMP");
        //bobSprite.opacity = 100;
        
    }
    
    [self unschedule:@selector(sensitiveJumpingFunction:)];
    time=0;
    
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
         [CCTransitionFade transitionWithDuration:1 scene:[Level_6 node]]];
    }
    
}



@end
