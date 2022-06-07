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
        
        //tileMapNode = SKNode.unarchiveFromFile(file: "MySceneTiled")?.children.first as! SKTileMapNode
        
        //print("tilemapnode is here!")
        
        print(tileMapNode)
        
        gridState = GridState()
        
        //populate gridStateCells with the empty cells
        
        central.newCentralPillar()
        addChild(central.display!)
    }
    
    func notifyTileNodeLoaded(node: SKTileMapNode) {
        self.tileMapNode = node
        
        if let node = self.tileMapNode {
            GridState.buildFromSkTileMapNode(node: node)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        print("touched screen")

        let point = (touches.first?.location(in: self))!
        
        //let locatedCellInGrid =
        
        var cell = cellForPointOn(point: point, grid: gridState!)
        print(cell)
        
        
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

