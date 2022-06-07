//
//  GridState.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import Foundation
import SpriteKit

class GridState {
    
    var cellSize: CGSize?
    
    var cells: Array<GridCell> = []
    
    func cellAt(x: CGFloat, y: CGFloat) -> GridCell? {
        
        return cells.filter { GridCell in
            let limits = GridCell.positionLimits as! (CGFloat, CGFloat, CGFloat, CGFloat)
            return true
        }.first
        
    }

    
    static func buildFromSkTileMapNode(node: SKTileMapNode) -> GridState {
        print("gridState prebuild")
        let state = GridState()
        state.cellSize = node.tileSize
        
        for c in 0...node.numberOfColumns {
            for r in 0...node.numberOfRows {
        
                let xAsCGFloat = CGFloat(c)
                let yAsCGFloat = CGFloat(r)
                
                let cell = GridCell()
                
                let size = node.tileSize
                let hight = size.height
                let width = size.width
                
                cell.size = node.tileSize
                cell.valid = true
                
                // from the size of the nodeTileSize and the enumeration c and r, define the limits of x,y to wich this cell is valid
                let lowx = xAsCGFloat * width
                let lowy = yAsCGFloat * hight
                let highx = ((xAsCGFloat+1) * width) - 1
                let highy = ((yAsCGFloat+1) * hight) - 1
                
                cell.positionLimits = (lower_x: lowx, lower_y: lowy, high_x: highx, high_y: highy)
                
                state.cells.append(cell)
            }
        }
        
        return state
    }
}


