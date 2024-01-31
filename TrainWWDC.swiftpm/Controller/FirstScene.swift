//
//  FirstScene.swift
//  TrainWWDC
//
//  Created by Gabriel Rossi on 16/01/24.
//

import Foundation
import SpriteKit

class FirstScene: SKScene{
    
    var button = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        button.texture = SKTexture(imageNamed: "ButtonIMGStart")
        button.position = CGPoint(x: 0, y: (self.scene?.frame.minY)! + 70)
        button.size = CGSize(width: 263, height: 56)
        button.zPosition = 8
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.name = "ButtonIMGStart"
        addChild(button)


    }
    
    
    func changeScene() {
        if let view = self.view {
//            if let scene = SKScene(fileNamed: "GameScene") {
            if let scene = SKScene(fileNamed: "GameScene") {
                
                
                scene.scaleMode = .aspectFill
                scene.size.width = view.frame.width
                scene.size.height = view.frame.height
                
                view.presentScene(scene, transition: SKTransition.fade(withDuration: 1.0))
            }
            
            
            //MARK: fps & node caunt
            view.showsNodeCount = true
            view.showsFPS = true
            
            
        }
            
    }

}


//MARK: touchesBegan
extension FirstScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            
            if button.contains(touchLocation) {
                print("play")
                changeScene()
            }
            
            
            print("touch")
        }
    }
    
    
}

