//
//  Enemy.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import Foundation
import SpriteKit

class Enemy {
    
    var display: SKSpriteNode?
    
    var spawnPoint: CGPoint?
    var destination: CGPoint?
    
    func followTrajectory() {
        if let destination = destination {
            
            display!.run(SKAction.sequence(
                [SKAction.group([
                    SKAction.moveTo(x: destination.x, duration: TimeInterval(7.0)),
                    SKAction.moveTo(y: destination.y, duration: TimeInterval(7.0))
                ]),
                SKAction.removeFromParent()]))
        }
    }
    
    static func newEnemy() -> Enemy {
        let en = Enemy()
        
        en.display = SKSpriteNode(color: .brown, size: CGSize(width: 20.0, height: 20.0))
        en.display?.name = "enemy"
        
        en.display?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 35.0, height: 35.0))
        en.display?.physicsBody?.categoryBitMask = enemyCategory
        en.display?.physicsBody?.mass = 0
        en.display?.physicsBody?.affectedByGravity = false
        en.display?.physicsBody?.allowsRotation = false
        en.display?.physicsBody?.usesPreciseCollisionDetection = true
        
        
        return en
    }
    
}
