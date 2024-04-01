//
//  GameScene.swift
//  Train
//
//  Created by Gabriel Rossi on 28/12/23.

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
    var questionPlate = SKSpriteNode()
    var score = SKLabelNode(fontNamed: "PressStart2P-Regular")
    var stopQuestionON = false
    var isTrueQuestion = true
    var arrayQuestion = [Int]()
    var pressButton = false
    
    
    let redBoxtextures = BoxTextures.getRedTextures()
    let blueBoxtestures = BoxTextures.getBlueTextures()
    let greenBoxtextures = BoxTextures.getGreenTextures()
    
    
    //minus plate
    var redBoxNode = SKSpriteNode()
    var greenBoxNode = SKSpriteNode()
    var blueBoxNode = SKSpriteNode()
    var redLabel = SKLabelNode(fontNamed: "PressStart2P-Regular")
    var greenLabel = SKLabelNode(fontNamed: "PressStart2P-Regular")
    var blueLabel = SKLabelNode(fontNamed: "PressStart2P-Regular")
    
    
    var redReverseBoxtextures = [SKTexture]()
    var blueReverseBoxtestures = [SKTexture]()
    var greenReverseBoxtextures = [SKTexture]()
    
    
    var backgoundController = BackgroundController()
    var train = Train()

    var enableSongs = true
    var enableLoopSongs = true
    var backgroundSong = PlaySong(songName: "TrainBackGroundMusic1.mp3")
    var apitoSong = PlaySong(songName: "TrainSongsApito.mp3")

    var cameraNode: SKCameraNode?
    
    
    override func didMove(to view: SKView) { // 800 800
        self.size = CGSize(width: 800, height: 800)

//        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        self.addChild(cameraNode!)

//        cameraNode?.yScale = 0.5
//        cameraNode?.xScale = 0.5
        
        backgroundColor = .black
        self.firstSetup()
    }
    ///------------------------------------------------------------------
    
    func getMaxXVisible() -> CGFloat? {
        guard let cameraNode = cameraNode else {
            return nil
        }
        let maxXVisible = self.size.width / 2 / cameraNode.xScale
        return maxXVisible
    }
    
    override func sceneDidLoad() {
        if let scaledSize = cameraScaledSize(self.size) {
            super.sceneDidLoad()
            self.size = scaledSize
        }
    }
    
    func cameraScaledSize(_ originalSize: CGSize) -> CGSize? {
        guard let xScale = cameraNode?.xScale, let yScale = cameraNode?.yScale else {
            return nil
        }

        let scaledWidth = originalSize.width / xScale
        let scaledHeight = originalSize.height / yScale

        return CGSize(width: scaledWidth, height: scaledHeight)
    }
    
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
        self.setupMinusPlateNodes()
       
        self.backgroundSong.playAudio(loop: true, enableSongs: enableLoopSongs)
        
        
        //test questionPlatePosition
//        self.addStopQuestionPlate(node: questionPlate, removeDelay: 20)
    }

    private func randomBoll() -> Bool{
        let distribuicao = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = distribuicao.nextInt()
        return randomNumber <= 5
    }
    
    private func randomBollPercentOfTrue(percentTrue: Int) -> Bool{
        let distribuicao = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = distribuicao.nextInt()
//        print("percent: ", percentTrue / 10)
//        print("random num: ", randomNumber)
        return randomNumber <= (percentTrue / 10)
    }
    
    private func nextStep(delay: Double){
        self.delay(seconds: delay, closure: {
            if(self.randomBollPercentOfTrue(percentTrue: 80) || Train.singleton.getScore() == 0){
            // question
                self.addStopQuestionPlate(node: self.questionPlate, removeDelay: 8.0)//2.0
            //stop
            } else {
                self.addStopTrainPlate(node: self.stopTrainStationIMG, removeDelay: 3.0)
                self.stopTrain()
            }
        })
    }
    
    public func setupMinusPlateNodes(){
        self.redBoxNode = self.addSpriteNode(texture: "RedBox", size: CGSize(width: 40, height: 40), zPosition: 10, ancorPoint: CGPoint(x: 0.5, y: 0.5))
        redBoxNode.position = CGPoint(x: -80, y: -180)
        
        self.greenBoxNode = self.addSpriteNode(texture: "GreenBox", size: CGSize(width: 40, height: 40), zPosition: 10, ancorPoint: CGPoint(x: 0.5, y: 0.5))
        
        self.blueBoxNode = self.addSpriteNode(texture: "BlueBox", size: CGSize(width: 40, height: 40), zPosition: 10, ancorPoint: CGPoint(x: 0.5, y: 0.5))
        
        redLabel.fontColor = .white
        redLabel.fontSize = 15
        redLabel.zPosition = 11
        redLabel.horizontalAlignmentMode = .center
        
        greenLabel.fontColor = .white
        greenLabel.fontSize = 15
        greenLabel.zPosition = 11
        greenLabel.horizontalAlignmentMode = .center

        blueLabel.fontColor = .white
        blueLabel.fontSize = 15
        blueLabel.zPosition = 11
        blueLabel.horizontalAlignmentMode = .center

        
        redBoxNode.position = CGPoint(x: -50, y: 25)
        greenBoxNode.position = CGPoint(x: 0, y: 25)
        blueBoxNode.position = CGPoint(x: 50, y: 25)
        redLabel.position = CGPoint(x: -56, y: 50)
        greenLabel.position = CGPoint(x: -6, y: 50)
        blueLabel.position = CGPoint(x: 44, y: 50)
    }
    
    private func removeMinusPlateNodes(){
        self.redBoxNode.removeFromParent()
        self.greenBoxNode.removeFromParent()
        self.blueBoxNode.removeFromParent()
        
        self.redLabel.removeFromParent()
        self.greenLabel.removeFromParent()
        self.blueLabel.removeFromParent()
    }
    
    private func addMinusPlateNodes(delay: Double){
        removeMinusPlateNodes()
        redLabel.text = "-\(arrayQuestion[0])"
        greenLabel.text = "-\(arrayQuestion[1])"
        blueLabel.text = "-\(arrayQuestion[2])"
        
        self.delay(seconds: delay, closure: {
            if(self.arrayQuestion[0] > 0){
                self.addChild(self.redLabel)
                self.addChild(self.redBoxNode)
            }
            
            if(self.arrayQuestion[1] > 0){
                self.addChild(self.greenLabel)
                self.addChild(self.greenBoxNode)
            }
            
            if(self.arrayQuestion[2] > 0){
                self.addChild(self.blueBoxNode)
                self.addChild(self.blueLabel)
            }
            
            self.delay(seconds: 2.5, closure: {
                self.removeMinusPlateNodes()
            })
        })
    }
    
    
    
    
    
    
    
    
    private func addStopQuestionPlate(node: SKSpriteNode, removeDelay: Double){
        self.stopQuestionON = true
        self.arrayQuestion = question()
        
        let questionNode = QuestionPlateNode(quantRed: arrayQuestion[0], quantGreen: arrayQuestion[1], quantBlue: arrayQuestion[2])
        
        let maxXVisible = getMaxXVisible() //(self.scene?.frame.maxX ?? 00)
        questionNode.anchorPoint = CGPoint(x: 0.0, y: 0.0)

        
        switch AppConfig.UIDevice() {
        case .pad:
            questionNode.position = CGPoint(x: (self.scene?.frame.maxX ?? 00) - 90, y: 260)
        case .phone:
            questionNode.position = CGPoint(x: (self.scene?.frame.maxX ?? 00) - 180, y: 260)
        default:
            print("erro")
        }

        
//        (self.scene?.frame.maxX ?? 00)
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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
                    Train.singleton.addScore(quant: 10)
                    self.updateScoreLabelNode()
                    self.removeTrainBoxQuestion()
                    self.addMinusPlateNodes(delay: 4.0)
                    
                } else {
                    self.gameOver(delay: 6.0)
                }
                
            //no press button
            } else {
                self.createTrainStation(positionX: 1960, delay: 0.1)
                self.nextStep(delay: 5)
                if(self.isTrueQuestion == false){
                    Train.singleton.addScore(quant: 1)
                    self.updateScoreLabelNode()
                }
            }
        })
    }
    
    private func gameOver(delay: Double) {
        self.beltNode.removeAllActions()
        self.beltNode.removeFromParent()
        self.stopOrRunTrain()
        self.delayRunTrainTextures(delay: 6.2)
        self.createTrainStation(positionX: 1960, delay: 1.5)
        self.addExclamationAlert(delay: 4)
        
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
    
    private func addExclamationAlert(delay: Double){
        
        self.delay(seconds: delay, closure: {
            let exclamationAlert = SKSpriteNode()
            self.addSpriteNode(node: exclamationAlert, texture: "exclamationAlert", position: CGPoint(x: 0, y: 0), size: CGSize(width: 124, height: 124), zPosition: 20, ancorPoint: CGPoint(x: 0.5, y: 0.5))
        })
    }
    
    public func playSong(songName: String, delay: Double){
        if(enableSongs){
            self.delay(seconds: delay, closure: {
                let song = SKAction.playSoundFileNamed(songName, waitForCompletion: false)

                self.run(song)
            })
        }
    }
    
    private func question() -> [Int] {
        addButtonNode()
        //true question
        playSong(songName: "alertSong", delay: 0)
        
        
        if(randomBollPercentOfTrue(percentTrue: 50) || Train.singleton.getScore() == 0){
            isTrueQuestion = true
            let question = self.trueQuestion()
            
            print("true question: ------------")
            return question
        //false question
        } else {
            isTrueQuestion = false
            let question = self.falseQuestion()
            
            print("false question: ||||||||||||")
            return question
        }
    }
    
    private func trueQuestion() -> [Int]{
        var questionArray = [0,0,0]
        let arrayBoxTrain = train.getTrainBox()
        var hiddenBox = false
        for x in 0..<3 {
            if(arrayBoxTrain[x] > 0){
                    switch self.sortRandomNumber(maxNum: 1) {
                    case 0:
                        questionArray[x]  = arrayBoxTrain[x] - 1
                    case 1:
                        questionArray[x] = arrayBoxTrain[x] / 2 + 1
                    default:
                        print("ERRO: trueQuestion()")
                    }
                
                if(!hiddenBox && self.sortRandomNumber(maxNum: 10) <= 3 && questionArray[x] > 5){
                    questionArray[x] = 0
                    hiddenBox = true
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
    
    private func addStopTrainPlate(node: SKSpriteNode, removeDelay: Double){
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
        if(node.position.x < (self.scene?.size.width ?? 00) - 2000.0 /**700celular**/) {
            node.removeFromParent()
//            print("remove")
        }
    }
    
    private func removeTrainBoxQuestion(){
        for x in 0...2 {
            switch x {
            case 0 :
                train.removeRedBox(quant: arrayQuestion[0])
            case 1:
                train.removeGreenBox(quant: arrayQuestion[1])
            case 2:
                train.removeBlueBox(quant: arrayQuestion[2])
            default:
                print("ERRO: removeTrainBoxQuestion()")
            }
        }
    }
    
    private func updateScoreLabelNode(){
        score.removeFromParent()
        score.fontColor = .black
        score.fontSize = 17
        score.zPosition = 12   //(self.scene?.frame.maxY ?? 230) - 100)
        
        switch AppConfig.UIDevice(){
        case .pad:
            score.position = CGPoint(x: (self.scene?.frame.minX ?? -170) + 140 , y: (self.scene?.frame.maxY ?? 430) - 100)
        case .phone:
            score.position = CGPoint(x: (self.scene?.frame.minX ?? -170) + 240 , y: (self.scene?.frame.maxY ?? 430) - 100)

        default:
            print("error")
        }
        
        
        
        score.text = "score: \(Train.singleton.getScore())"
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
 
    private func setUpButton(){
        redReverseBoxtextures = redBoxtextures.reversed()
        blueReverseBoxtestures = blueBoxtestures.reversed()
        greenReverseBoxtextures = greenBoxtextures.reversed()

        buttonNode.removeFromParent()
        buttonNode.texture = SKTexture(imageNamed: "ButtonIMGStop")
        buttonNode.position = CGPoint(x: 0, y: (self.scene?.frame.minY ?? 00) + 70)
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
                    self.playSong(songName: "TrainSongsApito", delay: 0)
                    
                }
                self.removeButton()
            }
    
            print("touch")
        }
    }
}


