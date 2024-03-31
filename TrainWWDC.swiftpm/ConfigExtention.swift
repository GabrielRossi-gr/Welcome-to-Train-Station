//
//  ConfigExtention.swift
//  Train
//
//  Created by Gabriel Rossi on 29/12/23.
//

import Foundation
import SpriteKit
import GameplayKit


//MARK: AddNode func
extension SKScene{
    
    
    public func addSpriteNode(node: SKSpriteNode, texture: String, position: CGPoint, size: CGSize, zPosition: Double, ancorPoint: CGPoint){
        
        node.texture = SKTexture(imageNamed: texture)
        node.position = position
        node.size = size
        node.zPosition = zPosition
        node.anchorPoint = ancorPoint
        node.name = texture
       addChild(node)
    }
    
    public func addSpriteNode(texture: String, size: CGSize, zPosition: Double, ancorPoint: CGPoint) -> SKSpriteNode {
        
        let node = SKSpriteNode()
        node.texture = SKTexture(imageNamed: texture)
        node.position = position
        node.size = size
        node.zPosition = zPosition
        node.anchorPoint = ancorPoint
        node.name = texture
        
        return node
    }
    
    public func delay(seconds: Double, closure: @escaping () -> Void){
        _ = Timer.scheduledTimer(withTimeInterval: seconds, repeats: true) { timer in
            closure()
            timer.invalidate()
        }
    }
    
    public func animationDelay(seconds: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            closure()
        }
    }


}





class ConfigExtention {
    
//    ConfigExtention.font.getFontSetup()
    static var font = ConfigExtention()
    private let fontURL = Bundle.module.url(forResource: "PressStart2P-Regular", withExtension: "ttf")!
    func getFontSetup(){
        CTFontManagerRegisterFontsForURL(fontURL as CFURL, CTFontManagerScope.process, nil)    }
    
    
    
    
    
}
