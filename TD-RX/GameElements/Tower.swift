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
    
    var towerCoolDownTime: Float32 = 0.8
    var currentTimeCheck: Float32 = 0.0
    
    var inCoolDown: Bool = true
    
    static func newTower(at: CGPoint) -> Tower {
        let t = Tower()
        t.display = SKSpriteNode(color: .blue, size: CGSize(width: 25.0, height: 25.0))
        t.display?.position = at
        
        t.inCoolDown = true
        
        return t
    }
    
    func newTower() {
        display = SKSpriteNode(color: .blue, size: CGSize(width: 25.0, height: 25.0))
    }
    
    func coolDownTimeCheck(_ interval: Float32) {
        currentTimeCheck += interval
        if(currentTimeCheck >= towerCoolDownTime) {
            inCoolDown = false
            currentTimeCheck = 0
        }
    }
    
    func spawnShots() -> Array<Shot> {
        if inCoolDown == false {
            inCoolDown = true
            if let display = display {
                let s = Shot.newShot(startPoint: display.position)
                return [s]
            }
        }
        return []
    }
    
}
