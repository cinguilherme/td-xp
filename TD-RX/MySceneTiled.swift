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
            //print(self.gridState?.cellHash)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        print("touched screen")

        let point = (touches.first?.location(in: self))!
        
        let column = tileMapNode!.tileColumnIndex(fromPosition: point)
        let row = tileMapNode!.tileRowIndex(fromPosition: point)
        
        
        let actualPoint = tileMapNode!.centerOfTile(atColumn: column, row: row)
        
        
        let cell = gridState!.cellAtTile(row, column)
        
        //determine if cell is empty before placing the thing
        if cell.valid {
            let t = Tower.newTower(at: actualPoint)
            addChild(t.display!)
            listTowers.append(t)
            cell.valid = false
        } else {
            print("cell already ocupied, can't act here!")
        }
        
        
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
    
    func spawnNewShots(listTowers: Array<Tower>) -> Array<Shot> {
        return towersNotOnCoolDown(listTower: listTowers).map { t in
            t.spawnShots()
        }.flatMap { $0 }
    }
    
    func liveShots(shots: Array<Shot>) {
        for s in shots {
            addChild(s.displays!)
            s.followTrajectory()
        }
    }
    
    func collisionDetection() {

        enemies.map { enemy -> (Enemy, Array<Shot>) in
            let shotsHitEnemy = liveShots.filter { shot in
                enemy.display!.frame.intersects(shot.displays!.frame)
            }
            
            return (enemy, shotsHitEnemy)
        }.filter { (e, s) in
            !s.isEmpty
        }.forEach { (enemy, shots) in
            print("enemy was hit by")
            print(shots)
            
            
            
        }
        
    }
    
    func clearDeadShots() {
        liveShots = liveShots.filter { s in
            s.displays?.parent != nil
        }
    }
    
    func addNewShots(_ newShots: Array<Shot>) {
        liveShots.append(contentsOf: newShots)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        clearDeadShots()
        
        let newShots = spawnNewShots(listTowers: listTowers)
        addNewShots(newShots)
        
        
        if let newEnemies = enemyFactory?.newEnemiesSpawnByTick() {
            enemies.append(contentsOf: newEnemies)
            newEnemies.forEach { Enemy in
                addChild(Enemy.display!)
                Enemy.followTrajectory()
            }
        }
        
        liveShots(shots: newShots)
        
        collisionDetection()
    }
    
}

