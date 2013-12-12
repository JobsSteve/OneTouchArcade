//
//  Level_3.m
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_3.h"
#import "Level_4.h"

@implementation Level_3

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_3 *layer = [Level_3 node];
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
        arrowSprite.position = ccp(screen.width/2,screen.height*2/3);
        [self addChild:arrowSprite z:11];

        
        [self schedule:@selector(runningBobUpdate)];
        [self schedule:@selector(bobArrowRectangleCollide)];
        [self schedule:@selector(bobArrowCollide)];
        
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
         [CCTransitionFade transitionWithDuration:1 scene:[Level_4 node]]];
    }
}

-(void)bobArrowCollide
{
    bobSprite.scaleX = 0.5;
    bobSprite.scaleY = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    bobSprite.scaleY = 1;
    CGRect arrowRect = [arrowSprite boundingBox];
   
    if(CGRectIntersectsRect(arrowRect, bobRect))
        
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
    
    if(CGRectIntersectsRect(arrowRect1, bobRect))
    {
        [self schedule:@selector(arrowFallDown)];
        
    }
    
    else
    {
        [self unschedule:@selector(arrowFallDown)];
    }
    
}

-(void)arrowFallDown
{
    arrowSprite.position = ccp(arrowSprite.position.x,arrowSprite.position.y-100*0.035);
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
         [CCTransitionFade transitionWithDuration:1 scene:[Level_3 node]]];
    }
}




@end
