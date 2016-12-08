//
//  BoyIsCorrect2.swift
//  Elenkos
//
//  Created by Dustin Allen on 11/29/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import Foundation
import SpriteKit

class BoyIsCorrect2: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = (UIColor.blueColor())
        
        let personAnimatedAtlas = SKTextureAtlas(named: "BoyCorrect2")
        var walkFrames = [SKTexture]()
        let numImages = personAnimatedAtlas.textureNames.count
        
        for i in 1..<numImages {
            let personTextureName = "boy2correct\(i)"
            walkFrames.append(personAnimatedAtlas.textureNamed(personTextureName))
        }
        
        personWalkingFrames = walkFrames
        let firstFrame = personWalkingFrames[0]
        person = SKSpriteNode(texture: firstFrame)
        person.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        person.size = CGSize.init(width: 100, height: 100)
        //let boyMoving = SKAction.moveByX(100, y: 0, duration: 0.5)
        //person.runAction(boyMoving)
        addChild(person)
        
        let grandpaAnimatedAtlas = SKTextureAtlas(named: "GrandpaCorrect2")
        var grandpaWalkFrames = [SKTexture]()
        let numImages1 = grandpaAnimatedAtlas.textureNames.count
        
        for i in 1..<numImages1 {
            let grandpaTextureName = "grandpa2correct\(i)"
            grandpaWalkFrames.append(grandpaAnimatedAtlas.textureNamed(grandpaTextureName))
        }
        
        grandpaWalkingFrames = grandpaWalkFrames
        let grandpaFirstFrame = grandpaWalkingFrames[0]
        grandpa = SKSpriteNode(texture: grandpaFirstFrame)
        grandpa.position = CGPoint(x: 250, y: 50)
        grandpa.size = CGSize.init(width: 100, height: 100)
        //let grandpaMoving = SKAction.moveByX(100, y: 0, duration: 0.5)
        //grandpa.runAction(grandpaMoving)
        addChild(grandpa)
        
        walkingPerson()
        walkingGrandpa()
        
        let _ = NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: #selector(BoyIsCorrect.removeThePerson), userInfo: nil, repeats: false)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func walkingPerson() {
        //This is our general runAction method to make our bear walk.
        person.runAction(SKAction.repeatActionForever(
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
    
    func removeThePerson() {
        grandpa.removeFromParent()
    }
}
