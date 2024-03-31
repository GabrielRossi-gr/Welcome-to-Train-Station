//
//  BoxTextures.swift
//  TrainWWDC
//
//  Created by Gabriel Rossi on 17/01/24.
//

import Foundation
import SpriteKit

class BoxTextures{
    
    static func getRedTextures() -> [SKTexture]{
       
        let textures: [SKTexture] = [
            SKTexture(imageNamed: "RedBox0") ,
            SKTexture(imageNamed: "RedBox1") ,
            SKTexture(imageNamed: "RedBox2") ,
            SKTexture(imageNamed: "RedBox3") ,
            SKTexture(imageNamed: "RedBox4") ,
            SKTexture(imageNamed: "RedBox5") ,
            SKTexture(imageNamed: "RedBox6") ,
            SKTexture(imageNamed: "RedBox7") ,
            SKTexture(imageNamed: "RedBox8") ,
            SKTexture(imageNamed: "RedBox9") ,
            SKTexture(imageNamed: "RedBox10") ,
            SKTexture(imageNamed: "RedBox11") ,
            SKTexture(imageNamed: "RedBox12") ,
            SKTexture(imageNamed: "RedBox13") ,
            SKTexture(imageNamed: "RedBox14") ,
            SKTexture(imageNamed: "RedBox15") ,
            SKTexture(imageNamed: "RedBox16") ,
            SKTexture(imageNamed: "RedBox17") ,
            SKTexture(imageNamed: "RedBox18") ,
            SKTexture(imageNamed: "RedBox19") ,
            SKTexture(imageNamed: "RedBox20") ,
            SKTexture(imageNamed: "RedBox21") ,
            SKTexture(imageNamed: "RedBox22") ,
            SKTexture(imageNamed: "RedBox23") ,
            SKTexture(imageNamed: "RedBox24") ,
            SKTexture(imageNamed: "RedBox25") ,
            SKTexture(imageNamed: "RedBox26") ,
            SKTexture(imageNamed: "RedBox27") ,
            SKTexture(imageNamed: "RedBox28") ,
            SKTexture(imageNamed: "RedBox29")
        ]
        
        return textures
    }
    
    static func getBlueTextures() -> [SKTexture]{
       
        let textures: [SKTexture] = [
            SKTexture(imageNamed: "BlueBox0") ,
            SKTexture(imageNamed: "BlueBox1") ,
            SKTexture(imageNamed: "BlueBox2") ,
            SKTexture(imageNamed: "BlueBox3") ,
            SKTexture(imageNamed: "BlueBox4") ,
            SKTexture(imageNamed: "BlueBox5") ,
            SKTexture(imageNamed: "BlueBox6") ,
            SKTexture(imageNamed: "BlueBox7") ,
            SKTexture(imageNamed: "BlueBox8") ,
            SKTexture(imageNamed: "BlueBox9") ,
            SKTexture(imageNamed: "BlueBox10") ,
            SKTexture(imageNamed: "BlueBox11") ,
            SKTexture(imageNamed: "BlueBox12") ,
            SKTexture(imageNamed: "BlueBox13") ,
            SKTexture(imageNamed: "BlueBox14") ,
            SKTexture(imageNamed: "BlueBox15") ,
            SKTexture(imageNamed: "BlueBox16") ,
            SKTexture(imageNamed: "BlueBox17") ,
            SKTexture(imageNamed: "BlueBox18") ,
            SKTexture(imageNamed: "BlueBox19") ,
            SKTexture(imageNamed: "BlueBox20") ,
            SKTexture(imageNamed: "BlueBox21") ,
            SKTexture(imageNamed: "BlueBox22") ,
            SKTexture(imageNamed: "BlueBox23") ,
            SKTexture(imageNamed: "BlueBox24") ,
            SKTexture(imageNamed: "BlueBox25") ,
            SKTexture(imageNamed: "BlueBox26") ,
            SKTexture(imageNamed: "BlueBox27") ,
            SKTexture(imageNamed: "BlueBox28") ,
            SKTexture(imageNamed: "BlueBox29")
        ]
        
        return textures
    }

    static func getGreenTextures() -> [SKTexture]{
       
        let textures: [SKTexture] = [
            SKTexture(imageNamed: "GreenBox0") ,
            SKTexture(imageNamed: "GreenBox1") ,
            SKTexture(imageNamed: "GreenBox2") ,
            SKTexture(imageNamed: "GreenBox3") ,
            SKTexture(imageNamed: "GreenBox4") ,
            SKTexture(imageNamed: "GreenBox5") ,
            SKTexture(imageNamed: "GreenBox6") ,
            SKTexture(imageNamed: "GreenBox7") ,
            SKTexture(imageNamed: "GreenBox8") ,
            SKTexture(imageNamed: "GreenBox9") ,
            SKTexture(imageNamed: "GreenBox10") ,
            SKTexture(imageNamed: "GreenBox11") ,
            SKTexture(imageNamed: "GreenBox12") ,
            SKTexture(imageNamed: "GreenBox13") ,
            SKTexture(imageNamed: "GreenBox14") ,
            SKTexture(imageNamed: "GreenBox15") ,
            SKTexture(imageNamed: "GreenBox16") ,
            SKTexture(imageNamed: "GreenBox17") ,
            SKTexture(imageNamed: "GreenBox18") ,
            SKTexture(imageNamed: "GreenBox19") ,
            SKTexture(imageNamed: "GreenBox20") ,
            SKTexture(imageNamed: "GreenBox21") ,
            SKTexture(imageNamed: "GreenBox22") ,
            SKTexture(imageNamed: "GreenBox23") ,
            SKTexture(imageNamed: "GreenBox24") ,
            SKTexture(imageNamed: "GreenBox25") ,
            SKTexture(imageNamed: "GreenBox26") ,
            SKTexture(imageNamed: "GreenBox27") ,
            SKTexture(imageNamed: "GreenBox28") ,
            SKTexture(imageNamed: "GreenBox29")
        ]
        
        return textures
    }
}


//MARK: Box animation
extension GameScene {
    
    func runRedBoxAnimation(delayAnimation: Double){
        self.beltNode.removeAllActions()
        let action = SKAction.animate(with: redBoxtextures, timePerFrame: delayAnimation, resize: true, restore: false)
        self.beltNode.run(action)
    }
    
    func runBlueBoxAnimation(delayAnimation: Double){
        self.beltNode.removeAllActions()
        let action = SKAction.animate(with: blueBoxtestures, timePerFrame: delayAnimation, resize: true, restore: false)
        self.beltNode.run(action)
    }
    
    func runGreenBoxAnimation(delayAnimation: Double){
        self.beltNode.removeAllActions()
        let action = SKAction.animate(with: greenBoxtextures, timePerFrame: delayAnimation, resize: true, restore: false)
        self.beltNode.run(action)
    }

    
//    //reversed animate
//    func runReverseRedBoxAnimation(delayAnimation: Double){
//        self.beltNode.removeAllActions()
//        let action = SKAction.animate(with: redReverseBoxtextures, timePerFrame: delayAnimation, resize: true, restore: false)
//        self.beltNode.run(action)
//    }
//    
//    func runReverseGreenBoxAnimation(delayAnimation: Double){
//        self.beltNode.removeAllActions()
//        let action = SKAction.animate(with: greenReverseBoxtextures, timePerFrame: delayAnimation, resize: true, restore: false)
//        
//        self.beltNode.run(action)
//    }
//    
//    func runReverseBlueBoxAnimation(delayAnimation: Double){
//        self.beltNode.removeAllActions()
//        let action = SKAction.animate(with: blueReverseBoxtestures, timePerFrame: delayAnimation, resize: true, restore: false)
//        self.beltNode.run(action)
//    }
    
    //    private func stopAndRemoveBox(numQuestion: [Int]){
    //        self.stopOrRunTrain()
    //        self.delayRunTrainTextures(delay: 6.2)
    //        self.createTrainStation(positionX: 1960, delay: 1.5)
    //        self.runReverseAllBoxAnimate(runDelay: 6.0, delayIntervalAnimation: 2.0, boxNumber: self.arrayQuestion)
    //        runReverseAllBoxAnimate(runDelay: 6.0, delayIntervalAnimation: 2.0, boxArrayQuestion: arrayQuestion)
    //        self.runAllBoxAnimate(runDelay: 20.0, delayIntervalAnimation: 2.0)// 10.0   2.0
    //
    //        print("pause")
    //        self.runTrain(delay: 25.6)//15.6
    //    }
    
}
