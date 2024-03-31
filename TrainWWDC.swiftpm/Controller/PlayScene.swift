//
//  PlayScene.swift
//  TrainWWDC
//  Created by Gabriel Rossi on 16/01/24.
//

import Foundation
import SpriteKit

class PlayScene: SKScene{
    
    var button = SKSpriteNode()
    var text = SKLabelNode(fontNamed: "PressStart2P-Regular")
    var zeMaquinista = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        ConfigExtention.font.getFontSetup()

//        self.backgroundColor = .systemBlue
//        self.backgroundColor = .systemBrown
//        self.backgroundColor = .systemIndigo
        self.backgroundColor = .black

        
        
        button.texture = SKTexture(imageNamed: "ButtonIMGStart")
        button.position = CGPoint(x: 0, y: (self.scene?.frame.minY)! + 70)
        button.size = CGSize(width: 263, height: 56)
        button.zPosition = 8
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.name = "ButtonIMGStart"
        addChild(button)

//        self.setUpZeMaquinista()
//        self.setupText()
    }
    
    private func setUpZeMaquinista(){
        zeMaquinista.texture = SKTexture(imageNamed: "ZeMaquinista")
        zeMaquinista.position = CGPoint(x: 50, y: -220)
        zeMaquinista.size = CGSize(width: 282, height: 282)
        zeMaquinista.zPosition = 8
        zeMaquinista.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(zeMaquinista)
    }
    
    private func setupText(){
        text.removeFromParent()
        text.fontColor = .white
        text.fontSize = 20
        text.zPosition = 12
        text.text = "Era uma vez quatrorapazes ingleses, de Liverpool, que conquistaram o mundo: John, Paul, George e Ringo. Durante a década de 1960, eles avassalaram os corações de todo o planeta com suas músicas e seu estilo. The Beatles – A biografia, de Bob Spitz, é o mais completo relato sobre a maior banda de todos os tempos"
        text.preferredMaxLayoutWidth = 10.0
        text.position = CGPoint(x: CGFloat(self.scene?.frame.minX ?? 0) + 10, y: 70)
        text.horizontalAlignmentMode = .left
        addChild(text)
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
extension PlayScene {
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

