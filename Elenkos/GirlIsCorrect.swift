//
//  GirlIsCorrect.swift
//  Elenkos
//
//  Created by Dustin Allen on 11/10/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import Foundation
import SpriteKit

class GirlIsCorrect: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = (UIColor.blueColor())
        
        let grandpaAnimatedAtlas = SKTextureAtlas(named: "GrandpaCorrect")
        let girlAnimatedAtlas = SKTextureAtlas(named: "GirlCorrect")
        var girlWalkFrames = [SKTexture]()
        var grandpaWalkFrames = [SKTexture]()
        
        let numImages1 = grandpaAnimatedAtlas.textureNames.count
        for i in 1..<numImages1 {
            let grandpaTextureName = "grandpaCorrect\(i)"
            grandpaWalkFrames.append(grandpaAnimatedAtlas.textureNamed(grandpaTextureName))
        }
        
        let numImages2 = girlAnimatedAtlas.textureNames.count
        for i in 1..<numImages2 {
            let girlTextureName = "girlCorrect\(i)"
            print(girlTextureName)
            girlWalkFrames.append(girlAnimatedAtlas.textureNamed(girlTextureName))
        }
        
        grandpaWalkingFrames = grandpaWalkFrames
        girlWalkingFrames = girlWalkFrames
        let grandpaFirstFrame = grandpaWalkingFrames[0]
        let girlFirstFrame = girlWalkingFrames[0]
        grandpa = SKSpriteNode(texture: grandpaFirstFrame)
        girl = SKSpriteNode(texture: girlFirstFrame)
        grandpa.position = CGPoint(x: 350, y: 50)
        girl.position = CGPoint(x: 75, y: 50)
        grandpa.size = CGSize.init(width: 100, height: 100)
        girl.size = CGSize.init(width: 100, height: 100)
        addChild(grandpa)
        addChild(girl)
        
        walkingGrandpa()
        walkingGirl()
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func walkingGrandpa() {
        grandpa.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(grandpaWalkingFrames,
                timePerFrame: 0.025,
                resize: false,
                restore: true)),
                          withKey:"walkingInPlaceBear")
    }
    
    func walkingGirl() {
        girl.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(girlWalkingFrames,
                timePerFrame: 0.025,
                resize: false,
                restore: true)),
                       withKey:"walkingInPlaceGirl")
    }
}