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
    private var restartButton = SKSpriteNode()
    private var tutorial = SKSpriteNode()
    var tutorialNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        ConfigExtention.font.getFontSetup()
        fontSetup()
        buttonSetup()
        setupTutorialNode(imageName: "GameOverIMG")
    }
    
    private func buttonSetup(){
        
        
        self.restartButton.removeFromParent()
        restartButton.texture = SKTexture(imageNamed: "Restart")
        restartButton.position = CGPoint(x: 0, y: (self.scene?.frame.minY)! + 70)
        switch AppConfig.UIDevice(){
        case .pad:
            restartButton.size = CGSize(width: 320, height: 76)
        case .phone:
            restartButton.size = CGSize(width: 270, height: 56)
        default:
            print("error")
        }
        restartButton.zPosition = 30
        restartButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        restartButton.name = "ButtonIMGStart"
        addChild(restartButton)
        
        
        tutorial.removeFromParent()
        tutorial.texture = SKTexture(imageNamed: "Tutorial")
        tutorial.position = CGPoint(x: 0, y: (self.scene?.frame.minY)! + 150)
        switch AppConfig.UIDevice(){
        case .pad:
            tutorial.size = CGSize(width: 320, height: 76)
        case .phone:
            tutorial.size = CGSize(width: 270, height: 56)
        default:
            print("error")
        }
        tutorial.zPosition = 20
        tutorial.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(tutorial)
    }
    
    private func fontSetup(){
        gameOverLabel.removeFromParent()
        gameOverLabel.fontColor = .white
        gameOverLabel.zPosition = 500   //(self.scene?.frame.maxY ?? 230) - 100)
        gameOverLabel.text = "Game Over"
        gameOverLabel.horizontalAlignmentMode = .center
        switch AppConfig.UIDevice(){
        case .pad:
            gameOverLabel.fontSize = 35
            gameOverLabel.position = CGPoint(x: 0, y: 120)
        case .phone:
            gameOverLabel.fontSize = 35
            gameOverLabel.position = CGPoint(x: 0, y: 30)
        default:
            print("error")
        }
//        addChild(gameOverLabel)
        
        
        scoreLabel.removeFromParent()
        scoreLabel.fontColor = .white
        scoreLabel.zPosition = 12   //(self.scene?.frame.maxY ?? 230) - 100)
        scoreLabel.text = "score: \(Train.singleton.getScore())"
        scoreLabel.horizontalAlignmentMode = .center
        switch AppConfig.UIDevice(){
        case .pad:
            scoreLabel.fontSize = 35
            scoreLabel.position = CGPoint(x: 0, y: CGFloat(scene?.frame.minY ?? 00) + 250)
        case .phone:
            scoreLabel.fontSize = 25
            scoreLabel.position = CGPoint(x: 0, y: CGFloat(scene?.frame.maxY ?? 00) - 100)
        default:
            print("error")
        }
        addChild(scoreLabel)
    }
    
    private func setupTutorialNode(imageName: String){
        let sceneFrame = scene?.frame
        let heightScene = CGFloat(sceneFrame?.height ?? 00)
        tutorialNode.removeFromParent()
        tutorialNode.texture = SKTexture(imageNamed: imageName)
        
        switch AppConfig.UIDevice(){
        case .pad:
            tutorialNode.size = CGSize(
                width: (1024 * (sceneFrame?.height ?? 1000)) / (heightScene * 0.9)  /*512*/ ,
                height: (1366 * (sceneFrame?.height ?? 1000)) / (heightScene * 0.9)/*683*/)
        case .phone:
            tutorialNode.size = CGSize(
                width: (554 * (sceneFrame?.height ?? 1000)) / (heightScene * 0.9)  /*512*/ ,
                height: (766 * (sceneFrame?.height ?? 1000)) / (heightScene * 0.9)/*683*/)
        default:
            print("error")
        }
        
        
        //1024
        //1366
        
        tutorialNode.zPosition = 10
        tutorialNode.position = CGPoint(x: 0, y: 0)
        addChild(tutorialNode)
    }
    
    func changeScene(sceneName: String) {
        if let view = self.view {
            if let scene = SKScene(fileNamed: sceneName) {
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
    
    func resetScore(){
        Train.singleton.resetScore()
    }

    
}



//MARK: touchesBegan
extension GameOverScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            if( tutorial.contains(touchLocation)){
                self.resetScore()
                changeScene(sceneName: "TutorialScene")
            }
            
            if restartButton.contains(touchLocation) {
                self.resetScore()
                changeScene(sceneName: "GameScene")
            }
            
            
            
            print("touch")
        }
    }
}

