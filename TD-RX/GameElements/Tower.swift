//
//  Tower.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import Foundation
import SpriteKit

class Tower {
    
    var display: SKSpriteNode?
    
    var cooldownTimeTicks = 5
    
    var currentTick = 0
    
    static func newTower(at: CGPoint) -> Tower {
        let t = Tower()
        t.display = SKSpriteNode(color: .blue, size: CGSize(width: 25.0, height: 25.0))
        t.display?.position = at
        return t
    }
    
    func newTower() {
        display = SKSpriteNode(color: .blue, size: CGSize(width: 25.0, height: 25.0))
    }
    
    func incTick() {
        if currentTick > cooldownTimeTicks {
            currentTick = 0
        } else {
            currentTick += 1
        }
    }
    
    func cool_down() -> Bool {
        incTick()
        return currentTick == cooldownTimeTicks
    }
    
    func spawnShots() -> Array<Shot> {
        if let display = display {
            let s = Shot.newShot(startPoint: display.position)
            return [s]
        }
         return []
    }
    
}
