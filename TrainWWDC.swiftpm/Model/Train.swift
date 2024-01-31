//
//  Train.swift
//  Train
//
//  Created by Gabriel Rossi on 15/01/24.
//

import Foundation


class Train {
    
    private var redBox: Int
    private var greenBox: Int
    private var blueBox: Int
    private var score: Int
    
    static public var singleton = Train()
    
    init(){
        self.redBox = 0
        self.blueBox = 0
        self.greenBox = 0
        self.score = 0
                
    }
    
    //MARK: RED, GREEN, BLUE
    public func getTrainBox() -> [Int]{
        let arrayBox = [self.redBox, self.greenBox, self.blueBox]
        return arrayBox
    }
    
    public func getRedBox() -> Int {
        return self.redBox
    }
    
    public func getBlueBox() -> Int {
        return self.blueBox
    }
    
    public func getGreenBox() -> Int {
        return self.greenBox
    }
    
    public func getScore() -> Int {
        return self.score
    }
    
    
    //add box
    public func addRedBox(){
        self.redBox += 1
    }
    
    public func addBlueBox(){
        blueBox += 1
    }
    
    public func addGreenBox(){
        self.greenBox += 1
    }
    
    
    
    //remove box
    public func removeRedBox(){
        self.redBox -= 1
    }
    public func removeRedBox(quant: Int){
        self.redBox -= quant
    }
    
    
    public func removeBlueBox(){
        self.blueBox -= 1
    }
    public func removeBlueBox(quant: Int){
        self.blueBox -= quant
    }
    
    public func removeGreenBox(){
        self.greenBox -= 1
    }
    public func removeGreenBox(quant: Int){
        self.greenBox -= quant
    }
  
    
    
    public func addScore(quant: Int){
        self.score += quant
    }
    
    public func removeScore(quant: Int){
        if(self.score - quant < 0){
            self.score = 0
        } else {
            self.score -= quant
        }
    }
    
    
}

