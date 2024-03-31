//
//  QuestionPlaceNode.swift
//  TrainWWDC
//
//  Created by Gabriel Rossi on 26/01/24.
//

import Foundation
import SpriteKit

class QuestionPlateNode: SKSpriteNode{
    
    private var place = SKSpriteNode()
    private var redBoxNode = SKSpriteNode()
    private var greenBoxNode = SKSpriteNode()
    private var blueBoxNode = SKSpriteNode()
    
    
    private var p1 = SKSpriteNode()
    private var p2 = SKSpriteNode()
    private var p3 = SKSpriteNode()

    private var quantRed = Int()
    private var quantGreen = Int()
    private var quantBlue = Int()
    
    var redBoxLabel = SKLabelNode(fontNamed: "PressStart2P-Regular")
    var blueBoxLabel = SKLabelNode(fontNamed: "PressStart2P-Regular")
    var greenBoxLabel = SKLabelNode(fontNamed: "PressStart2P-Regular")
    
    
    init(quantRed: Int, quantGreen: Int, quantBlue: Int){
        super.init(texture: nil, color: .clear, size: CGSize.zero)
        
        self.quantRed = quantRed
        self.quantGreen = quantGreen
        self.quantBlue = quantBlue
        
        self.load()
    }
    
    init(){
        super.init(texture: nil, color: .clear, size: CGSize.zero)
        self.load()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func load(){
        place.size = CGSize(width: 349, height: 262)
        place.anchorPoint = CGPoint(x: 1, y: 1)
        place.texture = SKTexture(imageNamed: "questionPlaceIMG")
        place.position = CGPoint(x: 0, y: 0)
        place.zPosition = 10
        addChild(place)
        
        redBoxNode.size = CGSize(width: 40, height: 40)
        redBoxNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        redBoxNode.texture = SKTexture(imageNamed: "RedBox")
        redBoxNode.position = CGPoint(x: -260, y: -200)
        redBoxNode.zPosition = 11
        
        greenBoxNode.size = CGSize(width: 40, height: 40)
        greenBoxNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        greenBoxNode.texture = SKTexture(imageNamed: "GreenBox")
        greenBoxNode.position = CGPoint(x: -195, y: -200)
        greenBoxNode.zPosition = 11
        
        blueBoxNode.size = CGSize(width: 40, height: 40)
        blueBoxNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        blueBoxNode.texture = SKTexture(imageNamed: "BlueBox")
        blueBoxNode.position = CGPoint(x: -130, y: -200)
        blueBoxNode.zPosition = 11
        
        
        ConfigExtention.font.getFontSetup()
        
        redBoxLabel.fontColor = .white
        redBoxLabel.text = "\(self.quantRed)"
        redBoxLabel.fontSize = 15
        redBoxLabel.zPosition = 12
        redBoxLabel.position = CGPoint(x: -260, y: -175)

        greenBoxLabel.fontColor = .white
        greenBoxLabel.text = "\(self.quantGreen)"
        greenBoxLabel.fontSize = 15
        greenBoxLabel.zPosition = 12
        greenBoxLabel.position = CGPoint(x: -195, y: -175)
        
        blueBoxLabel.fontColor = .white
        blueBoxLabel.text = "\(self.quantBlue)"
        blueBoxLabel.fontSize = 15
        blueBoxLabel.zPosition = 12
        blueBoxLabel.position = CGPoint(x: -130, y: -175)
        
        if(self.quantRed > 0){
            addChild(redBoxLabel)
            addChild(redBoxNode)
        }
        
        if(self.quantGreen > 0){
            addChild(greenBoxLabel)
            addChild(greenBoxNode)
        }
        
        if(self.quantBlue > 0){
            addChild(blueBoxNode)
            addChild(blueBoxLabel)
        }
        
    }
    
    public func removeNodes(){
        self.place.removeFromParent()
        self.redBoxNode.removeFromParent()
        self.blueBoxNode.removeFromParent()
        self.greenBoxNode.removeFromParent()
        self.redBoxLabel.removeFromParent()
        self.greenBoxLabel.removeFromParent()
        self.blueBoxLabel.removeFromParent()
    }
    
}

