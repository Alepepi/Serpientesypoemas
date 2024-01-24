//
//  GameScene.swift
//  Serpientesypoemas
//
//  Created by iOS Lab on 24/01/24.
//

import SpriteKit
import AVFoundation
 
class GameScene: SKScene {
    var playerNode: SKSpriteNode!
    var diceNode: SKSpriteNode!
    var boardNode: SKSpriteNode!
    var isRolling = false
    var currentSpace = 0
    var imageNode: SKSpriteNode?
    
    let snakesAndLadders: [Int: Int] = [
        7: 23, // Ladder from space 7 to 23
        10: 27, // Ladder from space 10 to 27
        34: 44, // Ladder from space 34 to 44
        16: 3, // Snake from space 16 to 3
        33: 19, // Snake from space 33 to 19
        42: 22 // Snake from space 42 to 22
    ]
    
    // List of strings with indexes and associated image file names
    let gameTexts: [(Int, String, String)] = [
        (1, "Estas al inicio formado", "01"),
        (2, "", "02"),
        (3, "", "03"),
        (4, "Los dados ruedan y escapan a tu mano", "04"),
        (5, "", "05"),
        (6, "", "06"),
        (7, "Avanzas sin ningún atraso", "07"),
        (8, "", "08"),
        (9, "", "09"),
        (10, "Entre casillas buscas el atajo", "10"),
        (11, "", "11"),
        (12, "", "12"),
        (13, "No ves los dientes del engaño", "13"),
        (14, "", "14"),
        (15, "Y la boca de serpiente te lleva hacia abajo", "15"),
        (16, "", "16"),
        (17, "", "17"),
        (18, "Se acerca mordiendo el fracaso", "18"),
        (19, "", "19"),
        (20, "", "20"),
        (22, "Ganar parece algo lejano", "22"),
        (23, "", "23"),
        (24, "", "24"),
        (25, "Tiras dados, que siga el relajo", "25"),
        (26, "", "26"),
        (27, "", "27"),
        (28, "Atrás medio tablero ha quedado", "28"),
        (29, "", "29"),
        (30, "", "30"),
        (31, "Entre risas pegas brincos y saltos", "31"),
        (32, "", "32"),
        (33, "", "33"),
        (34, "Subes la escalera, peldaño a peldaño", "34"),
        (35, "", "35"),
        (36, "", "36"),
        (37, "A la meta estás más cercano", "37"),
        (38, "", "38"),
        (39, "", "39"),
        (40, "Avanzas, cuidando cada paso", "40"),
        (41, "", "41"),
        (42, "", "42"),
        (43, "Escalas hasta lo más alto", "43"),
        (44, "", "44"),
        (45, "", "45"),
        (46, "En la meta estás, has ganado", "46")
    ]
    
    var speechSynthesizer = AVSpeechSynthesizer()
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor(hex: 0x008c8d) // Replace with your desired Hex color
        // Load your game assets and logic
 
        // Load and add your game board image
        boardNode = SKSpriteNode(imageNamed: "BoardV1")
        boardNode.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
        boardNode.setScale(min(size.width / boardNode.size.width, size.height / boardNode.size.height))
        addChild(boardNode)
 
        // Example: Load your player image
        playerNode = SKSpriteNode(imageNamed: "player_image")
        playerNode.position = CGPoint(x: size.width * 0.95, y: size.height * 0.47)
        playerNode.setScale(0.3) // Scale the player sprite as needed
        addChild(playerNode)
 
        // Example: Load your dice image
        diceNode = SKSpriteNode(imageNamed: "F1")
        diceNode.position = CGPoint(x: size.width * 0.5, y: size.height * 0.25)
        diceNode.setScale(0.5) // Scale the dice sprite as needed
        addChild(diceNode)
 
        // Add a tap gesture to handle image removal
        let tapGestureToCloseImage = UITapGestureRecognizer(target: self, action: #selector(handleImageTap(_:)))
        view.addGestureRecognizer(tapGestureToCloseImage)
        
        // Add a tap gesture to roll the dice
        let tapGestureToRollDice = UITapGestureRecognizer(target: self, action: #selector(rollDice))
        view.addGestureRecognizer(tapGestureToRollDice)
    }
 
    @objc func handleImageTap(_ sender: UITapGestureRecognizer) {
        // If an image is displayed, remove it
        if let _ = imageNode {
            hideImage()
        }
    }
    
    @objc func rollDice() {
        if isRolling {
            return
        }
        isRolling = true
 
        // Simulate dice roll animation
        var textures: [SKTexture] = []
        var finalRollValue = 0 // Initialize the final roll value
 
        for _ in 1...10 {
            let randomRoll = Int.random(in: 1...6)
            textures.append(SKTexture(imageNamed: "F\(randomRoll)"))
            finalRollValue = randomRoll // Store the last randomRoll value
        }
        let animation = SKAction.animate(with: textures, timePerFrame: 0.1)
 
        diceNode.run(animation) {
            self.isRolling = false
            // Implement your game logic here
 
            // Update the current space based on the dice roll
            self.currentSpace += finalRollValue // Use the final roll value
            print("Dice value: \(finalRollValue)") // Print the final roll value
 
            // Check if the player has reached the end space (e.g., space 48)
            if self.currentSpace >= 46 {
                print("Game Over. Player reached the end!")
                // You can present the final result scene here
                // For example:
                let finalResultScene = FinalResultScene(size: self.size)
                self.view?.presentScene(finalResultScene)
            } else {
                print("Player is now on space \(self.currentSpace)")
                // You can add your game logic for handling player movement, events, etc.
                
                // Display the game text based on the current space
                if let text = self.gameTexts.first(where: { $0.0 == self.currentSpace }) {
                    print("Game Text: \(text.1)")
                    
                    // Show the associated image when a specific space is reached
                    self.showImage(imageName: text.2, )
                } else {
                    // Hide the image when the player moves to another space
                    self.hideImage()
                }
            }
        }
    }
    
    func showImage(imageName: String, poemText: String) {
        // Create a black background
        let backgroundNode = SKSpriteNode(color: SKColor.black, size: size)
        backgroundNode.zPosition = 0.5  // Set zPosition to a value lower than the image's zPosition
        backgroundNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(backgroundNode)
 
        // Load and display the associated image
        imageNode = SKSpriteNode(imageNamed: imageName)
 
        // Calculate the scale to fit the image within the scene
        let scale = min(size.width / imageNode!.size.width, size.height / imageNode!.size.height)
        imageNode!.setScale(scale)
 
        // Position the image at the center of the scene
        imageNode!.position = CGPoint(x: size.width / 2, y: size.height / 2)
 
        // Set a higher zPosition to bring the image to the front
        imageNode!.zPosition = 1.0
 
        addChild(imageNode!)
 
        // Read the poem text aloud using text-to-speech
        readTextAloud(poemText)
 
        // Add a delay of 8 seconds before hiding the image and background
        let delayAction = SKAction.wait(forDuration: 6.0)
        let hideAction = SKAction.run {
            self.hideImage()
            backgroundNode.removeFromParent()
        }
 
        let sequence = SKAction.sequence([delayAction, hideAction])
        imageNode!.run(sequence)
    }
    
    func readTextAloud(_ text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US") // Change the language if needed
 
        // Speak the text
        speechSynthesizer.speak(speechUtterance)
    }
 
    
    func hideImage() {
        // Remove and hide the image from the scene
        imageNode?.removeFromParent()
        imageNode = nil
    }
}