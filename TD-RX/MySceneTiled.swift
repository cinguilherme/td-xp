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
    
    var central = CentralPillar()
    var tower = Tower()
    
    override func sceneDidLoad() {

        print("loaded screen")

        central.newCentralPillar()
        tower.newTower()
        
        self.addChild(central.display!)
        self.addChild(tower.display!)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        print("touched screen")

        tower.display?.position = (touches.first?.location(in: self))!
    }

    override func update(_ currentTime: TimeInterval) {
        
        if tower.cool_down() {
            print("no cooldown")
        }
        //var shots = tower.spawnShots()
        
    }
    
}
