//
//  Level_7.m
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_7.h"
#import "Level_8.h"

@implementation Level_7

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_7 *layer = [Level_7 node];
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
        
        //------------------------- BOB -------------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        bobSpriteWidth = [bobSprite contentSize].width;
        bobSprite.position = ccp(+bobSpriteWidth/2,screen.height*0.256);
        [self addChild:bobSprite z:100];
        //----------------------- BOB ANIMATION ------------------------
        CCAnimation *bobAnim = [CCAnimation animation];
        [bobAnim addFrameWithFilename:@"bob_anim_1.png"]; 
        [bobAnim addFrameWithFilename:@"bob_anim_2.png"]; 
        
        id bobAnimationAction = [CCAnimate actionWithDuration:0.4f
                                                    animation:bobAnim
                                         restoreOriginalFrame:YES];
        id repeatBobAnimationAction = 
        [CCRepeatForever actionWithAction:bobAnimationAction];
        [bobSprite runAction:repeatBobAnimationAction];
        
        //------------------ GRID (WHITE/BLACK) -----------------
        gridSprite = [CCSprite spriteWithFile:@"black_grid.png"];
        gridSprite.position = ccp(screen.width/2,screen.height/2);
        [self addChild:gridSprite z:1000];
        gridSprite.opacity = 35;
        
        //----------------------- 12BRICKS -------------------------
        brickSprite = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite.position = ccp(screen.width*2.3/15,screen.height*2/10);
        [self addChild:brickSprite z:10];
        
        brickSprite2 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite2.position = ccp(screen.width*3.3/15-2 ,screen.height*2/10);
        [self addChild:brickSprite2 z:10];
        
        brickSprite3 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite3.position = ccp(screen.width*4.3/15-4,screen.height*2/10);
        [self addChild:brickSprite3 z:10];
        
        brickSprite4 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite4.position = ccp(screen.width*5.3/15-6,screen.height*2/10);
        [self addChild:brickSprite4 z:10];
        
        brickSprite5 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite5.position = ccp(screen.width*6.3/15-8,screen.height*2/10);
        [self addChild:brickSprite5 z:10];
        
        brickSprite6 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite6.position = ccp(screen.width*7.3/15-10,screen.height*2/10);
        [self addChild:brickSprite6 z:10];
        
        brickSprite7 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite7.position = ccp(screen.width*8.3/15-12,screen.height*2/10);
        [self addChild:brickSprite7 z:10];
        
        brickSprite8 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite8.position = ccp(screen.width*9.3/15-14,screen.height*2/10);
        [self addChild:brickSprite8 z:10];
        
        brickSprite9 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite9.position = ccp(screen.width*10.3/15-16,screen.height*2/10);
        [self addChild:brickSprite9 z:10];
        
        brickSprite10 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite10.position = ccp(screen.width*11.3/15-18,screen.height*2/10);
        [self addChild:brickSprite10 z:10];
        
        brickSprite11 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite11.position = ccp(screen.width*12.3/15-20,screen.height*2/10);
        [self addChild:brickSprite11 z:10];
        
        brickSprite12 = [CCSprite spriteWithFile:@"brick.png"];
        brickSprite12.position = ccp(screen.width*13.3/15-22,screen.height*2/10);
        [self addChild:brickSprite12 z:10];
        
        timebrick = 1.5;
        
        [self schedule:@selector(bobBrickCollide:)]; 
        
    }
    return self;
}



-(void)bobRunningUpdate
{
    //CCLOG(@"inside runningBobUpdate!!!");
    screenSize = [CCDirector sharedDirector].winSize;
    //float bobSpriteWidth = [bobSprite contentSize].width;
    
    bobSprite.position = ccp(bobSprite.position.x + 15, bobSprite.position.y);
    
    if(bobSprite.position.x > screenSize.width+bobSpriteWidth/2)
    {
        [[CCDirector sharedDirector] sendCleanupToScene];
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_8 node]]];
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self bobRunningUpdate];
}

-(void)bobBrickCollide:(ccTime)delta
{
    bobRect = [bobSprite boundingBox];
    brickRect = [brickSprite boundingBox];
    brickRect2 = [brickSprite2 boundingBox];
    brickRect3 = [brickSprite3 boundingBox];
    brickRect4 = [brickSprite4 boundingBox];
    brickRect5 = [brickSprite5 boundingBox];
    brickRect6 = [brickSprite6 boundingBox];
    brickRect7 = [brickSprite7 boundingBox];
    brickRect8 = [brickSprite8 boundingBox];
    brickRect9 = [brickSprite9 boundingBox];
    brickRect10 = [brickSprite10 boundingBox];
    brickRect11 = [brickSprite11 boundingBox];
    brickRect12 = [brickSprite11 boundingBox];
    
    if(CGRectIntersectsRect(bobRect, brickRect))
        [self schedule:@selector(brick1:)];
    
    if(CGRectIntersectsRect(bobRect, brickRect2))
        [self schedule:@selector(brick2:)];
    
    if(CGRectIntersectsRect(bobRect, brickRect3))
        [self schedule:@selector(brick3:)];
    
    if(CGRectIntersectsRect(bobRect, brickRect4))
        [self schedule:@selector(brick4:)];
    
    if(CGRectIntersectsRect(bobRect, brickRect5))
        [self schedule:@selector(brick5:)];
    
    if(CGRectIntersectsRect(bobRect, brickRect6))
        [self schedule:@selector(brick6:)];
    
    if(CGRectIntersectsRect(bobRect, brickRect7))
        [self schedule:@selector(brick7:)];
    
    if(CGRectIntersectsRect(bobRect, brickRect8))
        [self schedule:@selector(brick8:)];
    
    if(CGRectIntersectsRect(bobRect, brickRect9))
        [self schedule:@selector(brick9:)];
    
    if(CGRectIntersectsRect(bobRect, brickRect10))
        [self schedule:@selector(brick10:)];
    
    if(CGRectIntersectsRect(bobRect, brickRect11))
        [self schedule:@selector(brick11:)];
    
    if(CGRectIntersectsRect(bobRect, brickRect12))
        [self schedule:@selector(brick12:)];
    
}

-(void)brick1:(ccTime)delta
{
    brickTime += delta;
    brickFloat = (float)brickTime;
    if(brickFloat > timebrick)
        brickFloat = timebrick;
    
    brickSprite.opacity = 255 - 255*brickFloat/timebrick;
    
    if((brickFloat == timebrick)&&(CGRectIntersectsRect(bobRect, brickRect)))
    {
        //bobSprite.opacity = 0;
        //ccTime delta;
        //[self bobDiedAnimation:delta];
        [self schedule:@selector(bobDiedAnimation:)];
        [self unschedule:@selector(brick1:)];
    }
}

-(void)brick2:(ccTime)delta
{
    brickTime2 += delta;
    brickFloat = (float)brickTime2;
    if(brickFloat > timebrick)
        brickFloat = timebrick;
    brickSprite2.opacity = 255 - 255*brickFloat/timebrick;
    
    if((brickFloat == timebrick)&&(CGRectIntersectsRect(bobRect, brickRect2)))
    {
        [self schedule:@selector(bobDiedAnimation:)];
        [self unschedule:@selector(brick2:)];
    }
}

-(void)brick3:(ccTime)delta
{
    brickTime3 += delta;
    brickFloat = (float)brickTime3;
    if(brickFloat > timebrick)
        brickFloat = timebrick;
    brickSprite3.opacity = 255 - 255*brickFloat/timebrick;
    
    if((brickFloat == timebrick)&&(CGRectIntersectsRect(bobRect, brickRect3)))
    {
        [self schedule:@selector(bobDiedAnimation:)];
        [self unschedule:@selector(brick3:)];
    }
}

-(void)brick4:(ccTime)delta
{
    brickTime4 += delta;
    brickFloat = (float)brickTime4;
    if(brickFloat > timebrick)
        brickFloat = timebrick;
    
    brickSprite4.opacity = 255 - 255*brickFloat/timebrick;
    
    if((brickFloat == timebrick)&&(CGRectIntersectsRect(bobRect, brickRect4)))
    {
        [self schedule:@selector(bobDiedAnimation:)];
        [self unschedule:@selector(brick4:)];
    }
}

-(void)brick5:(ccTime)delta
{
    brickTime5 += delta;
    brickFloat = (float)brickTime5;
    if(brickFloat > timebrick)
        brickFloat = timebrick;
    brickSprite5.opacity = 255 - 255*brickFloat/timebrick;
    
    if((brickFloat == timebrick)&&(CGRectIntersectsRect(bobRect, brickRect5)))
    {
        [self schedule:@selector(bobDiedAnimation:)];
        [self unschedule:@selector(brick5:)];
    }
}

-(void)brick6:(ccTime)delta
{
    brickTime6 += delta;
    brickFloat = (float)brickTime6;
    if(brickFloat > timebrick)
        brickFloat = timebrick;
    brickSprite6.opacity = 255 - 255*brickFloat/timebrick;
    
    if((brickFloat == timebrick)&&(CGRectIntersectsRect(bobRect, brickRect6)))
    {
        [self schedule:@selector(bobDiedAnimation:)];
        [self unschedule:@selector(brick6:)];
    }
}

-(void)brick7:(ccTime)delta
{
    brickTime7 += delta;
    brickFloat = (float)brickTime7;
    if(brickFloat > timebrick)
        brickFloat = timebrick;
    brickSprite7.opacity = 255 - 255*brickFloat/timebrick;
    
    if((brickFloat == timebrick)&&(CGRectIntersectsRect(bobRect, brickRect7)))
    {
        [self schedule:@selector(bobDiedAnimation:)];
        [self unschedule:@selector(brick7:)];
    }
}

-(void)brick8:(ccTime)delta
{
    brickTime8 += delta;
    brickFloat = (float)brickTime8;
    if(brickFloat > timebrick)
        brickFloat = timebrick;
    brickSprite8.opacity = 255 - 255*brickFloat/timebrick;
    
    if((brickFloat == timebrick)&&(CGRectIntersectsRect(bobRect, brickRect8)))
    {
        [self schedule:@selector(bobDiedAnimation:)];
        [self unschedule:@selector(brick8:)];
    }
}

-(void)brick9:(ccTime)delta
{
    brickTime9 += delta;
    brickFloat = (float)brickTime9;
    if(brickFloat > timebrick)
        brickFloat = timebrick;
    brickSprite9.opacity = 255 - 255*brickFloat/timebrick;
    
    if((brickFloat == timebrick)&&(CGRectIntersectsRect(bobRect, brickRect9)))
    {
        [self schedule:@selector(bobDiedAnimation:)];
        [self unschedule:@selector(brick9:)];
    }
}

-(void)brick10:(ccTime)delta
{
    brickTime10 += delta;
    brickFloat = (float)brickTime10;
    if(brickFloat > timebrick)
        brickFloat = timebrick;
    brickSprite10.opacity = 255 - 255*brickFloat/timebrick;
    
    if((brickFloat == timebrick)&&(CGRectIntersectsRect(bobRect, brickRect10)))
    {
        [self schedule:@selector(bobDiedAnimation:)];
        [self unschedule:@selector(brick10:)];
    }
}

-(void)brick11:(ccTime)delta
{
    brickTime11 += delta;
    brickFloat = (float)brickTime11;
    if(brickFloat > timebrick)
        brickFloat = timebrick;
    brickSprite11.opacity = 255 - 255*brickFloat/timebrick;
    
    if((brickFloat == timebrick)&&(CGRectIntersectsRect(bobRect, brickRect11)))
    {
        [self schedule:@selector(bobDiedAnimation:)];
        [self unschedule:@selector(brick11:)];
    }
}
-(void)brick12:(ccTime)delta
{
    brickTime12 += delta;
    brickFloat = (float)brickTime12;
    if(brickFloat > timebrick)
        brickFloat = timebrick;
    brickSprite12.opacity = 255 - 255*brickFloat/timebrick;
    
    if((brickFloat == timebrick)&&(CGRectIntersectsRect(bobRect, brickRect12)))
    {
        //bobSprite.opacity = 0;
        //  [self bobDiedAnimation];
        [self schedule:@selector(bobDiedAnimation:)];
        [self unschedule:@selector(brick12:)];
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
         [CCTransitionFade transitionWithDuration:1 scene:[Level_7 node]]];
    }
    
}



@end
