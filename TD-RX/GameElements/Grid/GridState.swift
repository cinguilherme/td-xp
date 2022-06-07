//
//  GridState.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import Foundation
import SpriteKit

class GridState {
    
    let cellSize: CGFloat = 64.0
    
    let cells: Array<GridCell> = []
    
    func cellAt(x: CGFloat, y: CGFloat) -> GridCell {
        return GridCell()
    }

    
    static func buildFromSkTileMapNode(node: SKTileMapNode) -> GridState {
        let state = GridState()
        
        state.cellSize = node.tileSize
        
        let count = node.numberOfRows
        let cols = node.numberOfColumns
        
        return state
    }
}


