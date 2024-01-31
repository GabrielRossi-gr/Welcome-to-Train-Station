//
//  BoxConfig.swift
//  TrainWWDC
//
//  Created by Gabriel Rossi on 18/01/24.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene{
    
    func sortRandomNumber() -> Int{
        
        let distribuicao = GKRandomDistribution(lowestValue: 0, highestValue: 2)
        let randomNumber = distribuicao.nextInt()
        
        //        print(randomInt)                                                     <-----   print
        return randomNumber
    }
    
    func runBoxAnimate(boxNumber: Int){
        switch boxNumber {
        case 0:
            print("red")
            runRedBoxAnimation(delayAnimation: 0.04)
            train.addRedBox()
            
        case 1:
            print("green")
            runGreenBoxAnimation(delayAnimation: 0.04)
            train.addGreenBox()
            
        case 2:
            print("blue")
            runBlueBoxAnimation(delayAnimation: 0.04)
            train.addBlueBox()
            
        default:
            print("erro  -_-")
        }
    }
  
    
    func runAllBoxAnimate(runDelay: Double, delayIntervalAnimation: Double){
        //run delay
        self.delay(seconds: runDelay, closure: {
            self.delay(seconds: delayIntervalAnimation, closure: {
                self.runBoxAnimate(boxNumber: self.sortRandomNumber())
            })
            
            self.delay(seconds: delayIntervalAnimation + 1, closure: {
                self.runBoxAnimate(boxNumber: self.sortRandomNumber())
            })
            
            self.delay(seconds: delayIntervalAnimation + 2, closure: {
                self.runBoxAnimate(boxNumber: self.sortRandomNumber())
            })
        })
    }
    
    
//    func runReverseAllBoxAnimate(runDelay: Double, delayIntervalAnimation: Double, boxNumber: [Int]){
//        //run delay
//        self.delay(seconds: runDelay, closure: {
//            
//            self.delay(seconds: delayIntervalAnimation, closure: {
//                self.runReverseBoxAnimate(boxNumber: boxNumber[0])
//            })
//            
//            self.delay(seconds: delayIntervalAnimation + 1, closure: {
//                self.runReverseBoxAnimate(boxNumber: boxNumber[1])
//            })
//            
//            self.delay(seconds: delayIntervalAnimation + 2, closure: {
//                self.runReverseBoxAnimate(boxNumber: boxNumber[2])
//            })
//            
//        })
//    }
    
//    func runReverseAllBoxAnimate(runDelay: Double, delayIntervalAnimation: Double, boxArrayQuestion: [Int]){
//        //run delay
//        self.delay(seconds: runDelay, closure: {
//            
//            for x in 0..<3{
//                for _ in 0..<boxArrayQuestion[x]{
////                    self.animationDelay(seconds: delayIntervalAnimation, closure: {
//                        self.runReverseBoxAnimate(boxNumber: x)
//                
////                    })
//                }
//            }
//        })
//    }
    
    //reversed
//    func runReverseBoxAnimate(boxNumber: Int){
//        switch boxNumber {
//        case 0:
//            print("remove: red")
//            runReverseRedBoxAnimation(delayAnimation: 0.04)
//            train.removeRedBox()
//
//        case 1:
//            print("remove: green")
//            runReverseGreenBoxAnimation(delayAnimation: 0.04)
//            train.removeGreenBox()
//
//        case 2:
//            print("remove: blue")
//            runReverseBlueBoxAnimation(delayAnimation: 0.04)
//            train.removeBlueBox()
//
//        default:
//            print("erro  -_-")
//        }
//    }
}
