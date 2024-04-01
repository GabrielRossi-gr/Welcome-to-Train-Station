import SwiftUI
import SpriteKit
import Foundation
import UIKit

struct ContentView: View {
    
    let scene = SKScene(fileNamed: "TutorialScene")
//    let scene = SKScene(fileNamed: "GameScene")
//    let scene = SKScene(fileNamed: "GameOverScene")
    
    var body: some View {
        
        VStack {
            if let scene = scene {
                SpriteView(scene: scene)

            } else {
                Text("load scene error")
            }
            
        }.ignoresSafeArea()
        .navigationBarBackButtonHidden(true)

    }
}

