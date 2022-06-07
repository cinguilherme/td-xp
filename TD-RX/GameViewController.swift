//
//  GameViewController.swift
//  TD-RX
//
//  Created by Guilherme Cintra on 04/06/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "MySceneTiled") {
        //if let scene = GKScene(fileNamed: "GameScene") {
            print("loaded scene?")
            
            let tileMapNode = SKNode.unarchiveFromFile(file: "MySceneTiled")?.children.first as! SKTileMapNode
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! MySceneTiled? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                //sceneNode.tileMapNode = tileMapNode
                
                sceneNode.notifyTileNodeLoaded(node: tileMapNode)
                
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.showsPhysics = true
                    view.showsDrawCount = true
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = Bundle.main.path(forResource: file as String, ofType: "sks") {
            let sceneData = NSData(contentsOfFile: path)

            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData as! Data)

            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! SKNode
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}
