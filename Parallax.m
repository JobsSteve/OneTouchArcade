//
//  Parallax.m
//  GameplayPrototype30
//
//  Created by Артур on 13.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Parallax.h"

@implementation Parallax

+(id)scene
{
    CCScene *scene = [CCScene node];
    Parallax *layer = [Parallax node];
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
        
        //------------------- LEVEL BACKGROUND -----------------
        backgroundSprite = [CCSprite spriteWithFile:@"level_8.png"];
        backgroundSpriteHeight = [backgroundSprite contentSize].height;
        backgroundSprite.position = ccp(screen.width/2,backgroundSpriteHeight/2);
        //[sвelf addChild:backgroundSprite z:0];
        
        //------------- PARALLAX:BACKSIDE,MORTALWALLS -------------
        parallax = [CCParallaxNode node];
        backsideSprite1 = [CCSprite spriteWithFile:@"level_8_backside.png"];
        backsideSprite2 = [CCSprite spriteWithFile:@"level_8_backside.png"];
        backsideSprite3 = [CCSprite spriteWithFile:@"level_8_backside.png"];
        backsideSprite4 = [CCSprite spriteWithFile:@"level_8_backside.png"];
        
        mortalwallsSprite1 = [CCSprite spriteWithFile:@"level_8_mortalwalls.png"];
        mortalwallsSprite2 = [CCSprite spriteWithFile:@"level_8_mortalwalls.png"];
        mortalwallsSprite3 = [CCSprite spriteWithFile:@"level_8_mortalwalls.png"];
        mortalwallsSprite4 = [CCSprite spriteWithFile:@"level_8_mortalwalls.png"];
        
        [parallax addChild:backsideSprite1 z:1 parallaxRatio:ccp(0.1,0.1) 
            positionOffset:ccp(200,screen.height/2) ];
        [parallax addChild:backsideSprite2 z:2 parallaxRatio:ccp(0.1,0.1) 
            positionOffset:ccp(680,screen.height/2) ];
        [parallax addChild:backsideSprite3 z:1 parallaxRatio:ccp(0.1,0.1) 
            positionOffset:ccp(1160,screen.height/2) ];
        [parallax addChild:backsideSprite4 z:2 parallaxRatio:ccp(0.1,0.1) 
            positionOffset:ccp(1640,screen.height/2) ];
        
        [parallax addChild:mortalwallsSprite1 z:1 parallaxRatio:ccp(0.1,0.1) 
            positionOffset:ccp(200,screen.height/2) ];
        [parallax addChild:mortalwallsSprite2 z:2 parallaxRatio:ccp(0.1,0.1) 
            positionOffset:ccp(680-1,screen.height/2) ];
        [parallax addChild:mortalwallsSprite3 z:1 parallaxRatio:ccp(0.1,0.1) 
            positionOffset:ccp(1160-2,screen.height/2) ];
        [parallax addChild:mortalwallsSprite4 z:2 parallaxRatio:ccp(0.1,0.1) 
            positionOffset:ccp(1640-3,screen.height/2) ];
        
        [self addChild:parallax z:1];
        
        
        
        
        
        //------------------ GRID (WHITE/BLACK) -----------------
        gridSprite = [CCSprite spriteWithFile:@"black_grid.png"];
        gridSprite.position = ccp(screen.width/2,screen.height/2);
        [self addChild:gridSprite z:100];
        gridSprite.opacity = 50;
        
        //------------------------- BOB -------------------------
        bobSprite = [CCSprite spriteWithFile:@"bob_anim_1.png"];
        bobSpriteWidth = [bobSprite contentSize].width;
        bobSprite.position = ccp(-bobSpriteWidth/2,screen.height*0.265);
        [self addChild:bobSprite z:10];
        
        
        
        
      //  [self schedule:@selector(bobRunningUpdate)];
        
        [self schedule:@selector(parallaxUpdate:)];
        
    }
    return self;
}

-(void)parallaxUpdate:(ccTime)delta
{
    CCLOG(@"its work !!!");
    //parallax.position = ccp(parallax.position.x - (delta / 5),parallax.position.y);
    
    /* CGPoint currentPos = [parallax position];
     currentPos = ccp(currentPos.x - (delta / 5),currentPos.y);
     [parallax setPosition: currentPos];
     */
    
    CGPoint backgroundScrollVel = ccp(-1000, 0);
    parallax.position = ccpAdd(parallax.position, ccpMult(backgroundScrollVel, delta));
    
    if(parallax.position.x < -14100)
    {
        parallax.position = ccp(0,screenSize.height/2);
    }
}


@end
