//
//  GameScene.swift
//  Police Race
//
//  Created by Евгений Митюля on 1.07.24.
//

import SpriteKit
import GameplayKit

final class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: Nodes
    private var backgroundNode1: SKSpriteNode!
    private var backgroundNode2: SKSpriteNode!
    private var buttonLeft: SKSpriteNode!
    private var buttonRight: SKSpriteNode!
    private var carPlayer: SKSpriteNode!
    private var enemyCars: [SKSpriteNode] = []
    
    // MARK: States
    private var backgroundHeight: CGFloat = 0
    private let timeInterval: TimeInterval = 0.01
    private let carMoveDuration: TimeInterval = 0.3
    private let carMovementDistance: CGFloat = 100
    private let enemyCarSpeed: CGFloat = 200
    private var gameTimeRemaining: TimeInterval = 180
    private var playerPosition: PlayerPosition = .center
    private var isPlayerMoving = false
    private var wasGameEnded = false
    private var gameScore = 0
    
    // MARK: Timers
    private var timer: Timer?
    private var enemySpawnTimer: Timer?
    private var gameTimer: Timer?
    
    var parentVC: GameViewController?
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        initNodes()
        startBackgroundAnimation()
        startEnemyCarSpawning()
        startGameTimer()
    }
    
    func initNodes() {
        addBackground1()
        addBackground2()
        addButtonToLeft()
        addButtonToRight()
        addPlayerCar()
    }
    
    func startBackgroundAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
            self?.updateBackground()
        }
    }
    
    func startEnemyCarSpawning() {
        enemySpawnTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [weak self] _ in
            self?.addEnemyCar()
        }
    }
    
    func startGameTimer() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateGameTimer()
        }
    }
    
    func endThisGame() {
        wasGameEnded = true
        scene?.isPaused = true
        
        timer?.invalidate()
        enemySpawnTimer?.invalidate()
        gameTimer?.invalidate()
        
        parentVC?.gameOverShow(withScore: gameScore)
    }
}

// MARK: Tap Methods

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isPlayerMoving { return }
        for touch in touches {
            let location = touch.location(in: self)
            if buttonLeft.contains(location) {
                switch playerPosition {
                case .left:
                    playerPosition = .left
                    isPlayerMoving = false
                case .center:
                    playerPosition = .left
                    isPlayerMoving = true
                    movePlayerCar(to: CGPoint(x: carPlayer.position.x - carMovementDistance, y: carPlayer.position.y))
                case .right:
                    playerPosition = .center
                    isPlayerMoving = true
                    movePlayerCar(to: CGPoint(x: carPlayer.position.x - carMovementDistance, y: carPlayer.position.y))
                }
            } else if buttonRight.contains(location) {
                switch playerPosition {
                case .left:
                    playerPosition = .center
                    isPlayerMoving = true
                    movePlayerCar(to: CGPoint(x: carPlayer.position.x + carMovementDistance, y: carPlayer.position.y))
                case .center:
                    playerPosition = .right
                    isPlayerMoving = true
                    movePlayerCar(to: CGPoint(x: carPlayer.position.x + carMovementDistance, y: carPlayer.position.y))
                case .right:
                    playerPosition = .right
                    isPlayerMoving = false
                }
            }
        }
    }
}

// MARK: Update Methods

extension GameScene {
    func updateGameTimer() {
        gameTimeRemaining -= 1
        if gameTimeRemaining <= 0 {
            endThisGame()
        }
    }
    
    func updateBackground() {
        backgroundNode1.position.y -= 5
        backgroundNode2.position.y -= 5
        
        if backgroundNode1.position.y <= -backgroundHeight / 2 {
            backgroundNode1.position.y = backgroundNode2.position.y + backgroundHeight
        }
        
        if backgroundNode2.position.y <= -backgroundHeight / 2 {
            backgroundNode2.position.y = backgroundNode1.position.y + backgroundHeight
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateEnemyCars(currentTime)
    }
    
    private func updateEnemyCars(_ currentTime: TimeInterval) {
        for (index, enemyCar) in enemyCars.enumerated().reversed() {
            if enemyCar.position.y < -50 {
                enemyCars.remove(at: index)
                enemyCar.removeFromParent()
                gameScore += 1
            }
        }
    }
}

// MARK: Nodes Configuration Methods

extension GameScene {
    func configPhysicsForPlayer() {
        carPlayer.physicsBody = SKPhysicsBody(texture: carPlayer.texture ?? SKTexture(), size: carPlayer.size)
        carPlayer.physicsBody?.isDynamic = false
        carPlayer.physicsBody?.affectedByGravity = false
        carPlayer.physicsBody?.categoryBitMask = BitMasks.player
        carPlayer.physicsBody?.collisionBitMask = BitMasks.police
        carPlayer.physicsBody?.contactTestBitMask = BitMasks.police
    }
    
    func addButtonToLeft() {
        buttonLeft = SKSpriteNode(imageNamed: Image.Control.left.rawValue)
        buttonLeft.size = CGSize(width: 75, height: 100)
        buttonLeft.position = CGPoint(x: size.width / 4 + 10, y: 60)
        
        buttonLeft.zPosition = 2
        
        addChild(buttonLeft)
    }
    
    func addButtonToRight() {
        buttonRight = SKSpriteNode(imageNamed: Image.Control.right.rawValue)
        buttonRight.size = CGSize(width: 75, height: 100)
        buttonRight.position = CGPoint(x: size.width - size.width / 4 - 10, y: 60)
        
        buttonRight.zPosition = 2
        
        addChild(buttonRight)
    }
    
    func addBackground1() {
        let imageWidth: CGFloat = 1080
        let imageHeight: CGFloat = 2400
        let aspectRatio = imageWidth / imageHeight
        
        backgroundNode1 = SKSpriteNode(imageNamed: Image.Game.background.rawValue)
        let scaledHeight = UIScreen.main.bounds.width / aspectRatio
        backgroundNode1.size = CGSize(width: UIScreen.main.bounds.width, height: scaledHeight)
        backgroundNode1.position = CGPoint(x: size.width / 2, y: size.height / 2)
        backgroundNode1.zPosition = -3
        addChild(backgroundNode1)
        
        backgroundHeight = scaledHeight
    }
    
    func addBackground2() {
        let imageWidth: CGFloat = 1080
        let imageHeight: CGFloat = 2400
        let aspectRatio = imageWidth / imageHeight
        
        backgroundNode2 = SKSpriteNode(imageNamed: Image.Game.background.rawValue)
        let scaledHeight = UIScreen.main.bounds.width / aspectRatio
        backgroundNode2.size = CGSize(width: UIScreen.main.bounds.width, height: scaledHeight)
        backgroundNode2.position = CGPoint(x: size.width / 2, y: size.height / 2 + backgroundNode2.size.height)
        backgroundNode2.zPosition = -3
        addChild(backgroundNode2)
    }
    
    func addPlayerCar() {
        carPlayer = SKSpriteNode(imageNamed: Image.Car.player.rawValue)
        carPlayer.size = CGSize(width: 50, height: 110)
        carPlayer.position = CGPoint(x: size.width / 2, y: 150)
        
        addChild(carPlayer)
        
        configPhysicsForPlayer()
    }
    
    func addEnemyCar() {
        let enemyCar = SKSpriteNode(imageNamed: Image.Car.police.rawValue)
        enemyCar.size = CGSize(width: 85, height: 110)
        let carPos = PlayerPosition.allCases.randomElement()
        var posX = 0.0
        switch carPos {
        case .left:
            posX = size.width / 4
        case .center:
            posX = size.width / 2
        case .right:
            posX = size.width - size.width / 4
        default:
            posX = size.width / 4
        }
        enemyCar.position = CGPoint(x: posX, y: size.height + enemyCar.size.height / 2)
        addChild(enemyCar)
        
        enemyCar.physicsBody = SKPhysicsBody(texture: enemyCar.texture ?? SKTexture(), size: enemyCar.size)
        enemyCar.physicsBody?.isDynamic = true
        enemyCar.physicsBody?.affectedByGravity = false
        enemyCar.physicsBody?.categoryBitMask = BitMasks.police
        enemyCar.physicsBody?.collisionBitMask = BitMasks.player
        enemyCar.physicsBody?.contactTestBitMask = BitMasks.player
        
        enemyCars.append(enemyCar)
        moveEnemyCar(car: enemyCar, to: CGPoint(x: enemyCar.position.x, y: -100), duration: 5)
    }
}

// MARK: SKAction Methods

extension GameScene {
    private func movePlayerCar(to position: CGPoint) {
        let moveAction = SKAction.move(to: position, duration: carMoveDuration)
        carPlayer.run(moveAction)
        DispatchQueue.main.asyncAfter(deadline: .now() + carMoveDuration) {
            self.isPlayerMoving = false
        }
    }
    
    private func moveEnemyCar(car: SKNode, to position: CGPoint, duration: CGFloat) {
        let moveAction = SKAction.move(to: position, duration: duration)
        car.run(moveAction)
    }
}

// MARK:  Physics Contact Methods

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        if wasGameEnded { return }
        endThisGame()
    }
}
