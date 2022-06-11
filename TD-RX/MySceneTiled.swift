//
//  MySceneTiled.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 05/06/22.
//

import SpriteKit
import UIKit
import GameplayKit

class MySceneTiled: SKScene, SKPhysicsContactDelegate {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var tileMapNode: SKTileMapNode?
    
    var gridState: GridState?
    
    var logicalCells: Array<Any> = []
    
    var listTowers: Array<Tower> = []
    
    var enemyFactory: EnemyLevelfactory?
    
    var central = CentralPillar()
    
    var enemySpawnTimer: Timer?
    
    var shotsSpawnTimer: Timer?
    
    var towersCoolDownTimer: Timer?
    
    let concurrentQueue = DispatchQueue(label: "towers_spawns", attributes: .concurrent)
    
    let enemyDispatchQueue = DispatchQueue(label: "enemy_factory", attributes: .concurrent)
    
    override func sceneDidLoad() {
        print("loaded screen")
        print("wating on tileMapNode to arive")
        
        central.newCentralPillar()
        addChild(central.display!)
        
        enemyFactory = EnemyLevelfactory()
        enemyFactory?.setupTimers()
        enemyFactory?.centralPoint = central.point
        
        enemySpawnTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1.0), repeats: true, block: { timer in
            self.enemyDispatchQueue.async {
                if let newEnemies = self.enemyFactory?.newEnemiesSpawn() {
                
                    newEnemies.forEach { Enemy in
                        Enemy.followTrajectory()
                    }
                    
                    DispatchQueue.main.sync {
                        newEnemies.forEach { e in
                            self.addChild(e.display!)
                        }
                    }
                }
            }
            
        })
        
        towersCoolDownTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.1), repeats: true, block: { tm in
            
            self.listTowers.forEach { t  in
                self.concurrentQueue.sync {
                    t.coolDownTimeCheck(0.1)
                    
                    t.spawnShots().forEach { s in
                        self.addChild(s.displays!)
                        s.followTrajectory()
                    }
                    
                }
            }
            
        })
        
    }
    
    func notifyTileNodeLoaded(node: SKTileMapNode) {
        self.tileMapNode = node
        
        if let node = self.tileMapNode {
            self.gridState = GridState.buildFromSkTileMapNode(node: node)
            
            //test default towers already in place so can assert performance
            for x in 25...50 {
                for y in 27...32 {
                    let cell = gridState!.cellAtTile(x, y)
                    let actualPoint = tileMapNode!.centerOfTile(atColumn: x, row: y)
                    if cell.valid {
                        let t = Tower.newTower(at: actualPoint)
                        addChild(t.display!)
                        listTowers.append(t)
                        cell.valid = false
                    } else {
                        print("cell already ocupied, can't act here!")
                    }
                }
            }
                    
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
    
   
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let secondNode = contact.bodyB.node as! SKSpriteNode
        //print(secondNode)
        if (contact.bodyA.categoryBitMask == enemyCategory) &&
            (contact.bodyB.categoryBitMask == shotCategory) {

            let contactPoint = contact.contactPoint
            
//            print(contactPoint)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
    
    }
    
}

