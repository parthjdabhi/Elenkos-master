//
//  BoyIsWorking.swift
//  Elenkos
//
//  Created by Dustin Allen on 11/10/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import Foundation
import SpriteKit

var person2 : SKSpriteNode!
var personWalkingFrames2 : [SKTexture]!

class BoyIsWorking: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = (UIColor.blueColor())
        
        let personAnimatedAtlas = SKTextureAtlas(named: "BoyWorking")
        var walkFrames = [SKTexture]()
        let numImages = personAnimatedAtlas.textureNames.count
        
        for i in 1..<numImages {
            let personTextureName = "boyWorking\(i)"
            walkFrames.append(personAnimatedAtlas.textureNamed(personTextureName))
        }
        
        personWalkingFrames = walkFrames
        _ = SKAction.animateWithTextures(walkFrames, timePerFrame: 5)
        let firstFrame = personWalkingFrames[0]
        person = SKSpriteNode(texture: firstFrame)
        person.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        person.size = CGSize.init(width: 100, height: 100)
        addChild(person)
        
         let grandpaAnimatedAtlas = SKTextureAtlas(named: "GrandpaWorking")
         var grandpaWalkFrames = [SKTexture]()
         let numImages1 = grandpaAnimatedAtlas.textureNames.count
         
         for i in 1..<numImages1 {
         let grandpaTextureName = "grandpaWorking\(i)"
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
        
        let _ = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: #selector(BoyIsWorking.removeThePerson), userInfo: nil, repeats: false)
        
        let _ = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: #selector(BoyIsWorking.walkingPerson2), userInfo: nil, repeats: false)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func walkingPerson() {
        person.runAction(SKAction.repeatActionForever(
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
    
    func removeThePerson() {
        person.removeFromParent()
    }
    
    func walkingPerson2() {
        let personAnimatedAtlas = SKTextureAtlas(named: "BoyWorking2")
        var walkFrames = [SKTexture]()
        let numImages = personAnimatedAtlas.textureNames.count
        
        for i in 1..<numImages {
            let personTextureName = "boy2workpost\(i)"
            walkFrames.append(personAnimatedAtlas.textureNamed(personTextureName))
        }

        _ = SKAction.animateWithTextures(walkFrames, timePerFrame: 5)
        let firstFrame = walkFrames[0]
        person2 = SKSpriteNode(texture: firstFrame)
        person2.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        person2.size = CGSize.init(width: 100, height: 100)
        addChild(person2)
        
        person2.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(walkFrames,
                timePerFrame: 0.1,
                resize: false,
                restore: true)),
                         withKey:"walkingInPlacePerson2")
    }
}
