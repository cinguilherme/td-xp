//
//  SceneLogic.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 11/06/22.
//

import Foundation

class SceneLogic {

    static func towersNotOnCoolDown(listTower: Array<Tower>) -> Array<Tower> {
        return listTower.filter { tower in
            tower.cool_down()
        }
    }
    
    static func towersSpawnShots(listTower: Array<Tower>) -> Array<Shot> {
        return listTower.map { Tower in
            Tower.spawnShots()
        }.flatMap { $0 }
    }
    
    static func spawnNewShots(listTowers: Array<Tower>) -> Array<Shot> {
        return towersNotOnCoolDown(listTower: listTowers).map { t in
            t.spawnShots()
        }.flatMap { $0 }
    }
    
    static func collisionDetection(enemies: Array<Enemy>, liveShots: Array<Shot>) -> Array<(Enemy, Array<Shot>)> {
        return enemies.map { enemy -> (Enemy, Array<Shot>) in
            let shotsHitEnemy = liveShots.filter { shot in
                enemy.display!.frame.intersects(shot.displays!.frame)
            }
            
            return (enemy, shotsHitEnemy)
        }.filter { (e, s) in
            !s.isEmpty
        }
    }
    
    static func clearDeadShots(_ liveShots: Array<Shot>) -> Array<Shot> {
        return liveShots.filter { s in
            s.displays?.parent != nil
        }
    }
    
    static func clearDeadEnemies(_ enemies: Array<Enemy>) -> Array<Enemy> {
        return enemies.filter { s in
            s.display?.parent != nil
        }
    }
}
