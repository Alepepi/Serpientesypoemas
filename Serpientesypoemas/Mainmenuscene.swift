//
//  Mainmenuscene.swift
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
        // Add an image above the color background
        let backgroundImage = SKSpriteNode(imageNamed: "Fondo") // Replace with your image file name
        backgroundImage.setScale(1.0) // Keep the original size
        backgroundImage.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        backgroundImage.zPosition = 1 // Place it above the color background
        addChild(backgroundImage)
        
        // Change the text on the "Start Game" button with a border
        let startGameButton = SKLabelNode()
        let labelText = "Start Game"
        let attributedText = NSMutableAttributedString(string: labelText, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 60),
            NSAttributedString.Key.foregroundColor: SKColor.white,
            NSAttributedString.Key.strokeColor: SKColor.black, // Border color
            NSAttributedString.Key.strokeWidth: -3.0 // Border width (negative for fill)
        ])
        startGameButton.attributedText = attributedText
        startGameButton.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
        startGameButton.name = "startGameButton"
        startGameButton.zPosition = 2 // Place it above the image
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
