//
//  EnemyLevelFactory.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 07/06/22.
//

import Foundation

class EnemyLevelfactory {

    let limitX = 0
    let limitY = 0
    
    var spawnTicker = 0
    let threshHold = 300
    
    var centralPoint: CGPoint?
    
    func addOrSubRandom() -> String {
        if Bool.random() {
            return "+"
        }
        return "-"
    }
    
    func add(val: CGFloat) -> CGFloat {
        return val + CGFloat.random(in: 200...1000)
    }
    
    func sub(val: CGFloat) -> CGFloat {
        return val - CGFloat.random(in: 200...1000)
    }
    
    func addOrSubFn(_ val: String) -> (CGFloat) -> CGFloat {
        if val.elementsEqual("+") {
            return add
        } else {
            return sub
        }
    }
    
    func genRandomSpawnPointAwayFromCentralPoint(centralPoint: CGPoint) -> CGPoint {
        
        let x = addOrSubFn((addOrSubRandom()))(centralPoint.x)
        let y = addOrSubFn((addOrSubRandom()))(centralPoint.y)
        
        return CGPoint(x: x, y: y)
    }
    
    func spawnEnemy(centralPoint: CGPoint, spawnPoint: CGPoint) -> Enemy {
        let en = Enemy.newEnemy()
        
        en.spawnPoint = spawnPoint
        en.display?.position = spawnPoint
        en.destination = centralPoint
        
        return en
    }
    
    func newEnemiesSpawnByTick() -> Array<Enemy> {
        spawnTicker += 1
        if spawnTicker >= threshHold {
            spawnTicker = 0
            
            let range = 0...5
            return range.map { Int -> Enemy in
                let sp = genRandomSpawnPointAwayFromCentralPoint(centralPoint: centralPoint!)
                return spawnEnemy(centralPoint: centralPoint!, spawnPoint: sp)
            }
            
        }
        
        return []
    }
}
