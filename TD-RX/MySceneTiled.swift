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
        
        central.newCentralPillar()
        addChild(central.display!)
    }
    
    func notifyTileNodeLoaded(node: SKTileMapNode) {
        self.tileMapNode = node
        
        if let node = self.tileMapNode {
            self.gridState = GridState.buildFromSkTileMapNode(node: node)
        }
    }
    
    func handleTapFrom(recognizer: UITapGestureRecognizer) {
        if recognizer.state != .ended {
            return
        }

        let recognizorLocation = recognizer.location(in: recognizer.view!)
        let location = self.convertPoint(fromView: recognizorLocation)

        let column = tileMapNode!.tileColumnIndex(fromPosition: location)
        let row = tileMapNode!.tileRowIndex(fromPosition: location)
        let tile = tileMapNode!.tileDefinition(atColumn: column, row: row)
        
        print("touched cell at \(row) and \(column)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        print("touched screen")

        let point = (touches.first?.location(in: self))!
        
        let c = tileMapNode?.tileColumnIndex(fromPosition: point)
        let r = tileMapNode?.tileRowIndex(fromPosition: point)
        let def = tileMapNode?.tileDefinition(atColumn: c!, row: r!)
        
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

