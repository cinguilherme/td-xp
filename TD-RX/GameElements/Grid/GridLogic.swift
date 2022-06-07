//
//  GridLogic.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import Foundation

func cellForPointOn(point: CGPoint, grid: GridState) -> GridCell? {
    
    if let size = grid.cellSize {
        print("cell lookup")
        let x = point.x / size.width
        let y = point.y / size.height
        
        return grid.cellAt(x: x, y: y)
        
    }
    
    return GridCell()
}
