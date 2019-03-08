//
//  GameScene.swift
//  BeersApp
//
//  Created by Marijan on 07/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import SpriteKit
import GameKit

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let player: UInt32 = 0b1 
    static let beer: UInt32 = 0b10
}

class BeerGameScene: SKScene {
    
    private let livesNo = 5
    private var startTime: TimeInterval = 0
    
    private var randomX: CGFloat {
        return CGFloat.random(in: 0 ..< self.size.width - 20)
    }
    
    private var beerFallInterval: TimeInterval = 6 {
        didSet {
            if beerFallInterval < 1 {
                beerFallInterval = 1
            }
        }
    }
    
    private var score: Int = 0 {
        didSet {
            scoreSprite.text = "Score: \(score)"
        }
    }
    
    private var beersFell = 0 {
        didSet {
            beersFellSprite.text = "Lives: \(livesNo - beersFell)"
            if beersFell >= 5 {
                gameOver()
            }
        }
    }
    
    private var player: SKSpriteNode!
    private var scoreSprite: SKLabelNode!
    private var beersFellSprite: SKLabelNode!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = SKColor.white
        initSprites()
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }
    
    override func update(_ currentTime: TimeInterval) {
        if startTime != 0 {
            let timeDifference = currentTime - startTime
            beerFallInterval = beerFallInterval - timeDifference * 0.00005
        } else {
            startTime = currentTime
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self).x
        
        let actionMove = SKAction.move(to: CGPoint(x: touchLocation, y: player.position.y), duration: 0.2)
        player.run(actionMove)
    }

    private func initSprites() {
        DispatchQueue.main.async {
            self.addPlayer()
            self.addScoreLabel()
            self.addBeersFellLabel()
            self.queueBeerFalling()
        }
    }
    
    private func addPlayer() {
        player = SKSpriteNode(imageNamed: "box")
        player.position = CGPoint(x: size.width / 2, y: player.size.height)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2 - 10)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.beer
        player.physicsBody?.collisionBitMask = PhysicsCategory.none
        addChild(player)
    }
    
    private func addScoreLabel() {
        scoreSprite = SKLabelNode(text: "Score: 0")
        scoreSprite.position = CGPoint(x: 70, y: size.height - 120)
        scoreSprite.fontColor = UIColor.black
        scoreSprite.fontSize = 25
        scoreSprite.zPosition = 1
        addChild(scoreSprite)
    }
    
    private func addBeersFellLabel() {
        beersFellSprite = SKLabelNode(text: "Lives: \(livesNo)")
        beersFellSprite.position = CGPoint(x: size.width - 70, y: size.height - 120)
        beersFellSprite.fontColor = UIColor.black
        beersFellSprite.fontSize = 25
        beersFellSprite.zPosition = 1
        addChild(beersFellSprite)
    }
    
    private func queueBeerFalling() {
     run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.wait(forDuration: 1.0),
                SKAction.run(addBeer)
            ])
        ))
    }
    
    private func addBeer() {
        let beerSprite = SKSpriteNode(imageNamed: "beer-sprite")
        beerSprite.position = CGPoint(x: randomX, y: size.height)
        beerSprite.zPosition = 1
        addChild(beerSprite)
        
        beerSprite.physicsBody = SKPhysicsBody(rectangleOf: beerSprite.size)
        beerSprite.physicsBody?.isDynamic = true
        beerSprite.physicsBody?.categoryBitMask = PhysicsCategory.beer
        beerSprite.physicsBody?.contactTestBitMask = PhysicsCategory.player
        beerSprite.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        let actionMove = SKAction.move(to: CGPoint(x: beerSprite.position.x, y: 0), duration: beerFallInterval)
        let actionMoveDone = SKAction.removeFromParent()
        
        beerSprite.run(SKAction.sequence([actionMove, actionMoveDone]), completion: {
            self.beersFell = self.beersFell + 1
        })
    }
    
    private func gameOver() {
        let transition = SKTransition.fade(withDuration: 1.0)
        let gameOverScene = GameStartOrOverScene()
        gameOverScene.size = view?.bounds.size ?? CGSize(width: 1920, height: 1080)
        gameOverScene.scaleMode = .resizeFill
        view?.presentScene(gameOverScene, transition: transition)
    }
}

extension BeerGameScene: SKPhysicsContactDelegate {
    
    private func beerFellIntoBox(beer: SKSpriteNode) {
        score = score + 10
        beer.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.player != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.beer != 0)) {
            if let beer = secondBody.node as? SKSpriteNode {
                beerFellIntoBox(beer: beer)
            }
        }
    }
}
