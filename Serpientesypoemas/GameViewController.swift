//
//  GameViewController.swift
//  Serpientesypoemas
//
//  Created by iOS Lab on 24/01/24.
//

import UIKit
import SpriteKit
 
class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
 
        if let view = self.view as! SKView? {
            // Create and present the main menu scene
            let menuScene = MainMenuScene(size: view.bounds.size)
            view.presentScene(menuScene)
            view.ignoresSiblingOrder = true
        }
    }
}
