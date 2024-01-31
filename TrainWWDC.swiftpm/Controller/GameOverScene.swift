//
//  GameOverScene.swift
//  TrainWWDC
//
//  Created by Gabriel Rossi on 31/01/24.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    private var gameOverLabel = SKLabelNode(fontNamed: "PressStart2P-Regular")
    private var scoreLabel = SKLabelNode(fontNamed: "PressStart2P-Regular")
    private var button = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        ConfigExtention.font.getFontSetup()
        fontSetup()
        buttonSetup()
    }
    
    private func buttonSetup(){
        button.removeFromParent()
        button.texture = SKTexture(imageNamed: "ButtonIMGStart")
        button.position = CGPoint(x: 0, y: (self.scene?.frame.minY)! + 70)
        button.size = CGSize(width: 263, height: 56)
        button.zPosition = 20
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(button)
    }
    
    private func fontSetup(){
        gameOverLabel.removeFromParent()
        gameOverLabel.fontColor = .white
        gameOverLabel.fontSize = 35
        gameOverLabel.zPosition = 12   //(self.scene?.frame.maxY ?? 230) - 100)
        gameOverLabel.position = CGPoint(x: 0, y: 120)
        gameOverLabel.text = "Game Over"
        gameOverLabel.horizontalAlignmentMode = .center
        addChild(gameOverLabel)
        
        
        scoreLabel.removeFromParent()
        scoreLabel.fontColor = .white
        scoreLabel.fontSize = 20
        scoreLabel.zPosition = 12   //(self.scene?.frame.maxY ?? 230) - 100)
        scoreLabel.position = CGPoint(x: 0, y: 70)
        scoreLabel.text = "score: \(Train.singleton.getScore())"
        scoreLabel.horizontalAlignmentMode = .center
        addChild(scoreLabel)
    }
    
    
    func changeScene() {
        if let view = self.view {
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
extension GameOverScene {
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

