//
//  BackgroundController.swift
//  Train
//
//  Created by Gabriel Rossi on 04/01/24.
//

import Foundation
import SpriteKit


class BackgroundController : SKNode{
    
   
}


//Mark: create backgrounds
extension GameScene {
    func createGrounds () {
        for i in 0...13 {
            let imageName = "SkyBackground\(i)"
            let skyBackground = addSpriteNode(texture: imageName, size: CGSize(width: 243, height: 567), zPosition: 2, ancorPoint: backGroundAncorPoint)
            skyBackground.position = CGPoint(x: skyBackground.size.width * CGFloat(i), y: 71.0)
            addChild(skyBackground)
            arrayBackgroundSky[i] = imageName
        }
        
        for i in 0...4 {
            
            let BackGroundPaisage = addSpriteNode(texture: "BackGroundPaisage", size: CGSize(width: 303, height: 224), zPosition: 3, ancorPoint: backGroundAncorPoint)
            BackGroundPaisage.position = CGPoint(x: BackGroundPaisage.size.width * CGFloat(i), y: -10)
            self.addChild (BackGroundPaisage)
            
            let BackgroundFloor = addSpriteNode(texture: "BackgroundFloor", size: CGSize(width: 303, height: 158), zPosition: 4, ancorPoint: backGroundAncorPoint)
            BackgroundFloor.position = CGPoint(x: BackgroundFloor.size.width * CGFloat(i), y: -201)
            self.addChild (BackgroundFloor)
        }
    }
}

//MARK: move grounds
extension GameScene {

    func stopGrounds() {
        self.timeCont = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timeCont += 1
            self.removeSpeed()

            if self.timeCont >= 6 {
                self.moveBackground = false
                timer.invalidate()
            }
        }
        RunLoop.main.add(timer, forMode: .common)
    }
    
    func runGrounds() {
        self.timeCont = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timeCont += 1
            self.addSpeed()

            if self.timeCont >= 12 {
                self.moveBackground = true
                timer.invalidate()
            }
        }
        RunLoop.main.add(timer, forMode: .common)
    }
    
    //button
    func stopOrRunTrain(){
        if(moveBackground){
            stopGrounds()
            openTrainDor(delay: 4.0)
        } else {
            runGrounds()
            closeTrainDor(delay: 0.0)
        }
    }
}

//MARK: setup trainStation textures
extension GameScene {
    func createTrainStation(positionX: Int, delay: Double){
        self.delay(seconds: delay, closure: { [self] in
            let x = positionX
            let y = 72
            
            let trainStationPosition = CGPoint(x: x, y: y)
            let beltPosition = CGPoint(x: x - 300, y: y - 140)
            let trainStationSize = CGSize(width: 911.25, height: 405)
            
            
            self.trainStationBackNode = self.addSpriteNode(texture: "TrainStationBackground", size: trainStationSize, zPosition: 5, ancorPoint: self.backGroundAncorPoint)
            self.trainStationBackNode.position = trainStationPosition
            self.trainStationBackNode.name = "trainStationBack"
            
            self.trainStationFrontNode = addSpriteNode(texture: "TrainStationFront", size: trainStationSize, zPosition: 9, ancorPoint: self.backGroundAncorPoint)
            self.trainStationFrontNode.position = trainStationPosition
            self.trainStationFrontNode.name = "trainStationfront"
            
            self.beltNode = addSpriteNode(texture: "RedBox0", size: CGSize(width: 318, height: 70), zPosition: 10, ancorPoint: CGPoint(x: 1, y: 0.5))
            self.beltNode.position = beltPosition
            
        
            addChild(beltNode)
            addChild(trainStationFrontNode)
            addChild(trainStationBackNode)
        })
    }
}

//MARK: add enumerate nodes with screen
extension GameScene {
    func addOneEnumerateNodes(nodeName: String, speed: Int){
        self.enumerateChildNodes(withName: nodeName, using: ({
            (node, error) in
            node.position.x -= CGFloat(speed)

            if node.position.x < -((self.scene?.size.width)!) {
                node.removeFromParent()
            }
        }))
    }
    
    func addEnumerateNodes(nodeName: String, speed: Int) {
        self.enumerateChildNodes(withName: nodeName, using: ({
            (node, error) in
            node.position.x -= CGFloat(speed)
            
            if node.position.x < -((self.scene?.size.width)!) {
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
    }

    func addEnumerateNodes(arrayNodeName: [String], speed: Int, baseNameNode: String, arraySize: Int) {
        for i in 0...arraySize{
            self.enumerateChildNodes(withName: "\(baseNameNode)\(i)", using: ({
                (node, error) in
                node.position.x -= CGFloat(speed)
                
                if node.position.x < -((self.scene?.size.width)!) {
                    node.position.x += (self.scene?.size.width)! * 3
                }
            }))
        }
    }

}





