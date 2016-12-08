//
//  BoyIsDistracted.swift
//  Elenkos
//
//  Created by Dustin Allen on 11/10/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import Foundation
import SpriteKit

var person3 : SKSpriteNode!

class BoyIsDistracted: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = (UIColor.blueColor())
        
        let personAnimatedAtlas = SKTextureAtlas(named: "BoyStall")
        var walkFrames = [SKTexture]()
        let numImages = personAnimatedAtlas.textureNames.count
        
        for i in 1..<numImages {
            let personTextureName = "boyDistracted\(i)"
            walkFrames.append(personAnimatedAtlas.textureNamed(personTextureName))
        }
        
        personWalkingFrames = walkFrames
        let firstFrame = personWalkingFrames[0]
        person = SKSpriteNode(texture: firstFrame)
        person.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        person.size = CGSize.init(width: 100, height: 100)
        //let boyMoving = SKAction.moveByX(-100, y: 0, duration: 5)
        //person.runAction(boyMoving)
        addChild(person)
        
         let grandpaAnimatedAtlas = SKTextureAtlas(named: "GrandpaDistracted")
         var grandpaWalkFrames = [SKTexture]()
         let numImages1 = grandpaAnimatedAtlas.textureNames.count
         
         for i in 1..<numImages1 {
         let grandpaTextureName = "grandpaStall\(i)"
         grandpaWalkFrames.append(grandpaAnimatedAtlas.textureNamed(grandpaTextureName))
         }
         
         grandpaWalkingFrames = grandpaWalkFrames
         let grandpaFirstFrame = grandpaWalkingFrames[0]
         grandpa = SKSpriteNode(texture: grandpaFirstFrame)
         grandpa.position = CGPoint(x: CGRectGetMidX(self.frame) + 35, y:CGRectGetMidY(self.frame))
         grandpa.size = CGSize.init(width: 100, height: 100)
         let grandpaMoving = SKAction.moveByX(25, y: 0, duration: 8)
         let rotation = SKAction.rotateByAngle(-1, duration: 2.5)
         let rotateBack = SKAction.rotateByAngle(1, duration: 2)
         grandpa.runAction(rotation)
         grandpa.runAction(rotateBack)
         grandpa.runAction(grandpaMoving)
         addChild(grandpa)
        
        walkingPerson()
        walkingGrandpa()
        
        //let _ = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(BoyIsDistracted.removePerson), userInfo: nil, repeats: false)
        
        //let _ = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(BoyIsDistracted.walkingPersonContinuous), userInfo: nil, repeats: false)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func walkingPerson() {
        //This is our general runAction method to make our bear walk.
        
        //person2.runAction(SKAction.repeatAction(SKAction.animateWithTextures(personWalkingFrames, timePerFrame: 0.1, resize: false, restore: true), count: 1))
        
        person.runAction(SKAction.animateWithTextures(personWalkingFrames, timePerFrame: 0.1, resize: false, restore: false))
        
        /*
        person.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(personWalkingFrames,
                timePerFrame: 0.1,
                resize: false,
                restore: true)),
                         withKey:"walkingInPlaceBear")*/
    }
    
    func walkingGrandpa() {
        
        grandpa.runAction(SKAction.animateWithTextures(grandpaWalkingFrames, timePerFrame: 0.05, resize: false, restore: false))
        
        /*
        grandpa.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(grandpaWalkingFrames,
                timePerFrame: 0.025,
                resize: false,
                restore: true)),
                          withKey:"walkingInPlaceBear")*/
    }
    
    func walkingPersonContinuous() {
            let personAnimatedAtlas1 = SKTextureAtlas(named: "BoyWorking2")
            var walkFrames = [SKTexture]()
            let numImages = personAnimatedAtlas1.textureNames.count
            
            for i in 1..<numImages {
                let personTextureName = "boy2workpost\(i)"
                walkFrames.append(personAnimatedAtlas1.textureNamed(personTextureName))
            }
            
            _ = SKAction.animateWithTextures(walkFrames, timePerFrame: 5)
            let firstFrame = walkFrames[0]
            person2 = SKSpriteNode(texture: firstFrame)
            person2.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
            person2.size = CGSize.init(width: 100, height: 100)
            person2.zPosition = 1.0
            self.addChild(person2)
            
            person2.runAction(SKAction.repeatActionForever(
                SKAction.animateWithTextures(walkFrames,
                    timePerFrame: 0.1,
                    resize: false,
                    restore: true)),
                withKey:"walkingInPlacePerson2")
    }
    
    func removePerson() {
        person.removeFromParent()
    }
}
