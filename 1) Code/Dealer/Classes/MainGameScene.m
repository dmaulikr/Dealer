//
//  HelloWorldScene.m
//  Dealer
//
//  Created by M F J C Clowes on 22/08/2014.
//  Copyright M F J C Clowes 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "MainGameScene.h"
#import "IntroScene.h"

#pragma mark - MainGameScene

@implementation MainGameScene
{
    CCSprite *_bg;
    NSMutableArray* p1Units;
    NSMutableArray* p2Units;
}

@synthesize levelMap, level;

#pragma mark - Create & Destroy

+ (MainGameScene *)scene {
    return [[self alloc] init];
}

- (id)init {
    self = [super init];
    if (!self) return(nil);
    
    self.userInteractionEnabled = YES;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Add BG
    _bg = [CCSprite spriteWithImageNamed:@"menubg.png"];
    _bg.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    [self addChild:_bg];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];

    //create map
    [self createLevelMap];
    
    // Load units
    p1Units = [[NSMutableArray alloc] initWithCapacity:10];
    p2Units = [[NSMutableArray alloc] initWithCapacity:10];
    [self loadUnits:1];
    [self loadUnits:2];
    
	return self;
}

- (void)dealloc
{
    // clean up code goes here
}

#pragma mark - Enter & Exit
- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInteractionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

#pragma mark - Touch Handler

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    
    // Log touch location
    CCLOG(@"Move sprite to @ %@",NSStringFromCGPoint(touchLoc));
    
    // Do whatever}
}
#pragma mark - Button Callbacks

- (void)onBackClicked:(id)sender{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

- (void) createLevelMap{
    //Load the right the map
    if (level==1) {
        levelMap = [CCTiledMap tiledMapWithFile:@"Map.tmx"];
    }
    [self addChild:levelMap];
    
    mapHeight = levelMap.contentSize.height;
    mapWidth = levelMap.contentSize.width;
    
    distance = 150;
    lastGoodDistance = 150;
    mapScale = 1;
    
    // Get the background layer
    bgLayer = [levelMap layerNamed:@"Background"];
    // Get information for each tile in background layer
    tileDataArray = [[NSMutableArray alloc] initWithCapacity:5];
    for(int i = 0; i< levelMap.mapSize.height;i++) {
        for(int j = 0; j< levelMap.mapSize.width;j++) {
            int movementCost = 1;
            int defensiveBonus = 1;
            NSString * tileType = nil;
            int tileGid=[bgLayer tileGIDAt:ccp(j,i)];
            if (tileGid) {
                NSDictionary *properties = [levelMap propertiesForGID:tileGid];
                if (properties) {
                    movementCost = [[properties valueForKey:@"MovementCost"] intValue];
                    defensiveBonus = [[properties valueForKey:@"defensiveBonus"] intValue];
                    tileType = [properties valueForKey:@"TileType"];
                }
            }
            TileData * tData = [TileData nodeWithTheGame:_theGame movementCost:movementCost position:ccp(j,i) tileType:tileType];
            [tileDataArray addObject:tData];
        }
    }
}

-(void) loadUnits: (int)player{
    
}

@end
