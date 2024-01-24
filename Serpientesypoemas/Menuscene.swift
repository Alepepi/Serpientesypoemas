//
//  Menuscene.swift
//  Serpientesypoemas
//
//  Created by iOS Lab on 24/01/24.
//

import SpriteKit
 
extension SKColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
            let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(hex & 0x0000FF) / 255.0
 
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
 
class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        // Set the background color using RGB values
        backgroundColor = SKColor(hex: 0x008c8d) // Replace with your desired Hex color
        // Change the text on the "Start Game" button
        let startGameButton = SKLabelNode(text: "Start Game")
        startGameButton.fontSize = 60
        startGameButton.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
        startGameButton.fontName = UIFont.boldSystemFont(ofSize: 24).fontName
        startGameButton.fontName = "Bubbly-Regular" // Replace with your custom font name
        startGameButton.name = "startGameButton"
        addChild(startGameButton)
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodesAtPoint = nodes(at: location)
 
            for node in nodesAtPoint {
                if node.name == "startGameButton" {
                    // Change the scene class to match your game's initial scene
                    let gameScene = GameScene(size: size)
                    view?.presentScene(gameScene)
                }
            }
        }
    }
}
