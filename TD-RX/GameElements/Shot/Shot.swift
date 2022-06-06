//
//  Shot.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import Foundation
import SpriteKit

class Shot {
    
    let baseLineETA = 5.0
    var speed: Float64 = 0.0
    
    var displays: SKSpriteNode?
    var directionPointed: NSEnumerator?
    var startPoint: CGPoint?
    var destination: CGPoint?
    var destinations: Array<CGPoint>?
    
    static func newShot(startPoint at: CGPoint) -> Shot {
        
        let shot = Shot()
        shot.displays = SKSpriteNode(color: .cyan, size: CGSize(width: 5.0, height: 5.0))
        shot.displays?.position = at
        shot.startPoint = at
        
        shot.speed = 0.0
        
        shot.destination = shotLogicInLineDestination(from: at, direction: Direction.North)
        
        return shot
    }
    
    func timeToDestinationBasedOnSpeed() -> TimeInterval {
        let expected = baseLineETA - ((baseLineETA / 100) * speed)
        
        return TimeInterval(expected)
    }
    
    func followTrajectory() {
        if let destination = destination {
            
            displays!.run(SKAction.sequence(
                [SKAction.group([
                    SKAction.moveTo(x: destination.x, duration: TimeInterval(2.0)),
                    SKAction.moveTo(y: destination.y, duration: TimeInterval(2.0))
                ]),
                SKAction.removeFromParent()]))
        }
    }
    
}
