//
//  TrainTextures.swift
//  Train
//
//  Created by Gabriel Rossi on 04/01/24.
//

import Foundation
import SpriteKit


class TrainTextures {
    
    static func getOpenDorTrainTextures() -> [SKTexture]{
        let textures: [SKTexture] = [
            SKTexture(imageNamed: "Train0") ,
            SKTexture(imageNamed: "Train1") ,
            SKTexture(imageNamed: "Train2") ,
            SKTexture(imageNamed: "Train3") ,
            SKTexture(imageNamed: "Train4") ,
            SKTexture(imageNamed: "Train5") ,
            SKTexture(imageNamed: "Train6") ,
            SKTexture(imageNamed: "Train7") ,
            SKTexture(imageNamed: "Train8")

        ]
        
        return textures
    }
    
    static func getCloseDorTrainTextures() -> [SKTexture]{
        let textures: [SKTexture] = [
            SKTexture(imageNamed: "Train8") ,
            SKTexture(imageNamed: "Train7") ,
            SKTexture(imageNamed: "Train6") ,
            SKTexture(imageNamed: "Train5") ,
            SKTexture(imageNamed: "Train4") ,
            SKTexture(imageNamed: "Train3") ,
            SKTexture(imageNamed: "Train2") ,
            SKTexture(imageNamed: "Train1") ,
            SKTexture(imageNamed: "Train0")
        ]
        
        return textures
    }
    
    static func getRunTrrainTextures() -> [SKTexture]{
        let textures = [
            SKTexture(imageNamed: "RunTrain0") ,
            SKTexture(imageNamed: "RunTrain1") ,
            SKTexture(imageNamed: "RunTrain2") ,
            SKTexture(imageNamed: "RunTrain3")
        ]
        
        return textures
    }
}


//MARK: Train config
extension GameScene {
    func setupRunTrainAnimation(delayAnimation: Double) {
        let textures = TrainTextures.getRunTrrainTextures()
        let runTrain = SKSpriteNode(texture: textures[0])
        
        runTrain.position = CGPoint(x: 0, y: -63)
        runTrain.zPosition = 7
        runTrain.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        runTrain.scale(to: CGSize(width: 747, height: 131))
        self.addChild(runTrain)
        
        let action = SKAction.animate(with: textures, timePerFrame: delayAnimation, resize: true, restore: true)
        runTrain.run(SKAction.repeatForever(action))
    }
    
    func delayRunTrainTextures(delay: Double){
        
        if(moveTrain){
            _ = Timer.scheduledTimer(withTimeInterval: delay, repeats: true) { [self] timer in
                
                moveTrain = false
                timer.invalidate()
            }
        } else {
                moveTrain = true
        }
    }
    
    func openTrainDor(delay: Double){
        _ = Timer.scheduledTimer(withTimeInterval: delay, repeats: true) { [self] timer in
            
            self.trainNode.removeFromParent()
            self.trainNode.removeAllActions()
            self.trainNode.removeAllChildren()
            
            let textures = TrainTextures.getOpenDorTrainTextures()
            self.trainNode = SKSpriteNode(texture: textures[0])
            self.trainNode.position = CGPoint(x: 0, y: -63)
            self.trainNode.zPosition = 6
            self.trainNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.trainNode.scale(to: CGSize(width: 747, height: 131))
            self.addChild(self.trainNode)
            
            let action = SKAction.animate(with: textures, timePerFrame: 0.07, resize: true, restore: false)
            self.trainNode.run(action)
            
            timer.invalidate()
        }
    }
    
    func closeTrainDor(delay: Double){
        _ = Timer.scheduledTimer(withTimeInterval: delay, repeats: true) { [self] timer in
                    
            self.trainNode.removeFromParent()
            self.trainNode.removeAllActions()
            self.trainNode.removeAllChildren()
            
            let textures = TrainTextures.getCloseDorTrainTextures()
            self.trainNode = SKSpriteNode(texture: textures[0])
            self.trainNode.position = CGPoint(x: 0, y: -63)
            self.trainNode.zPosition = 6
            self.trainNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.trainNode.scale(to: CGSize(width: 747, height: 131))
            self.addChild(self.trainNode)
            
            let action = SKAction.animate(with: textures, timePerFrame: 0.07, resize: true, restore: false)
            self.trainNode.run(action)
            timer.invalidate()
        }
    }
    
    func removeSpeed() {
        if(speedBackgroundPaisage > 0 ){
            speedBackgroundPaisage -= 1
        }
        if(speedBackgroundFlor > 0 ){
            speedBackgroundFlor -= 2
        }
        
        print(speedBackgroundFlor)
    }
    
    func addSpeed() {
        if(speedBackgroundPaisage < 6){//6
            speedBackgroundPaisage += 1
        }
        if(speedBackgroundFlor < 12 ){
            speedBackgroundFlor += 1
        }
        
        print(speedBackgroundFlor)
    }
}
