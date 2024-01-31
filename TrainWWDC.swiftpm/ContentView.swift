import SwiftUI
import SpriteKit
import Foundation


struct ContentView: View {
    
//    let scene = SKScene(fileNamed: "GameScene")
        let scene = SKScene(fileNamed: "FirstScene")

    var body: some View {

        VStack {
            if let scene = scene {
                SpriteView(scene: scene)
            }

        }.ignoresSafeArea()
        .navigationBarBackButtonHidden(true)

    }
}

