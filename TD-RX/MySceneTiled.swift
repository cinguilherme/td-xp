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
    
    var enemyFactory: EnemyLevelfactory?
    var enemies: Array<Enemy> = []
    
    var liveShots: Array<Shot> = []
    
    var central = CentralPillar()
    
    override func sceneDidLoad() {
        print("loaded screen")
        print("wating on tileMapNode to arive")
        
        central.newCentralPillar()
        addChild(central.display!)
        
        enemyFactory = EnemyLevelfactory()
        enemyFactory?.centralPoint = central.point
    }
    
    func notifyTileNodeLoaded(node: SKTileMapNode) {
        self.tileMapNode = node
        
        if let node = self.tileMapNode {
            self.gridState = GridState.buildFromSkTileMapNode(node: node)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        print("touched screen")

        let point = (touches.first?.location(in: self))!
        
        let column = tileMapNode!.tileColumnIndex(fromPosition: point)
        let row = tileMapNode!.tileRowIndex(fromPosition: point)
        
        
        let actualPoint = tileMapNode!.centerOfTile(atColumn: column, row: row)
        
        let cell = gridState!.cellAtTile(row, column)
        
        if cell.valid {
            let t = Tower.newTower(at: actualPoint)
            addChild(t.display!)
            listTowers.append(t)
            cell.valid = false
        } else {
            print("cell already ocupied, can't act here!")
        }
        
        
    }
    
    func addShotsToSceneAndBeginAnimation(shots: Array<Shot>) {
        for s in shots {
            addChild(s.displays!)
            s.followTrajectory()
        }
    }
    
    func collisionDetection() {

        let hitCol = SceneLogic.collisionDetection(enemies: enemies, liveShots: liveShots)
        
        hitCol.forEach { (enemy, shots) in
            print("enemy was hit by")
            print(shots)
        }
        
    }
   
    override func update(_ currentTime: TimeInterval) {
        if let newEnemies = enemyFactory?.newEnemiesSpawnByTick() {
            enemies.append(contentsOf: newEnemies)
            newEnemies.forEach { Enemy in
                addChild(Enemy.display!)
                Enemy.followTrajectory()
            }
        }
        
        liveShots = SceneLogic.clearDeadShots(liveShots)
        let newShots = SceneLogic.spawnNewShots(listTowers: listTowers)
        liveShots.append(contentsOf: newShots)
        
        addShotsToSceneAndBeginAnimation(shots: newShots)
        
        collisionDetection()
    }
    
}

