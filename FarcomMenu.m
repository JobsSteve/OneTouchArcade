//
//  FarcomMenu.m
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SimpleAudioEngine.h"

#import "FarcomMenu.h"
#import "Level_1.h"
#import "Level_2.h"
#import "Level_3.h"
#import "Level_4.h"
#import "Level_5.h"
#import "Level_6.h"
#import "Level_7.h"
#import "Parallax.h"
#import "Level_8.h"
#import "Level_9.h"
#import "Level_10.h"
#import "Level_11.h"
#import "Level_12.h"
#import "Level_13.h"
#import "Level_14.h"
#import "Level_15.h"

#import "Level_17.h"


#import "Level_19.h"
#import "Level_18.h"
#import "Level_20.h"

#import "Level_22.h"

@implementation FarcomMenu

+(id) scene {
	CCScene *scene = [CCScene node];
	FarcomMenu *layer = [FarcomMenu node];
	[scene addChild: layer];

	return scene;
}

-(id) init{
	if( (self=[super init] )) 
    {
        CGSize screen = [CCDirector sharedDirector].winSize;
		self.isTouchEnabled = YES;
        
          [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"one_bb_theme.mp3"];
  
        CCSprite *bkSprite = [CCSprite spriteWithFile:@"Default.png"];
        //bkSprite.anchorPoint = ccp(0,0);
        bkSprite.position = ccp(screen.width/2,screen.height/2);
        bkSprite.rotation = -90;
        bkSprite.scale = 0.5;
        [self addChild:bkSprite z:0];
        
        label1 = [CCLabelTTF labelWithString:@"One Touch Story (30 Levels)"
                                                fontName:@"Marker Felt"
                                                fontSize:17];
		label1.position = ccp(screen.width/2,screen.height*0.2);
        label1.opacity = 148;
        [self addChild: label1 z:11];
        
        label2 = [CCLabelTTF labelWithString:@"Tap to play"
                                                fontName:@"Marker Felt"
                                                fontSize:15];
		label2.position = ccp(screen.width/2,screen.height*0.1);
        label2.opacity = 128;
        
		[self schedule:@selector(showLabel) interval:0.3];
		[self addChild: label2 z:10];
        
        labelBool = YES;
        
        [self playMusic];
	}
	return self;
}

-(void)playMusic
{
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"one_bb_theme.mp3"];
}

-(void)showLabel
{
    
    if(labelBool == YES)
    {
        labelBool = NO;
    }
    else
    {
        labelBool = YES;
    }
    
    if(labelBool == YES)
    {
        label2.opacity = 100; 
    }
    else
    {
        label2.opacity = 128;
    }
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Level_1
                                                                                                node]]];
	//return YES;
}




@end
