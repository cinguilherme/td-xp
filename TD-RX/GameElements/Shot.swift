//
//  Shot.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import Foundation
import SpriteKit

class Shot {
    
    var displays: SKSpriteNode?
    
    var directionPointed: NSEnumerator?
    var startPoint: CGPoint?
    var destination: CGPoint?
    
    static func newShot(startPoint at: CGPoint) -> Shot {
        let shot = Shot()
        shot.displays = SKSpriteNode(color: .cyan, size: CGSize(width: 5.0, height: 5.0))
        shot.startPoint = at
        shot.destination = CGPoint(x: at.x, y: (at.y + 100.0))
        return shot
    }
    
    func followTrajectory() {
        if let destination = destination {
            displays!.run(SKAction.moveTo(x: destination.x, duration: TimeInterval(1.5)))
            displays!.run(SKAction.moveTo(y: destination.y, duration: TimeInterval(1.5)))
        }
    }
    
}
