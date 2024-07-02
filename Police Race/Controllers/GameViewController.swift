//
//  GameViewController.swift
//  Police Race
//
//  Created by Евгений Митюля on 1.07.24.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = SKView(frame: view.frame)
        
        if let skView = self.view as? SKView {
            let gameScene = GameScene(size: skView.bounds.size)
            gameScene.parentVC = self
            gameScene.scaleMode = .aspectFill
            skView.presentScene(gameScene)
            skView.ignoresSiblingOrder = true
        }
    }
    
    func gameOverShow(withScore: Int) {
        if withScore > UserDefaults.highScore {
            UserDefaults.highScore = withScore
        }
        
        let gameOverVC = GameOverViewController(score: withScore)
        gameOverVC.modalPresentationStyle = .fullScreen
        gameOverVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(gameOverVC, animated: true)
    }
}
