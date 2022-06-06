//
//  ShotLogicStraight.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import Foundation

func shotLogicInLineDestination(from: CGPoint, direction: Direction) -> CGPoint {
    let x = from.x
    let y = from.y
    switch direction {
    case .North:
        return CGPoint(x: x, y: (y + 1000.0))
    case .East:
        return CGPoint(x: (x + 1000), y: y)
    case .West:
        return CGPoint(x: (x - 1000), y: y)
    case .South:
        return CGPoint(x: x, y: (y - 1000.0))
    }
}
