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
    
    var listTowers: Array<Tower> = []
    var central = CentralPillar()
    
    override func sceneDidLoad() {

        print("loaded screen")

        central.newCentralPillar()
        
        addChild(central.display!)

    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        print("touched screen")

        let point = (touches.first?.location(in: self))!
        let t = Tower.newTower(at: point)
        addChild(t.display!)
        listTowers.append(t)
        
    }

    func towersNotOnCoolDown(listTower: Array<Tower>) -> Array<Tower> {
        let liveTs = listTower.filter { tower in
            tower.cool_down()
        }
        print("live towers")
        print(liveTs)
        
        return liveTs
    }
    
    func towersSpawnShots(listTower: Array<Tower>) -> Array<Shot> {
        print("listOfTower")
        print(listTower)
        let shots = listTower.map { Tower in
            Tower.spawnShots()
        }.flatMap { $0 }
        
        print("shots")
        print(shots)
        
        return shots
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
