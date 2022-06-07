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
    
    var cellHash: [String : GridCell] = [:]

    func buildHash() {
        cells.forEach { cell in
            let posL = cell.positionLimits as! (CGFloat, CGFloat, CGFloat, CGFloat)
            let x = String(describing: posL.0)
            let y = String(describing: posL.1)
            
            cellHash[x+y] = cell
        }
        
        print(cellHash)
    }
    
    func cellAt(x: CGFloat, y: CGFloat) -> GridCell? {
        
        // from x to lower x nad y to lower y, use this as key for the hash and recover the cell.
        if let cellSize = cellSize {
            
            let bx = (x / cellSize.width)
            let by = (y / cellSize.height)
            let strKey = String(describing: bx) + String(describing: by)
            print(strKey)
            
        }
        
        return cells.filter { GridCell in
            let limits = GridCell.positionLimits as! (CGFloat, CGFloat, CGFloat, CGFloat)
            return true
        }.first
        
    }

    static func buildFromSkTileMapNode(node: SKTileMapNode) -> GridState {
        
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
                
                let lowx = xAsCGFloat * width
                let lowy = yAsCGFloat * hight
                let highx = ((xAsCGFloat+1) * width) - 1
                let highy = ((yAsCGFloat+1) * hight) - 1
                
                cell.positionLimits = (lower_x: lowx, lower_y: lowy, high_x: highx, high_y: highy)
                state.cells.append(cell)
            }
        }
        
        state.buildHash()
        
        return state
    }
}


