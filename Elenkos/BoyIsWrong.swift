//
//  BoyIsWrong.swift
//  Elenkos
//
//  Created by Dustin Allen on 11/10/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import Foundation
import SpriteKit

class BoyIsWrong: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        backgroundColor = (UIColor.blueColor())
        
        let personAnimatedAtlas = SKTextureAtlas(named: "BoyWrong")
        var walkFrames = [SKTexture]()
        let numImages = personAnimatedAtlas.textureNames.count
        
        for i in 1..<numImages {
            let personTextureName = "boyWrong\(i)"
            walkFrames.append(personAnimatedAtlas.textureNamed(personTextureName))
        }
        
        personWalkingFrames = walkFrames
        let firstFrame = personWalkingFrames[0]
        person2 = SKSpriteNode(texture: firstFrame)
        person2.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        person2.size = CGSize.init(width: 100, height: 100)
        //let boyMoving = SKAction.moveByX(-100, y: 0, duration: 0.5)
        //person.runAction(boyMoving)
        addChild(person2)
        
        let grandpaAnimatedAtlas = SKTextureAtlas(named: "GrandpaWrong")
        var grandpaWalkFrames = [SKTexture]()
        let numImages1 = grandpaAnimatedAtlas.textureNames.count
        
        for i in 1..<numImages1 {
            let grandpaTextureName = "grandpaFail\(i)"
            grandpaWalkFrames.append(grandpaAnimatedAtlas.textureNamed(grandpaTextureName))
        }
        
        grandpaWalkingFrames = grandpaWalkFrames
        let grandpaFirstFrame = grandpaWalkingFrames[0]
        grandpa = SKSpriteNode(texture: grandpaFirstFrame)
        grandpa.position = CGPoint(x: 250, y: 50)
        grandpa.size = CGSize.init(width: 100, height: 100)
        let grandpaMoving = SKAction.moveByX(-100, y: 0, duration: 0.5)
        grandpa.runAction(grandpaMoving)
        addChild(grandpa)
        
        walkingPerson()
        walkingGrandpa()
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func walkingPerson() {
        //This is our general runAction method to make our bear walk.
        person2.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(personWalkingFrames,
                timePerFrame: 0.05,
                resize: false,
                restore: true)),
                         withKey:"walkingInPlaceBear")
    }
    
    func walkingGrandpa() {
        grandpa.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(grandpaWalkingFrames,
                timePerFrame: 0.05,
                resize: false,
                restore: true)),
                          withKey:"walkingInPlaceBear")
    }
}
