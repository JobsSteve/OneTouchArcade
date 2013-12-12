//
//  Level_11.m
//  GameplayPrototype30
//
//  Created by Артур on 14.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_11.h"
#import "Level_12.h"

@implementation Level_11

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_11 *layer = [Level_11 node];
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
        
        //----------------------- BACKGROUND ---------------------------
        CCSprite *backgroundSprite = [CCSprite spriteWithFile:@"level_3.png"];
        backgroundSprite.position = ccp(screen.width/2,screen.height/2);
        backgroundSprite.opacity = 255;
        [self addChild:backgroundSprite];
        
        //-------------------------- BOB -------------------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        float bobSpriteWidth = [bobSprite contentSize].width;
        float bobSpriteHeight = [bobSprite contentSize].height;
        bobSprite.position = ccp(-bobSpriteWidth, screen.height*0.265);
        [self addChild:bobSprite z:10];
        //----------------------- BOB ANIMATION ------------------------
        CCAnimation *bobAnim = [CCAnimation animation];
        [bobAnim addFrameWithFilename:@"bob_anim_1.png"]; 
        [bobAnim addFrameWithFilename:@"bob_anim_2.png"]; 
        
        id bobAnimationAction = [CCAnimate actionWithDuration:0.5f
                                                    animation:bobAnim
                                         restoreOriginalFrame:YES];
        id repeatBobAnimationAction = 
        [CCRepeatForever actionWithAction:bobAnimationAction];
        [bobSprite runAction:repeatBobAnimationAction];
        
        //------------------------- ARROW ---------------------------------
        arrowSprite = [CCSprite spriteWithFile:@"arrow.png"];
        arrowSprite.position = ccp(screen.width*1/3,screen.height*2/3);
        [self addChild:arrowSprite z:11];
        
        //------------------------- ARROW2 ---------------------------------
        arrowSprite2 = [CCSprite spriteWithFile:@"arrow.png"];
        arrowSprite2.position = ccp(screen.width*2/3,screen.height*2/3);
        [self addChild:arrowSprite2 z:11];
        
        //------------------------------ RAT ---------------------------------
        ratSprite = [CCSprite spriteWithFile:@"rat_anim_1.png"];
        float ratSpriteWidth = [ratSprite contentSize].width;
        ratSprite.position = ccp(-ratSpriteWidth*7.5,screen.height*0.3);
        [self addChild:ratSprite z:11];
        
        
        [self schedule:@selector(runningBobUpdate)];
        [self schedule:@selector(bobArrowRectangleCollide)];
        [self schedule:@selector(bobArrowCollide)];
        
        [self schedule:@selector(ratFlyingUpdate)];
        [self schedule:@selector(ratFlyUp)];
        [self schedule:@selector(ratCollideBob)];
        
    }
    return self;
}

-(void)runningBobUpdate
{
    CGSize screen = [CCDirector sharedDirector].winSize;
    float bobSpriteWidth = [bobSprite contentSize].width;
    
    bobSprite.position = ccp(bobSprite.position.x + 0.016*100, bobSprite.position.y);
    
    if(bobSprite.position.x > screen.width)
    {
        self.isTouchEnabled = NO;
    }
    
    if(bobSprite.position.x > screen.width+bobSpriteWidth)
    {
        bobSprite.opacity = 255;
        
        [self unschedule:@selector(runningBobUpdate)];
        [self unschedule:@selector(bobArrowCollide)];
        [self unschedule:@selector(bobArrowRectangleCollide)];
        [self unschedule:@selector(arrowFallDown)];
        
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_12 node]]];
    }
}

-(void)bobArrowCollide
{
    bobSprite.scaleX = 0.3;
    bobSprite.scaleY = 0.3;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    bobSprite.scaleY = 1;
    
    CGRect arrowRect = [arrowSprite boundingBox];
    CGRect arrowRect2 = [arrowSprite2 boundingBox];
    
    if((CGRectIntersectsRect(arrowRect, bobRect))||
        (CGRectIntersectsRect(arrowRect2, bobRect)))
    {
        CCLOG(@"!!!!!!BOB INTERSECT ARROW!!!!!");
        //bobSprite.opacity = 0;
        [self unschedule:@selector(runningBobUpdate)];
        [self schedule:@selector(bobDiedAnimation:)];
        // [[CCDirector sharedDirector] replaceScene:
        //  [CCTransitionFade transitionWithDuration:0.5 scene:[Level_3 node]]];
    }
    
    
}

-(void)bobArrowRectangleCollide
{
    //bobSprite.scaleX = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    //bobSprite.scaleX = 1;
    
    arrowSprite.scaleY = 15;
    arrowSprite.scaleX = 1.2;
    CGRect arrowRect1 = [arrowSprite boundingBox];
    arrowSprite.scaleY = 1;
    arrowSprite.scaleX = 1;
    
    arrowSprite2.scaleY = 15;
    arrowSprite2.scaleX = 1.2;
    CGRect arrowRect2 = [arrowSprite2 boundingBox];
    arrowSprite2.scaleY = 1;
    arrowSprite2.scaleX = 1;
    
    if(CGRectIntersectsRect(arrowRect1, bobRect))
    {
        [self schedule:@selector(arrowFallDown)];
    }
    
    if(CGRectIntersectsRect(arrowRect2, bobRect))
    {
        [self schedule:@selector(arrowFallDown2)];
    }
    
}

-(void)arrowFallDown
{
    arrowSprite.position = ccp(arrowSprite.position.x,arrowSprite.position.y-100*0.035);
}

-(void)arrowFallDown2
{
    arrowSprite2.position = ccp(arrowSprite2.position.x,arrowSprite2.position.y-100*0.035);
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self unschedule:@selector(runningBobUpdate)];
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self schedule:@selector(runningBobUpdate)];
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
         [CCTransitionFade transitionWithDuration:1 scene:[Level_11 node]]];
    }
}

-(void)ratCollideBob
{
    //CCLOG(@"inside didCollide!!!");
    bobSprite.scale = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scale = 1;
    CGRect ratRect = [ratSprite boundingBox];
    
    if(CGRectIntersectsRect(bobRect, ratRect))
    {
       // bumerangSprite.visible = 0;
        
        //[self bobDied];
        [self schedule:@selector(bobDiedAnimation:) ];
       // [self restartWithDelay];
        [self unschedule:@selector(bobRunningUpdate)];
        [self unschedule:@selector(ratCollideBob)];
    }
}

#pragma mark -- RAT MOVING METHODS --

-(void)ratFlyingUpdate
{
    //screenSize = [CCDirector sharedDirector].winSize;
    float ratSpriteWidth = [ratSprite contentSize].width;
    
    ratSprite.position = ccp(ratSprite.position.x + 100*0.0166, ratSprite.position.y);
    
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

@end