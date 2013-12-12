//
//  Level_12.m
//  GameplayPrototype30
//
//  Created by Артур on 14.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_12.h"
#import "Level_13.h"

@implementation Level_12

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_12 *layer = [Level_12 node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    if((self = [super init]))
    {
         screen = [CCDirector sharedDirector].winSize;
        
        self.isTouchEnabled = YES;
        
        //------------------- LEVEL BACKGROUND -----------------
        CCSprite *backgroundSprite = [CCSprite spriteWithFile:@"level_4.png"];
        float backgroundSpriteHeight = [backgroundSprite contentSize].height;
        backgroundSprite.position = ccp(screen.width/2,backgroundSpriteHeight/2);
        [self addChild:backgroundSprite z:0];
        backgroundSprite.scale = 1.01;
        
        //--------------------- BOB ---------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        float bobSpriteWidth = [bobSprite contentSize].width;
        bobSprite.position = ccp(bobSpriteWidth/2,screen.height*0.265);
        [self addChild:bobSprite z:10];
        
        //---------------- LADDER 1 & LADDER 2 & LADDER3 ------------------
        ladderSprite1 = [CCSprite spriteWithFile:@"ladder.png"];
        float ladderSpriteWidth = [ladderSprite1 contentSize].width;
        float ladderSpriteHeight = [ladderSprite1 contentSize].height;
        ladderSprite1.position = ccp(screen.width*1/4, screen.height*0.33);
        [self addChild:ladderSprite1 z:5];
        
        ladderSprite2 = [CCSprite spriteWithFile:@"ladder.png"];
        ladderSprite2.position = ccp(screen.width*2/4, screen.height*0.33);
        [self addChild:ladderSprite2 z:5];
        
        ladderSprite3 = [CCSprite spriteWithFile:@"ladder.png"];
        ladderSprite3.position = ccp(screen.width*3/4, screen.height*0.33);
        [self addChild:ladderSprite3 z:5];
        
        //---------------- BOMB 1 & BOMB 2 & BOMB 3 --------------------
        bombSprite1 = [CCSprite spriteWithFile:@"bomb.png"];
        bombSprite1.position = ccp(screen.width*3/8, screen.height*0.5);
        [self addChild:bombSprite1 z:15];
        
        bombSprite2 = [CCSprite spriteWithFile:@"bomb.png"];
        bombSprite2.position = ccp(screen.width*5/8, screen.height*0.25);
        [self addChild:bombSprite2 z:15];
        
        bombSprite3 = [CCSprite spriteWithFile:@"bomb.png"];
        bombSprite3.position = ccp(screen.width*7/8, screen.height*0.5);
        [self addChild:bombSprite3 z:15];
        
        //------------------------------ RAT ---------------------------------
        ratSprite = [CCSprite spriteWithFile:@"rat_anim_1.png"];
        float ratSpriteWidth = [ratSprite contentSize].width;
        ratSprite.position = ccp(-ratSpriteWidth*2,screen.height*0.3);
        [self addChild:ratSprite z:11];
        
       // bombSprite1.opacity = 0;
       // bombSprite2.opacity = 0;
       // bombSprite3.opacity = 0;
        
        //[self schedule:@selector(showRandomBomb)];
        //[self showRandomBomb];
        [self schedule:@selector(bobRunningUpdate)];
        [self schedule:@selector(bobCollideBomb)];
        
        //[self schedule:@selector(bobBombReaction)];
        
        [self schedule:@selector(ratFlyingUpdate)];
        [self schedule:@selector(ratFlyUp)];
        [self schedule:@selector(ratCollideBob)];
        
        
    }
    return self;
}

-(void)bobBombReaction
{
    CGRect bobRect = [bobSprite boundingBox];
    bombSprite1.scale = 6;
    CGRect bombRect1 = [bombSprite1 boundingBox];
    bombSprite1.scale = 1;
    
    bombSprite2.scale = 6;
    CGRect bombRect2 = [bombSprite2 boundingBox];
    bombSprite2.scale = 1;
    
    bombSprite3.scale = 6;
    CGRect bombRect3 = [bombSprite3 boundingBox];
    bombSprite3.scale = 1;
    
    if(CGRectIntersectsRect(bobRect, bombRect1))
    {
        //[self unschedule:@selector(bobBombReaction)];
        [self schedule:@selector(bombAppear:)];
    }
    if(CGRectIntersectsRect(bobRect, bombRect2))
    {
        //[self unschedule:@selector(bobBombReaction)];
        [self schedule:@selector(bombAppear2:)];
    }
    if(CGRectIntersectsRect(bobRect, bombRect3))
    {
        //[self unschedule:@selector(bobBombReaction)];
        [self schedule:@selector(bombAppear3:)];
    }
}

-(void)bombAppear:(ccTime)delta
{
    bombTime += delta;
    bombFloat = (float)bombTime;
    
    if(bombFloat >= 1.5)
        bombFloat = 1.5;
    bombSprite1.opacity = 0 + 255*bombFloat/1.5;
    
    if(bombFloat == 1.5)
    {
        [self unschedule:@selector(bombAppear:)];
    }
}

-(void)bombAppear2:(ccTime)delta
{
    bombTime2 += delta;
    bombFloat2 = (float)bombTime2;
    
    if(bombFloat2 >= 1.5)
        bombFloat2 = 1.5;
    bombSprite2.opacity = 0 + 255*bombFloat2/1.5;
    
    if(bombFloat2 == 1.5)
    {
        [self unschedule:@selector(bombAppear2:)];
    }
}

-(void)bombAppear3:(ccTime)delta
{
    bombTime3 += delta;
    bombFloat3 = (float)bombTime3;
    
    if(bombFloat3 >= 1.5)
        bombFloat3 = 1.5;
    bombSprite3.opacity = 0 + 255*bombFloat3/1.5;
    
    if(bombFloat3 == 1.5)
    {
        [self unschedule:@selector(bombAppear3:)];
    }
}

-(void)showRandomBomb
{
    int bombindex1 = CCRANDOM_0_1()*2+1;
    //int bombindex2 = CCRANDOM_0_1()*2+1;
    int bombindex2;
    
    if(bombindex1 == 1) { bombindex2 = 2; }
    else { bombindex2 = 1; }
    CCLOG(@"%i",bombindex1);
    
    CGSize screen = [CCDirector sharedDirector].winSize;
    bombSprite1.position = ccp(screen.width*3/8, screen.height*bombindex1*0.25);
    
    //if(bobSprite.position.x == screen.width*1/4-30)
    //[self bombShow1];
    // bombSprite1.opacity = 255;
    
    bombSprite2.position = ccp(screen.width*5/8, screen.height*bombindex2*0.25);
    
    // if(bobSprite.position.x == screen.width*2/4-30)
    // bombSprite2.opacity = 255;
    
}

-(void)bombShow1
{
    bombSprite1.opacity = 255;
}

-(void)bobRunningUpdate
{
    //CCLOG(@"inside runningBobUpdate!!!");
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    float bobSpriteWidth = [bobSprite contentSize].width;
    
    bobSprite.position = ccp(bobSprite.position.x + 100*0.016, bobSprite.position.y);
    
    if(bobSprite.position.x > screenSize.width-bobSpriteWidth/2)
    {
        // bobSprite.position = ccp(-bobSpriteWidth/2,bobSprite.position.y);
        //[[CCDirector sharedDirector] sendCleanupToScene];
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_13 node]]];
    }
}
-(void)bobCollideBomb
{
    CGSize screen = [CCDirector sharedDirector].winSize;
    bobSprite.scaleX = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    CGRect bombRect1 = [bombSprite1 boundingBox];
    CGRect bombRect2 = [bombSprite2 boundingBox];
    CGRect bombRect3 = [bombSprite3 boundingBox];
    
    if(CGRectIntersectsRect(bobRect,bombRect1))
        
    {
        //CCLOG(@"!!!!!!BOB INTERSECT BOMB1!!!!!");
        bobSprite.opacity = 0;
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:0.5 scene:[Level_12 node]]];
        
    }
    
    if(CGRectIntersectsRect(bobRect,bombRect2))
        
    {
        //CCLOG(@"!!!!!!BOB INTERSECT BOMB2!!!!!");
        bobSprite.opacity = 0;
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:0.5 scene:[Level_12 node]]];
    }
    
    if(CGRectIntersectsRect(bobRect,bombRect3))
        
    {
        //CCLOG(@"!!!!!!BOB INTERSECT BOMB3!!!!!");
        bobSprite.opacity = 0;
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:0.5 scene:[Level_12 node]]];
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
    CGRect ladderRect3 = [ladderSprite3 boundingBox];
    
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
    
    
    if(CGRectIntersectsRect(bobRect,ladderRect3))
        
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

-(void)ratCollideBob
{
    //CCLOG(@"inside didCollide!!!");
    bobSprite.scale = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scale = 1;
    CGRect ratRect = [ratSprite boundingBox];
    
    CGRect bombRect2 = [bombSprite2 boundingBox];
    
    if(CGRectIntersectsRect(bobRect, ratRect))
    {
        // bumerangSprite.visible = 0;
        
        //[self bobDied];
        [self schedule:@selector(bobDiedAnimation:) ];
        // [self restartWithDelay];
        [self unschedule:@selector(bobRunningUpdate)];
        [self unschedule:@selector(ratCollideBob)];
    }
    if(CGRectIntersectsRect(bombRect2, ratRect))
    {
        [self schedule:@selector(ratDiedAnimation:) ];
        [self unschedule:@selector(ratCollideBob)];
        //ratSprite.opacity = 0;
    }
    
}

#pragma mark -- RAT MOVING METHODS --

-(void)ratFlyingUpdate
{
    //screenSize = [CCDirector sharedDirector].winSize;
    float ratSpriteWidth = [ratSprite contentSize].width;
    
    ratSprite.position = ccp(ratSprite.position.x + 100*0.02, ratSprite.position.y);
    
    //[self schedule:@selector(ratFlyUp)];
    
    /*if(ratSprite.position.x < ratSpriteWidth)
     {
     ratSprite.position = ccp(screenSize.width,ratSprite.position.y);
     }
     */
}

-(void)ratFlyUp
{
    ratSprite.position = ccp(ratSprite.position.x, ratSprite.position.y + 100*0.003);
    if(ratSprite.position.y > screen.height*0.32)
    {
        [self unschedule:@selector(ratFlyUp)];
        [self schedule:@selector(ratFlyDown)];
        
    }
}

-(void)ratFlyDown
{
    
    ratSprite.position = ccp(ratSprite.position.x, ratSprite.position.y - 100*0.005);
    if(ratSprite.position.y < screen.height*0.26)
    {
        [self unschedule:@selector(ratFlyDown)];
        [self schedule:@selector(ratFlyUp)];
        
    }
}

#pragma mark ---- BOB DIED ----
-(void)bobDiedAnimation:(ccTime)delta
{
    self.isTouchEnabled = NO;
    dieTime += delta;
    dieFloat = (float)dieTime;
    
    bobSprite.scale = 1 + 1*dieFloat*1.6;
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
         [CCTransitionFade transitionWithDuration:1 scene:[Level_12 node]]];
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

@end