//
//  Finalresultscene.swift
//  Serpientesypoemas
//
//  Created by iOS Lab on 24/01/24.
//

import SpriteKit
 
class FinalResultScene: SKScene {
    var poemLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(hex: 0x008c8d) // Replace with your desired Hex color
        // Customize the poem label and layout
        poemLabel = SKLabelNode(text: "Your Poem:")
        poemLabel.fontSize = 45
        poemLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
        poemLabel.fontName = UIFont.boldSystemFont(ofSize: 28).fontName
        poemLabel.fontName = "Bubbly-Regular" // Replace with your custom font name
        addChild(poemLabel)
        
        // Customize the buttons
        let newGameButton = SKLabelNode(text: "New Game")
        newGameButton.fontSize = 36
        newGameButton.position = CGPoint(x: size.width * 0.25, y: size.height * 0.2)
        newGameButton.fontName = UIFont.boldSystemFont(ofSize: 24).fontName
        newGameButton.fontName = "Bubbly-Regular" // Replace with your custom font name
        newGameButton.name = "newGameButton"
        addChild(newGameButton)
        
        let menuButton = SKLabelNode(text: "Main Menu")
        menuButton.fontSize = 36
        menuButton.position = CGPoint(x: size.width * 0.75, y: size.height * 0.2)
        menuButton.fontName = UIFont.boldSystemFont(ofSize: 24).fontName
        menuButton.fontName = "Bubbly-Regular" // Replace with your custom font name
        menuButton.name = "menuButton"
        addChild(menuButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodesAtPoint = nodes(at: location)
            
            for node in nodesAtPoint {
                if node.name == "newGameButton" {
                    // Change the scene class to match your game's initial scene
                    let gameScene = GameScene(size: size)
                    view?.presentScene(gameScene)
                } else if node.name == "menuButton" {
                    // Change the scene class to match your game's main menu scene
                    let menuScene = MainMenuScene(size: size)
                    view?.presentScene(menuScene)
                }
            }
        }
    }
}
