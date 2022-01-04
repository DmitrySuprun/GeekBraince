//
//  GameViewController.swift
//  Snake
//
//  Created by Дмитрий Супрун on 30.12.21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        
        let skView = view as! SKView
            
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
}
