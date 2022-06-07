//
//  GridLogic.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import Foundation

func cellForPointOn(point: CGPoint, grid: GridState) -> GridCell {
    
    let size = grid.cellSize
    
    let x = point.x / size
    let y = point.y / size
    
    let cell = grid.cellAt(x: x, y: y)
    
    return GridCell()
}
