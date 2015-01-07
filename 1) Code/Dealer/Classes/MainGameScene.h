//
//  HelloWorldScene.h
//  Dealer
//
//  Created by M F J C Clowes on 22/08/2014.
//  Copyright M F J C Clowes 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

@interface MainGameScene : CCScene {
    
}

@property CCTiledMap* levelMap;
@property int level;


+ (MainGameScene *)scene;
- (id)init;

@end