//
//  GameScene.swift
//  BeersApp
//
//  Created by Marijan on 07/03/2019.
//  Copyright © 2019 Marijan. All rights reserved.
//

import SpriteKit
import GameKit

class BeerGameScene: SKScene {
    
    let beerSprite = SKSpriteNode(imageNamed: "beer-sprite")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        beerSprite.position = CGPoint(x: view.center.x, y: view.center.y)
        beerSprite.zPosition = 5
        addChild(beerSprite)
    }
    
    override func update(_ currentTime: TimeInterval) {
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        beerSprite.position = CGPoint(x: beerSprite.position.x + 20, y: beerSprite.position.y)
    }
}
