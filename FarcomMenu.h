//
//  FarcomMenu.h
//  GameplayPrototype30
//
//  Created by Артур on 12.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>

@interface FarcomMenu : CCLayer
{
    CCLabelTTF *label2;
    CCLabelTTF *label1;
    
    BOOL labelBool;
    
    
    
}

+(id)scene;

@end
