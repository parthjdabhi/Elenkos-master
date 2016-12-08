//
//  BoyIsWorkingContinuous.swift
//  Elenkos
//
//  Created by Dustin Allen on 11/20/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import Foundation
import SpriteKit

class BoyIsWorkingContinuous: SKScene {

    override func didMoveToView(view: SKView) {
        
        backgroundColor = (UIColor.blueColor())
        
        let personAnimatedAtlas = SKTextureAtlas(named: "BoyWorking2")
        var walkFrames = [SKTexture]()
        let numImages = personAnimatedAtlas.textureNames.count
        
        for i in 1..<numImages {
            let personTextureName = "boy2workpost\(i)"
            walkFrames.append(personAnimatedAtlas.textureNamed(personTextureName))
        }
        
        personWalkingFrames = walkFrames
        _ = SKAction.animateWithTextures(walkFrames, timePerFrame: 5)
        let firstFrame = walkFrames[0]
        person3 = SKSpriteNode(texture: firstFrame)
        person3.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        person3.size = CGSize.init(width: 100, height: 100)
        addChild(person3)
        
        let grandpaAnimatedAtlas = SKTextureAtlas(named: "GrandpaWorking2")
        var grandpaWalkFrames = [SKTexture]()
        let numImages1 = grandpaAnimatedAtlas.textureNames.count
        
        for i in 1..<numImages1 {
            let grandpaTextureName = "grandpa2Working\(i)"
            grandpaWalkFrames.append(grandpaAnimatedAtlas.textureNamed(grandpaTextureName))
        }
        
        grandpaWalkingFrames = grandpaWalkFrames
        let grandpaFirstFrame = grandpaWalkingFrames[0]
        grandpa = SKSpriteNode(texture: grandpaFirstFrame)
        grandpa.position = CGPoint(x: 250, y: 50)
        grandpa.size = CGSize.init(width: 100, height: 100)
        addChild(grandpa)
        
        walkingPerson()
        walkingGrandpa()
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func walkingPerson() {
        person3.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(personWalkingFrames,
                timePerFrame: 0.1,
                resize: false,
                restore: true)),
                         withKey:"walkingInPlaceBear")
    }
    
    func walkingGrandpa() {
        grandpa.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(grandpaWalkingFrames,
                timePerFrame: 0.025,
                resize: false,
                restore: true)),
                          withKey:"walkingInPlaceGrandpa")
    }
}

