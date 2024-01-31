//
//  StopButton.swift
//  Train
//
//  Created by Gabriel Rossi on 29/12/23.
//

import Foundation
import SpriteKit

class StopButton: SKNode{
    
    var button = SKSpriteNode()
    var image = SKTexture()
    
    init(image: SKTexture = SKTexture()) {
        self.image = image
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func load(){
        button.texture = image
        button.position = CGPoint(x: 0, y: (self.scene?.frame.minY)! + 70)
        button.size = CGSize(width: 263, height: 56)
        button.zPosition = 8
        button.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        button.name = "stopButton"
        addChild(button)
    }
}
