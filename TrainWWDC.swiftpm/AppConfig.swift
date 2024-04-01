//
//  AppConfig.swift
//  Welcome to Train Station
//
//  Created by Gabriel Rossi on 31/03/24.
//

import Foundation
import UIKit
import SwiftUI
import SpriteKit

class AppConfig {
    
    static public func sceneDevice() -> SKScene{
        
        let uiDevice = UIKit.UIDevice.current.userInterfaceIdiom
        var scene: SKScene
        
        switch uiDevice {
        case .pad:
            scene = SKScene(fileNamed: "TutorialScene")!

        case .phone:
            scene = SKScene(fileNamed: "TutorialScene")!

        case .mac:
            scene = SKScene(fileNamed: "")!
            print("error: AppConfig/UIDevice function")
        
        default:
            scene = SKScene(fileNamed: "")!
            print("error: AppConfig/UIDevice function")
        }
        
        return scene
    }
    
    
    /// Return UIDevice:  .pad,  .phone,  .mac,  .tv
    static public func UIDevice() -> UIUserInterfaceIdiom{
        
        let uiDevice = UIKit.UIDevice.current.userInterfaceIdiom
        return uiDevice
    }
}
