//
//  Level_17.m
//  GameplayPrototype30
//
//  Created by Артур on 14.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level_17.h"
#import "Level_18.h"

@implementation Level_17

+(id)scene
{
    CCScene *scene = [CCScene node];
    Level_17 *layer = [Level_17 node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    if((self = [super init]))
    {
        CGSize screen = [CCDirector sharedDirector].winSize;
        self.isTouchEnabled = YES;
        
        //------------------- LEVEL BACKGROUND -----------------
        CCSprite *backgroundSprite = [CCSprite spriteWithFile:@"level_19.png"];
        float backgroundSpriteHeight = [backgroundSprite contentSize].height;
        backgroundSprite.position = ccp(screen.width/2,backgroundSpriteHeight/2);
        [self addChild:backgroundSprite];
        
        //------------------- UPSIDE -----------------
        upsideSprite = [CCSprite spriteWithFile:@"level_19_upside.png"];
        upsideSprite.anchorPoint = ccp(0,1);
        upsideSprite.position = ccp(0,screen.height-3);
        [self addChild:upsideSprite z:100];
        
        //------------------ BOB -------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        float bobSpriteWidth = [bobSprite contentSize].width;
        bobSprite.position = ccp(-bobSpriteWidth/2,screen.height*0.265);
        [self addChild:bobSprite];
        
        //------------------ ARROWS 2 -----------------
        arrowSprite1 = [CCSprite spriteWithFile:@"arrow.png"];
        arrowSprite1.position = ccp(screen.width*2/6,screen.height*2/3);
        [self addChild:arrowSprite1 z:11];
        
        arrowSprite2 = [CCSprite spriteWithFile:@"arrow.png"];
        arrowSprite2.position = ccp(screen.width*4/6,screen.height*2/3);
        [self addChild:arrowSprite2 z:12];
        
        //------------------- BLACK PIPE ----------------------------
        blackPipeSprite = [CCSprite spriteWithFile:@"black_pipe.png"];
        blackPipeSprite.position = ccp(screen.width*3/6, screen.height*8/9-20);
        [self addChild:blackPipeSprite z:12];
        blackPipeSprite.scaleY = 1.3;
         blackPipeSprite.scaleX = 1.5;
        
        
        
        
        [self schedule:@selector(bobRunningUpdate)];
        [self schedule:@selector(blackPipeFallDownUpdate)];
        //[self schedule:@selector(blackPipeFallUpUpdate)];
        
        [self schedule:@selector(blackPipeBobCollide)];
        
        [self schedule:@selector(bobArrowRectangleCollide)];
        [self schedule:@selector(bobArrowCollide)];
        
    }
    return self;
}
-(void)blackPipeBobCollide
{
    CGSize screen = [CCDirector sharedDirector].winSize;
    
    CGRect bobRect = [bobSprite boundingBox];
    
    blackPipeSprite.scaleX = 1;
    CGRect blackPipeRect = [blackPipeSprite boundingBox];
    blackPipeSprite.scaleX = 1.5;
    
    if(CGRectIntersectsRect(blackPipeRect, bobRect))
    {
        bobSprite.opacity = 0;
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:0.5 scene:[Level_17 node]]];
        
    }
    
    
    
}

-(void)blackPipeFallUpUpdate
{
    CGSize screen = [CCDirector sharedDirector].winSize; 
    
    if(blackPipeSprite.position.y < screen.height*0.9)
    {
        blackPipeSprite.position = ccp(blackPipeSprite.position.x,blackPipeSprite.position.y + 100*0.022); 
    }
    else
    {
        [self unschedule:@selector(blackPipeFallUpUpdate)];
        [self schedule:@selector(blackPipeFallDownUpdate)];
    }
}
-(void)bobRunningUpdate
{
    //CCLOG(@"inside runningBobUpdate!!!");
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    float bobSpriteWidth = [bobSprite contentSize].width;
    
    bobSprite.position = ccp(bobSprite.position.x + 100*0.016, bobSprite.position.y);
    
    if(bobSprite.position.x > screenSize.width-bobSpriteWidth/2)
    {
        bobSprite.position = ccp(-bobSpriteWidth/2,bobSprite.position.y);
        [[CCDirector sharedDirector] sendCleanupToScene];
        [[CCDirector sharedDirector]replaceScene:
         [CCTransitionFade transitionWithDuration:1 scene:[Level_18 node]]];
    }
}


-(void)blackPipeFallDownUpdate
{
    CGSize screen = [CCDirector sharedDirector].winSize;
    // blackPipeSprite.anchorPoint = ccp(0.5,0);
    
    
    //blackPipeSprite.position = ccp(blackPipeSprite.position.x,blackPipeSprite.position.y - 100*0.020);
    
    /*if(blackPipeSprite.position.y == screen.height/3)
     {
     id backAction = [CCMoveTo actionWithDuration:1 position:ccp(blackPipeSprite.position.x,screen.height*5/6)];
     
     [blackPipeSprite runAction:backAction];
     }*/
    
    if(blackPipeSprite.position.y > screen.height/3+35)
    {
        blackPipeSprite.position = ccp(blackPipeSprite.position.x,blackPipeSprite.position.y - 100*0.044); 
    }
    else
    {
        [self unschedule:@selector(blackPipeFallDownUpdate)];
        [self schedule:@selector(blackPipeFallUpUpdate)];
    }
    
    //if(blackPipeSprite.position.y == )
    /*if(blackPipeSprite.position.y < screen.height/3)
     {
     blackPipeSprite.position = ccp(blackPipeSprite.position.x,blackPipeSprite.position.y + 100*0.020); 
     }
     */
    
}



-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self unschedule:@selector(bobRunningUpdate)];
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self schedule:@selector(bobRunningUpdate)];
}

-(void)bobArrowRectangleCollide
{
    bobSprite.scaleX = 0.7;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scaleX = 1;
    
    arrowSprite1.scaleY = 15;
    arrowSprite1.scaleX = 1.2;
    CGRect arrowRect1 = [arrowSprite1 boundingBox];
    arrowSprite1.scaleY = 1;
    arrowSprite1.scaleX = 1;
    
    arrowSprite2.scaleY = 15;
    arrowSprite2.scaleX = 1.2;
    CGRect arrowRect2 = [arrowSprite2 boundingBox];
    arrowSprite2.scaleY = 1;
    arrowSprite2.scaleX = 1;
    
    if(CGRectIntersectsRect(arrowRect1, bobRect))
    {
        [self schedule:@selector(arrow1FallDown)];
    }
    else
    {
        [self unschedule:@selector(arrow1FallDown)];
    }
    
    
    if(CGRectIntersectsRect(arrowRect2, bobRect))
    {
        [self schedule:@selector(arrow2FallDown)];
    }
    else
    {
        [self unschedule:@selector(arrow2FallDown)];
    }
    
}

-(void)arrow1FallDown
{
    arrowSprite1.position = ccp(arrowSprite1.position.x,arrowSprite1.position.y-100*0.03);
}

-(void)arrow2FallDown
{
    arrowSprite2.position = ccp(arrowSprite2.position.x,arrowSprite2.position.y-100*0.03);
}

-(void)bobArrowCollide
{
    bobSprite.scale = 0.5;
    CGRect bobRect = [bobSprite boundingBox];
    bobSprite.scale = 1;
    CGRect arrowRect1 = [arrowSprite1 boundingBox];
    CGRect arrowRect2 = [arrowSprite2 boundingBox];
    
    if(CGRectIntersectsRect(arrowRect1, bobRect))
    {
        CCLOG(@"!!!!!!BOB INTERSECT ARROW!!!!!");
        bobSprite.opacity = 0;
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:0.5 scene:[Level_17 node]]];
    }
    
    if(CGRectIntersectsRect(arrowRect2, bobRect))
    {
        CCLOG(@"!!!!!!BOB INTERSECT ARROW!!!!!");
        bobSprite.opacity = 0;
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:0.5 scene:[Level_17 node]]];
    }
}



@end
