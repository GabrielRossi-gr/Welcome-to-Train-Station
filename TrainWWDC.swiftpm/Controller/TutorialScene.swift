//
//  TutorialScene.swift
//  TrainWWDC
//
//  Created by Gabriel Rossi on 20/02/24.
//

import Foundation
import SpriteKit

class TutorialScene: SKScene {
    
    
    var tutorialNode = SKSpriteNode()
    var nextButton = SKSpriteNode()
    var anteriorButton = SKSpriteNode()
    var maquinista = SKSpriteNode()
    var playButton = SKSpriteNode()
    
    var tutorialImages = TutorialData.getImages()
    var tutorialNumberImage = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
//        let sceneFrame = scene?.frame
        
        self.setupTutorialNode(imageName: tutorialImages[tutorialNumberImage])
        self.addNextButton()
//        self.setupMaquinista()
        
    }
    
    
    private func nextTutorial(){
        if(tutorialNumberImage < tutorialImages.count - 1) {
            tutorialNumberImage += 1
            setupTutorialNode(imageName: tutorialImages[tutorialNumberImage])
            addAnteriorButton()
            
        }
        
        if( tutorialNumberImage == tutorialImages.count - 1){
            removeNextButton()
            self.addPlayButton()
        }
    }
    
    private func anteriorTutorial(){
        if(tutorialNumberImage > 0){
            tutorialNumberImage -= 1
            setupTutorialNode(imageName: tutorialImages[tutorialNumberImage])
            addNextButton()
        }
        
        if(tutorialNumberImage == 0){
            removeAnteriorButton()
        }
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
            print("tutorial scene error")
        }
    
        //default size 1024
        //default size 1366

        tutorialNode.zPosition = 10
        tutorialNode.position = CGPoint(x: 0, y: 0)
        addChild(tutorialNode)
    }
    
    private func addNextButton(){
        let sceneFrame = scene?.frame
        nextButton.removeFromParent()
        nextButton.texture = SKTexture(imageNamed: "right")
        
        switch AppConfig.UIDevice(){
        case .pad:
            nextButton.size = CGSize(width: 90, height: 90)
        case .phone:
            nextButton.size = CGSize(width: 50, height: 50)
        default:
            print("error")
        }
        
        nextButton.zPosition = 20
        nextButton.position = CGPoint(x:(sceneFrame?.maxX ?? 00) - 60, y: (sceneFrame?.minY ?? 0) + 70)
        addChild(nextButton)
    }
    
    private func addAnteriorButton(){
        let sceneFrame = scene?.frame
        anteriorButton.removeFromParent()
        anteriorButton.texture = SKTexture(imageNamed: "left")
        
        switch AppConfig.UIDevice(){
        case .pad:
            anteriorButton.size = CGSize(width: 90, height: 90)
        case .phone:
            anteriorButton.size = CGSize(width: 50, height: 50)
        default:
            print("error")
        }
        
        anteriorButton.zPosition = 20
        anteriorButton.position = CGPoint(x:(sceneFrame?.minX ?? 00) + 60, y: (sceneFrame?.minY ?? 0) + 70)
        addChild(anteriorButton)
    }
    
    private func removeNextButton(){
        nextButton.removeFromParent()
        nextButton.removeAllActions()

    }
    
    private func removeAnteriorButton(){
        anteriorButton.removeFromParent()
        anteriorButton.removeAllActions()
    }
    
    private func setupMaquinista(){
        let sceneFrame = scene?.frame
        let size = (sceneFrame?.width ?? 300) / 3
        
        maquinista.texture = SKTexture(imageNamed: "ZeMaquinista")
        maquinista.size = CGSize(width: size, height: size)
        maquinista.zPosition = 5
        maquinista.position = CGPoint(x:(sceneFrame?.maxX ?? 00) - 300, y: (sceneFrame?.minY ?? 0) + 300)
        addChild(maquinista)
    }
    
    private func addPlayButton(){
        self.playButton.removeFromParent()
        playButton.texture = SKTexture(imageNamed: "ButtonIMGStart")
        playButton.position = CGPoint(x: 0, y: (self.scene?.frame.minY)! + 70)
        
        switch AppConfig.UIDevice(){
        case .pad:
            playButton.size = CGSize(width: 320, height: 76)
        case .phone:
            playButton.size = CGSize(width: 190, height: 46)
        default:
            print("error")
        }
        
        playButton.zPosition = 30
        playButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playButton.name = "ButtonIMGStart"
        addChild(playButton)
    }
    
    private func changeScene() {
        if let view = self.view {
            if let scene = SKScene(fileNamed: "GameScene") {
//            if let scene = SKScene(fileNamed: "FirstScene") {
                
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

extension TutorialScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            if(nextButton.contains(touchLocation)){
                nextTutorial()
//                print("tutorialNumber: ", tutorialNumberImage)
            }
            
            if(anteriorButton.contains(touchLocation)){
                anteriorTutorial()
//                print("tutorialNumber: ", tutorialNumberImage)
            }
            
            if(playButton.contains(touchLocation)){
//                print("playButton")
                self.changeScene()
            }
            
            
//            print("-->>" , tutorialImages[tutorialNumberImage])
        }
    }
}
