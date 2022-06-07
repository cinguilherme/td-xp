//
//  GridCell.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import Foundation
import SpriteKit

class GridCell : CustomStringConvertible{
    
    var col: Int?
    var row: Int?
    var tileDefinition: SKTileDefinition?
    
    var description: String {
        get {
            return "{valid: \(valid ?? true) size: \(String(describing: size)) occupiedBy: \(String(describing: ocupiedBy)) positionLimits: \(String(describing: positionLimits))  }"
        }
    }
    
    
    var valid: Bool?
    var size: CGSize?
    var ocupiedBy: String?
    var positionLimits: Any?
    

    
}
