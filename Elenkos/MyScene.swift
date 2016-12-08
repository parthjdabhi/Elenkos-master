//
//  MyScene.swift
//  
//
//  Created by Dustin Allen on 11/10/16.
//
//

import Foundation
import SpriteKit

var person : SKSpriteNode!
var grandpa : SKSpriteNode!
var girl : SKSpriteNode!
var personWalkingFrames : [SKTexture]!
var grandpaWalkingFrames : [SKTexture]!
var girlWalkingFrames : [SKTexture]!

class MyScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = (UIColor.blueColor())
        
        let personAnimatedAtlas = SKTextureAtlas(named: "BoyCorrect")
        let grandpaAnimatedAtlas = SKTextureAtlas(named: "GrandpaCorrect")
        let girlAnimatedAtlas = SKTextureAtlas(named: "GirlCorrect")
        
        var girlWalkFrames = [SKTexture]()
        var walkFrames = [SKTexture]()
        var grandpaWalkFrames = [SKTexture]()
        
        let numImages = personAnimatedAtlas.textureNames.count
        for i in 1..<numImages {
            let personTextureName = "boyCorrect\(i)"
            walkFrames.append(personAnimatedAtlas.textureNamed(personTextureName))
        }
        
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
        
        personWalkingFrames = walkFrames
        grandpaWalkingFrames = grandpaWalkFrames
        girlWalkingFrames = girlWalkFrames
        
        let firstFrame = personWalkingFrames[0]
        let grandpaFirstFrame = grandpaWalkingFrames[0]
        let girlFirstFrame = girlWalkingFrames[0]
        person = SKSpriteNode(texture: firstFrame)
        grandpa = SKSpriteNode(texture: grandpaFirstFrame)
        girl = SKSpriteNode(texture: girlFirstFrame)
        person.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        grandpa.position = CGPoint(x: 350, y: 50)
        girl.position = CGPoint(x: 75, y: 50)
        person.size = CGSize.init(width: 100, height: 100)
        grandpa.size = CGSize.init(width: 100, height: 100)
        girl.size = CGSize.init(width: 100, height: 100)
        addChild(person)
        addChild(grandpa)
        addChild(girl)
        
        walkingPerson()
        walkingGrandpa()
        walkingGirl()
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func walkingPerson() {
        //This is our general runAction method to make our bear walk.
        person.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(personWalkingFrames,
                timePerFrame: 0.025,
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
