//
//  GridState.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import Foundation
import SpriteKit

class GridState {
    
    var tileMapNode: SKTileMapNode?
    
    var cellSize: CGSize?
    
    var cellHash: [String : GridCell] = [:]
    
    func keyFrom(_ row: Int, _ col: Int) -> String {
        return "row\(row):col\(col)"
    }
    
    func cellAtTile(_ row: Int, _ colunm: Int) -> GridCell {
        let key = keyFrom(row, colunm)
        return cellHash[key]!
    }
    
    func pointToCell(point: CGPoint) {
        let column = tileMapNode!.tileColumnIndex(fromPosition: point)
        let row = tileMapNode!.tileRowIndex(fromPosition: point)
        let tile = tileMapNode!.tileDefinition(atColumn: column, row: row)
        
        let actualPoint = tileMapNode!.centerOfTile(atColumn: column, row: row)
    }

    static func buildFromSkTileMapNode(node: SKTileMapNode) -> GridState {
        
        let state = GridState()
        
        state.cellSize = node.tileSize
        
        for c in 0...node.numberOfColumns {
            for r in 0...node.numberOfRows {
        
                let key = "row\(r):col\(c)"
                let v = GridCell()
                
                state.cellHash[key] = v
            }
        }
        
        return state
    }
}


