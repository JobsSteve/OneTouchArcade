//
//  Level_5.m
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_5.h"
#import "Level_6.h"

@implementation Level_5

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_5 *layer = [Level_5 node];
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
        backgroundSprite = [CCSprite spriteWithFile:@"level_13_background.png"];
        backgroundSpriteHeight = [backgroundSprite contentSize].height;
        backgroundSprite.position = ccp(screen.width/2-2,backgroundSpriteHeight/2);
        
        [self addChild:backgroundSprite z:0];
      
        
        backsideSprite = [CCSprite spriteWithFile:@"level_6_corridor.png"];
        //backgroundSpriteHeight = [backgroundSprite contentSize].height;
        backsideSprite.position = ccp(screen.width/2,backgroundSpriteHeight/2);
        [self addChild: backsideSprite z:130];
        
        //------------------ GRID (WHITE/BLACK) -----------------
        gridSprite = [CCSprite spriteWithFile:@"black_grid.png"];
        gridSprite.position = ccp(screen.width/2,screen.height/2);
        //[self addChild:gridSprite z:100];
        gridSprite.opacity = 50;
        
        //------------------------ BOB -------------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        bobSpriteWidth = [bobSprite contentSize].width;
        //bobSprite.position = ccp(screen.width*2/7-8,screen.height*0.5-15);
        bobSprite.position = ccp(screen.width*4/15,screen.height*4.5/10);
        [self addChild:bobSprite z:300];
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
        
        //------------------------- WINDOW SPRITES -------------------------
        windowSkeletonSprite = [CCSprite spriteWithFile:@"window_skeleton.png"];
        windowSkeletonSprite.position = ccp(screen.width*7.5/15,screen.height*4.5/10);
        [self addChild:windowSkeletonSprite z:120];
        windowSkeletonSprite.opacity = 220; // 86.3% - 220
        //----------- BACKSIDE ------------
        windowBacksideSprite = [CCSprite spriteWithFile:@"window_backside.png"];
        windowBacksideSprite.position = ccp(screen.width*7.5/15,screen.height*4.5/10);
        [self addChild:windowBacksideSprite z:10];
        windowBacksideSprite.opacity = 255;
        //---------- LEFT WINDOW ---------
        leftWindowSprite = [CCSprite spriteWithFile:@"window_door.png"];
        leftWindowSprite.position = ccp(screen.width*7.5/15-32,screen.height*4.5/10+2);
        [self addChild:leftWindowSprite z:21];
        leftWindowSprite.opacity = 255;
        //---------- RIGHT WINDOW --------
        rightWindowSprite = [CCSprite spriteWithFile:@"window_door.png"];
        rightWindowSprite.position = ccp(screen.width*7.5/15+32,screen.height*4.5/10+2);
        [self addChild:rightWindowSprite z:21];
        rightWindowSprite.opacity = 255;
        
        //-------------------------- FINISH DOOR -----------------------------
        finishDoorSprite = [CCSprite spriteWithFile:@"finish_door.png"];
        finishDoorSprite.position = ccp(screen.width*11/15+2,screen.height*4.5/10+2);
        [self addChild:finishDoorSprite z:122];
        finishDoorSprite.opacity = 255;
        
        counter = 0;
        
        //[self schedule:@selector(bobRunningUpdate)];
        //[self schedule:@selector(bobRotateUpdate)];
        
        [self schedule:@selector(closeWindow)];
        
        
    }
    return self;
}

-(void)bobRotateUpdate
{
    bobSprite.rotation +=10;
}

-(void)bobRunningUpdate
{
    //CCLOG(@"inside runningBobUpdate!!!");
    screenSize = [CCDirector sharedDirector].winSize;
    //float bobSpriteWidth = [bobSprite contentSize].width;
    
    bobSprite.position = ccp(bobSprite.position.x + 100*0.016, bobSprite.position.y);
    
    if(bobSprite.position.x > screenSize.width+bobSpriteWidth/2)
    {
        [self unschedule:@selector(bobRunningUpdate)];
        //bobSprite.position = ccp(-bobSpriteWidth/2,bobSprite.position.y);
        [[CCDirector sharedDirector] sendCleanupToScene];
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_6 node]]];
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    bobSprite.position = ccp(bobSprite.position.x + 57, bobSprite.position.y);
    counter++;
    
    if(counter == 4)
    {
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_6 node]]];
    }
}

-(void)closeWindow
{
    leftWindowSprite.position = ccp(leftWindowSprite.position.x+0.9, leftWindowSprite.position.y);
    rightWindowSprite.position = ccp(rightWindowSprite.position.x-0.9, rightWindowSprite.position.y);
    
    CGRect leftRect = [leftWindowSprite boundingBox];
    CGRect rightRect = [rightWindowSprite boundingBox];
    
    if(CGRectIntersectsRect(leftRect, rightRect))
    {
        [self unschedule:@selector(closeWindow)];
        //[self schedule:@selector(delayCloseWindow)];
        [self delayCloseWindow];
    }
    
    if(counter == 2)
    {
        [self schedule:@selector(bobDiedAnimation:) ];
    }
}

-(void)delayCloseWindow
{
    id delayAction = [CCDelayTime actionWithDuration:1];
    
    id callOpenWindow = [CCCallFunc actionWithTarget:self selector:@selector(callOpenWindow)];
    
    id sequenceAction = [CCSequence actions:delayAction,callOpenWindow, nil];
    
    [leftWindowSprite runAction:sequenceAction];
    [rightWindowSprite runAction:sequenceAction];
}

-(void)callOpenWindow
{
    [self schedule:@selector(openWindow)];
}

-(void)openWindow
{
    leftWindowSprite.position = ccp(leftWindowSprite.position.x-0.9, leftWindowSprite.position.y);
    rightWindowSprite.position = ccp(rightWindowSprite.position.x+0.9, rightWindowSprite.position.y);
    
    CGRect leftRect = [leftWindowSprite boundingBox];
    //    CGRect rightRect = [rightWindowSprite boundingBox];
    CGRect backsideRect = [windowBacksideSprite boundingBox];
    
    if(!(CGRectIntersectsRect(leftRect, backsideRect)))
    {
        [self unschedule:@selector(openWindow)];
        [self schedule:@selector(closeWindow)];
        
    }
    
    CGRect bobRect = [bobSprite boundingBox];
    
    if(counter == 2)
    {
        [self schedule:@selector(bobDiedAnimation:) ];
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
         [CCTransitionFade transitionWithDuration:1 scene:[Level_5 node]]];
    }
    
}



@end
