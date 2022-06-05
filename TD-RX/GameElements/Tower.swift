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
    
    func newTower() {
        display = SKSpriteNode(color: .blue, size: CGSize(width: 25.0, height: 25.0))
    }
    
    func cool_down() -> Bool {
        return true
    }
    
    func spawnShots() -> Array<Shot> {
         return [Shot()]
    }
    
}
