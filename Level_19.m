//
//  Level_19.m
//  GameplayPrototype30
//
//  Created by Артур on 13.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_19.h"
#import "Level_20.h"

@implementation Level_19

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_19 *layer = [Level_19 node];
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
        
        //------------------------ BACKGROUND -------------------------
        backgroundSprite = [CCSprite spriteWithFile:@"level_13_background.png"];
        backgroundSprite.position = ccp(screen.width/2,screen.height/2);
        [self addChild:backgroundSprite z:0];
        //------------ CORRIDOR ------------
        corridorSprite = [CCSprite spriteWithFile:@"level_19_corridor.png"];
        corridorSprite.position = ccp(screen.width/2,screen.height/2);
        [self addChild:corridorSprite z:10];
        // corridorSprite.opacity = 200;
        
        //------------------ GRID (WHITE/BLACK) -----------------
        gridSprite = [CCSprite spriteWithFile:@"black_grid.png"];
        gridSprite.position = ccp(screen.width/2,screen.height/2);
        //  [self addChild:gridSprite z:100];
        gridSprite.opacity = 50;
        
        //------------------------ BOB -------------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        bobSpriteWidth = [bobSprite contentSize].width;
        //bobSprite.position = ccp(screen.width*2/7-8,screen.height*0.5-15);
        bobSprite.position = ccp(screen.width*2/15+7,screen.height*4.5/10-62);
        [self addChild:bobSprite z:300];
        
        
        //------------------------- WINDOW BACKSIDE 1 --------------------------
        windowBacksideSprite = [CCSprite spriteWithFile:@"window_backside.png"];
        windowBacksideSprite.position = ccp(screen.width*5.5/15+6-57+2,screen.height*4.5/10-2+57);
        [self addChild:windowBacksideSprite z:1];
        windowBacksideSprite.opacity = 255;
        //---------- LEFT WINDOW ---------
        leftWindowSprite = [CCSprite spriteWithFile:@"window_door.png"];
        leftWindowSprite.position = ccp(screen.width*5.5/15-32+6-57+2,screen.height*4.5/10-2+57);
        [self addChild:leftWindowSprite z:2];
        leftWindowSprite.opacity = 255;
        //---------- RIGHT WINDOW --------
        rightWindowSprite = [CCSprite spriteWithFile:@"window_door.png"];
        rightWindowSprite.position = ccp(screen.width*5.5/15+32+6-57+2,screen.height*4.5/10-2+57);
        [self addChild:rightWindowSprite z:2];
        rightWindowSprite.opacity = 255;
        
        //------------------------- WINDOW BACKSIDE 2 --------------------------
        windowBacksideSprite2 = [CCSprite spriteWithFile:@"window_backside.png"];
        windowBacksideSprite2.position = ccp(screen.width*9.5/15-8+57+2,screen.height*4.5/10-2+57);
        [self addChild:windowBacksideSprite2 z:1];
        windowBacksideSprite2.opacity = 255;
        //---------- LEFT WINDOW ---------
        leftWindowSprite2 = [CCSprite spriteWithFile:@"window_door.png"];
        leftWindowSprite2.position = ccp(screen.width*9.5/15-32-8+57+2,screen.height*4.5/10-2+57);
        [self addChild:leftWindowSprite2 z:2];
        leftWindowSprite2.opacity = 255;
        //---------- RIGHT WINDOW --------
        rightWindowSprite2 = [CCSprite spriteWithFile:@"window_door.png"];
        rightWindowSprite2.position = ccp(screen.width*9.5/15+32-8+57+2,screen.height*4.5/10-2+57);
        [self addChild:rightWindowSprite2 z:2];
        rightWindowSprite2.opacity = 255;
        
        //------------------------- WINDOW BACKSIDE 3 --------------------------
        windowBacksideSprite3 = [CCSprite spriteWithFile:@"window_backside.png"];
        windowBacksideSprite3.position = ccp(screen.width*5.5/15+6+58+2,screen.height*4.5/10-2);
        [self addChild:windowBacksideSprite3 z:1];
        windowBacksideSprite3.opacity = 255;
        //---------- LEFT WINDOW ---------
        leftWindowSprite3 = [CCSprite spriteWithFile:@"window_door.png"];
        leftWindowSprite3.position = ccp(screen.width*5.5/15-32+6+58+2,screen.height*4.5/10-2);
        [self addChild:leftWindowSprite3 z:2];
        leftWindowSprite3.opacity = 255;
        //---------- RIGHT WINDOW --------
        rightWindowSprite3 = [CCSprite spriteWithFile:@"window_door.png"];
        rightWindowSprite3.position = ccp(screen.width*5.5/15+32+6+58+2,screen.height*4.5/10-2);
        [self addChild:rightWindowSprite3 z:2];
        rightWindowSprite3.opacity = 255;
        
        
        counter = 0;
        
        
        
        [self schedule:@selector(closeWindow)];
        
        
    }
    return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    counter++;
    if((counter > 0) && (counter < 3))
    {
        bobSprite.position = ccp(bobSprite.position.x, bobSprite.position.y + 58);
        
    }
    
    if((counter >= 3) && (counter < 5))
    {
        bobSprite.position = ccp(bobSprite.position.x + 57, bobSprite.position.y);
    }
    
    if(counter == 5) 
    {
        bobSprite.position = ccp(bobSprite.position.x , bobSprite.position.y - 58);
        
        // [[CCDirector sharedDirector]replaceScene:
        //  [CCTransitionFade transitionWithDuration:1 scene:[Level_19 node]]];
    }
    
    if((counter > 5)&&(counter <= 7))
    {
        bobSprite.position = ccp(bobSprite.position.x + 57 , bobSprite.position.y );
    }
    
    if(counter == 8)
    {
        bobSprite.position = ccp(bobSprite.position.x  , bobSprite.position.y+ 58 );
    }
    
    if((counter > 8)&&(counter <= 10))
    {
        bobSprite.position = ccp(bobSprite.position.x + 57, bobSprite.position.y   );
    }
    if((counter > 10)&&(counter < 13))
    {
        bobSprite.position = ccp(bobSprite.position.x  , bobSprite.position.y- 58 );
        
    }
    if(counter == 12)
    {
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_20 node]]];
    }
}

-(void)closeWindow
{
    leftWindowSprite.position = ccp(leftWindowSprite.position.x+0.5, leftWindowSprite.position.y);
    rightWindowSprite.position = ccp(rightWindowSprite.position.x-0.5, rightWindowSprite.position.y);
    leftWindowSprite2.position = ccp(leftWindowSprite2.position.x+0.5, leftWindowSprite2.position.y);
    rightWindowSprite2.position = ccp(rightWindowSprite2.position.x-0.5, rightWindowSprite2.position.y);
    leftWindowSprite3.position = ccp(leftWindowSprite3.position.x+0.5, leftWindowSprite3.position.y);
    rightWindowSprite3.position = ccp(rightWindowSprite3.position.x-0.5, rightWindowSprite3.position.y);
    
    CGRect leftRect = [leftWindowSprite boundingBox];
    CGRect rightRect = [rightWindowSprite boundingBox];
    CGRect leftRect2 = [leftWindowSprite2 boundingBox];
    CGRect rightRect2 = [rightWindowSprite2 boundingBox];
    CGRect leftRect3 = [leftWindowSprite3 boundingBox];
    CGRect rightRect3 = [rightWindowSprite3 boundingBox];
    
    if(CGRectIntersectsRect(leftRect, rightRect))
    {
        [self unschedule:@selector(closeWindow)];
        //[self schedule:@selector(delayCloseWindow)];
        [self delayCloseWindow];
    }
    /* if(CGRectIntersectsRect(leftRect2, rightRect2))
     {
     [self unschedule:@selector(closeWindow)];
     //[self schedule:@selector(delayCloseWindow)];
     [self delayCloseWindow];
     }
     */
    
    if((counter == 3) || (counter == 6) || (counter == 9))
    {
        [self schedule:@selector(bobDiedAnimation:)];
    }
    
}

-(void)delayCloseWindow
{
    id delayAction = [CCDelayTime actionWithDuration:1.5];
    
    id callOpenWindow = [CCCallFunc actionWithTarget:self selector:@selector(callOpenWindow)];
    
    id sequenceAction = [CCSequence actions:delayAction,callOpenWindow, nil];
    
    [leftWindowSprite runAction:sequenceAction];
    [rightWindowSprite runAction:sequenceAction];
    [leftWindowSprite2 runAction:sequenceAction];
    [rightWindowSprite2 runAction:sequenceAction];
    [leftWindowSprite3 runAction:sequenceAction];
    [rightWindowSprite3 runAction:sequenceAction];
}

-(void)callOpenWindow
{
    [self schedule:@selector(openWindow)];
}

-(void)openWindow
{
    leftWindowSprite.position = ccp(leftWindowSprite.position.x-0.5, leftWindowSprite.position.y);
    rightWindowSprite.position = ccp(rightWindowSprite.position.x+0.5, rightWindowSprite.position.y);
    leftWindowSprite2.position = ccp(leftWindowSprite2.position.x-0.5, leftWindowSprite2.position.y);
    rightWindowSprite2.position = ccp(rightWindowSprite2.position.x+0.5, rightWindowSprite2.position.y);
    leftWindowSprite3.position = ccp(leftWindowSprite3.position.x-0.5, leftWindowSprite3.position.y);
    rightWindowSprite3.position = ccp(rightWindowSprite3.position.x+0.5, rightWindowSprite3.position.y);
    
    CGRect leftRect = [leftWindowSprite boundingBox];
    CGRect backsideRect = [windowBacksideSprite boundingBox];
    CGRect leftRect2 = [leftWindowSprite boundingBox];
    CGRect backsideRect2 = [windowBacksideSprite boundingBox];
    CGRect leftRect3 = [leftWindowSprite boundingBox];
    CGRect backsideRect3 = [windowBacksideSprite boundingBox];
    
    if(!(CGRectIntersectsRect(leftRect, backsideRect)))
    {
        [self unschedule:@selector(openWindow)];
        [self schedule:@selector(closeWindow)];
        
    }
    
    CGRect bobRect = [bobSprite boundingBox];
    
    if((counter == 3) || (counter == 6) || (counter == 9))
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
    
    
    [dieTimeLabel setString:[NSString stringWithFormat:@"%0.2f", dieFloat]];
    
    if(dieTime > 1.1)
    {
        [self unschedule:@selector(bobDiedAnimation:)];
        
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_19 node]]];
    }
    
}


@end