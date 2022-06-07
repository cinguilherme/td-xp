//
//  MySceneTiled.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import SpriteKit
import GameplayKit

class MySceneTiled: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var tileMapNode: SKTileMapNode?
    
    var gridState: GridState?
    
    var logicalCells: Array<Any> = []
    
    var listTowers: Array<Tower> = []
    var central = CentralPillar()
    
    override func sceneDidLoad() {
        print("loaded screen")
        print("wating on tileMapNode to arive")
        
        print(tileMapNode)
        

        central.newCentralPillar()
        addChild(central.display!)
    }
    
    func notifyTileNodeLoaded(node: SKTileMapNode) {
        self.tileMapNode = node
        
        if let node = self.tileMapNode {
            self.gridState = GridState.buildFromSkTileMapNode(node: node)
            print(self.gridState!.cells)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        print("touched screen")

        let point = (touches.first?.location(in: self))!
        
        if let gridState = self.gridState {
            print(gridState.cellSize)
            print(gridState.cells)
            
            if let cell = cellForPointOn(point: point, grid: gridState) {
                print(cell)
            }
        }
        
        let t = Tower.newTower(at: point)
        addChild(t.display!)
        listTowers.append(t)
    }

    func towersNotOnCoolDown(listTower: Array<Tower>) -> Array<Tower> {
        return listTower.filter { tower in
            tower.cool_down()
        }
    }
    
    func towersSpawnShots(listTower: Array<Tower>) -> Array<Shot> {
        return listTower.map { Tower in
            Tower.spawnShots()
        }.flatMap { $0 }
    }
    
    func liveShots(shots: Array<Shot>) {
        for s in shots {
            addChild(s.displays!)
            s.followTrajectory()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let towers = towersNotOnCoolDown(listTower: listTowers)
        let shots = towersSpawnShots(listTower: towers)
        liveShots(shots: shots)
    }
    
}

