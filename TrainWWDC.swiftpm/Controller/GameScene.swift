//
//  GameScene.swift
//  Train
//
//  Created by Gabriel Rossi on 28/12/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var backGroundAncorPoint = CGPoint(x: 1, y: 0.5)
    var moveBackground = false
    var moveTrain = false
    
    var speedBackgroundPaisage = 0           //6
    var speedBackgroundSky = 1              //2
    var speedBackgroundFlor = 0             //12
    var timeCont = 0
    
    var arrayBackgroundSky: [String] = Array(repeating: "", count: 14)
    var arrayBackgroundTrainsStationFront: [String] = Array(repeating: "", count: 11)
    var arrayTrainStation: [String] = Array(repeating: "", count: 3)
    
    var buttonNode = SKSpriteNode()
    var trainNode = SKSpriteNode()
    var beltNode = SKSpriteNode()
    var trainStationBackNode = SKSpriteNode()
    var trainStationFrontNode = SKSpriteNode()
    var stopTrainStationIMG = SKSpriteNode()
    var questionPlace = SKSpriteNode()
    var score = SKLabelNode(fontNamed: "PressStart2P-Regular")
    var stopQuestionON = false
    var isTrueQuestion = true
    var arrayQuestion = [Int]()
    var pressButton = false
    
    let redBoxtextures = BoxTextures.getRedTextures()
    let blueBoxtestures = BoxTextures.getBlueTextures()
    let greenBoxtextures = BoxTextures.getGreenTextures()
    
    var redReverseBoxtextures = [SKTexture]()
    var blueReverseBoxtestures = [SKTexture]()
    var greenReverseBoxtextures = [SKTexture]()
    
    
    var backgoundController = BackgroundController()
    var train = Train()
    
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        self.firstSetup()
    }
    ///------------------------------------------------------------------------------
    
    func firstSetup(){
        ConfigExtention.font.getFontSetup()
        self.updateScoreLabelNode()
        self.setupRunTrainAnimation(delayAnimation: 0.05)
        self.createGrounds()
        self.createTrainStation(positionX: 470, delay: 0)
        self.openTrainDor(delay: 0.0)
        self.moveBackground = false
        self.runAllBoxAnimate(runDelay: 0.10, delayIntervalAnimation: 2.0)
        self.runTrain(delay: 5.5)
        self.setUpButton()
    }
    
    private func randomBoll() -> Bool{
        let distribuicao = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = distribuicao.nextInt()
    
        return randomNumber <= 5
    }
    
    private func randomBollPercentOfTrue(percentTrue: Int) -> Bool{
        let distribuicao = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = distribuicao.nextInt()
        print("percent: ", percentTrue / 10)
        print("random num: ", randomNumber)

        return randomNumber <= (percentTrue / 10)
    }

    
    private func nextStep(delay: Double){
        self.delay(seconds: delay, closure: {
            if(self.randomBollPercentOfTrue(percentTrue: 80)){
            // question
                self.addStopQuestionPlace(node: self.questionPlace, removeDelay: 8.0)//2.0
            //stop
            } else {
                self.addStopTrainPlace(node: self.stopTrainStationIMG, removeDelay: 3.0)
                self.stopTrain()
            }
        })
    }
    
    private func addStopQuestionPlace(node: SKSpriteNode, removeDelay: Double){
        self.stopQuestionON = true
        self.arrayQuestion = question()
        
        let questionNode = QuestionPlaceNode(quantRed: arrayQuestion[0], quantGreen: arrayQuestion[1], quantBlue: arrayQuestion[2])
        
        questionNode.position = CGPoint(x: self.scene?.frame.maxX ?? 0.0, y: 260)
        addChild(questionNode)
        
        self.delay(seconds: removeDelay, closure: {
            self.stopQuestionON = false
            questionNode.removeFromParent()
            self.removeButton()
            
            //press button
            if(self.pressButton){
                self.pressButton = false
                
                if(self.isTrueQuestion){
                    self.stopTrain()
                    self.train.addScore(quant: 10)
                    self.updateScoreLabelNode()
                } else {
                    self.gameOver(delay: 5.0)
                }
                
                
            //no press button
            } else {
                self.createTrainStation(positionX: 1960, delay: 0.1)
                self.nextStep(delay: 5)
                if(self.isTrueQuestion == false){
                    self.train.addScore(quant: 1)
                    self.updateScoreLabelNode()
                }
            }
        })
    }
    
    private func gameOver(delay: Double) {
        self.beltNode.removeAllActions()
        self.beltNode.removeFromParent()
        self.stopOrRunTrain()
//        self.delayRunTrainTextures(delay: 6.2)
        self.createTrainStation(positionX: 1960, delay: 1.5)
        
        self.delay(seconds: delay, closure: {
                if let view = self.view {
                    if let scene = SKScene(fileNamed: "GameOverScene") {
                        scene.scaleMode = .aspectFill
                        scene.size.width = view.frame.width
                        scene.size.height = view.frame.height
                        view.presentScene(scene, transition: SKTransition.fade(withDuration: 1.0))
                    }
                }
            
        })
    }
    
    private func question() -> [Int] {
        addButtonNode()
        //true question
        if(randomBoll()){
            isTrueQuestion = true
            print("true question: ------------")
            let question = self.trueQuestion()
            return question
            
        //false question
        } else {
            isTrueQuestion = false
            print("false question: ||||||||||||")
            let question = self.falseQuestion()
            return question
        }
    }
    
    
    private func trueQuestion() -> [Int]{
        var questionArray = [0,0,0]
        let arrayBoxTrain = train.getTrainBox()
        
        for x in 0..<3{
            if(arrayBoxTrain[x] > 0){
                if(randomBoll()){
                    questionArray[x]  = arrayBoxTrain[x] - 1
                } else {
                    questionArray[x] = arrayBoxTrain[x] / 2 + 1
                }
            }
        }
        return questionArray
    }
    
    private func falseQuestion() -> [Int] {
        var questionArrey = [0,0,0]
        let arrayBox = train.getTrainBox()
        for x in 0..<3 {
            if(randomBoll()){
                questionArrey[x] = arrayBox[x] + 1
            } else {
                questionArrey[x] = arrayBox[x] + 2
            }
        }
        return questionArrey
    }
    
    private func addStopTrainPlace(node: SKSpriteNode, removeDelay: Double){
        node.removeFromParent()
        node.size = CGSize(width: 349, height: 262)
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.texture = SKTexture(imageNamed: "stopTrainStationIMG")
        node.position = CGPoint(x: 0, y: 160)
        node.zPosition = 10
        self.addChild(node)
        
        self.delay(seconds: removeDelay, closure: {
            node.removeFromParent()
        })
    }

    override func update(_ currentTime: TimeInterval) {
        //MARK: Move all backgrounds
        moveGrounds()
        
        //MARK: Remove grounds
        removeGround(node: trainStationBackNode)
        removeGround(node: trainStationFrontNode)
        removeGround(node: beltNode)
    }
    
    private func removeGround(node: SKSpriteNode) {
        if(node.position.x < (self.scene?.size.width ?? 00) - 700.0) {
            node.removeFromParent()
//            print("remove")
        }
    }
    
    func moveGrounds () {
        addEnumerateNodes(nodeName: "BackGroundPaisage", speed: speedBackgroundPaisage)
        addEnumerateNodes(nodeName: "BackgroundFloor", speed: speedBackgroundFlor)
        addEnumerateNodes(arrayNodeName: arrayBackgroundSky, speed: speedBackgroundSky, baseNameNode: "SkyBackground", arraySize: arrayBackgroundSky.count)
        
        addOneEnumerateNodes(nodeName: "trainStationfront", speed: speedBackgroundFlor)
        addOneEnumerateNodes(nodeName: "trainStationBack", speed: speedBackgroundFlor)
        addOneEnumerateNodes(nodeName: "RedBox0", speed: speedBackgroundFlor)
    }
    
    private func updateScoreLabelNode(){
        score.removeFromParent()
        score.fontColor = .black
        score.fontSize = 17
        score.zPosition = 12   //(self.scene?.frame.maxY ?? 230) - 100)
        score.position = CGPoint(x: -170, y: (self.scene?.frame.maxY ?? 430) - 100)
        score.text = "score: \(train.getScore())"
        score.horizontalAlignmentMode = .left
        addChild(score)
    }
    
    private func runTrain(delay: Double){
        self.delay(seconds: delay, closure: {
            self.stopOrRunTrain()
            self.delayRunTrainTextures(delay: 6.2)
            print("play")
            print(self.train.getTrainBox())
            self.nextStep(delay: 15.0)
        })
    }
    
    private func stopTrain(){
        self.stopOrRunTrain()
        self.delayRunTrainTextures(delay: 6.2)
        self.createTrainStation(positionX: 1960, delay: 1.5)
        self.runAllBoxAnimate(runDelay: 5.0, delayIntervalAnimation: 2.0)
        print("pause")
        self.runTrain(delay: 11)
    }
    
//    private func stopAndRemoveBox(numQuestion: [Int]){
//        self.stopOrRunTrain()
//        self.delayRunTrainTextures(delay: 6.2)
//        self.createTrainStation(positionX: 1960, delay: 1.5)
//        self.runReverseAllBoxAnimate(runDelay: 6.0, delayIntervalAnimation: 2.0, boxNumber: self.arrayQuestion)
//        runReverseAllBoxAnimate(runDelay: 6.0, delayIntervalAnimation: 2.0, boxArrayQuestion: arrayQuestion)
//        self.runAllBoxAnimate(runDelay: 20.0, delayIntervalAnimation: 2.0)// 10.0   2.0
//
//        print("pause")
//        self.runTrain(delay: 25.6)//15.6
//    }
 
    private func setUpButton(){
        redReverseBoxtextures = redBoxtextures.reversed()
        blueReverseBoxtestures = blueBoxtestures.reversed()
        greenReverseBoxtextures = greenBoxtextures.reversed()

        buttonNode.removeFromParent()
        buttonNode.texture = SKTexture(imageNamed: "ButtonIMGStop")
        buttonNode.position = CGPoint(x: 0, y: (self.scene?.frame.minY)! + 70)
        buttonNode.size = CGSize(width: 263, height: 56)
        buttonNode.zPosition = 10
        buttonNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    private func removeButton(){
        buttonNode.removeFromParent()
    }
    
    private func addButtonNode(){
        buttonNode.removeFromParent()
        addChild(self.buttonNode)
    }
}





//MARK: touchesBegan
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            if buttonNode.contains(touchLocation) {
                
                if(stopQuestionON){
                    print("touch button")
                    pressButton = true
                    
                    stopQuestionON = false
                    removeButton()
                }
                
                

                self.removeButton()
            }
    
            print("touch")
        }
    }
}


