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
    
    var towerCoolDownTime: TimeInterval?
    var coolDownTimer: Timer?
    var inCoolDown: Bool = true
    
    static func newTower(at: CGPoint) -> Tower {
        let t = Tower()
        t.display = SKSpriteNode(color: .blue, size: CGSize(width: 25.0, height: 25.0))
        t.display?.position = at
        
        t.towerCoolDownTime = TimeInterval(0.2)
        t.inCoolDown = true
        t.coolDownTimer = Timer.scheduledTimer(withTimeInterval: t.towerCoolDownTime!, repeats: true, block: { _ in
            t.inCoolDown = false
        })
        
        return t
    }
    
    func newTower() {
        display = SKSpriteNode(color: .blue, size: CGSize(width: 25.0, height: 25.0))
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
