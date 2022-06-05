//
//  CentralPillar.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import Foundation
import SpriteKit

class CentralPillar {
    
    var display: SKSpriteNode?
    
    func newCentralPillar() {
        display = SKSpriteNode(color: .red, size: CGSize(width: 50.0, height: 50.0))
    }
    
}
