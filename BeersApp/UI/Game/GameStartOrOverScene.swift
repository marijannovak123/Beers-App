//
//  GameOverScene.swift
//  BeersApp
//
//  Created by Marijan on 08/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import SpriteKit

class GameStartOrOverScene: SKScene {
    
    var isGameOver: Bool = true
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = UIColor.white
        
        DispatchQueue.main.async {
            let textSprite = SKLabelNode(text: self.isGameOver ? "Game Over" : "Touch to start game")
            textSprite.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            textSprite.fontColor = UIColor.black
            self.addChild(textSprite)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.first != nil else {
            return
        }
        
        let transition = SKTransition.fade(withDuration: 1.0)
        let gameScene = BeerGameScene()
        gameScene.size = view?.bounds.size ?? CGSize(width: 1920, height: 1080)
        gameScene.scaleMode = .resizeFill
        view?.presentScene(gameScene, transition: transition)
    }
}
