//
//  MainMenuViewController.swift
//  Police Race
//
//  Created by Евгений Митюля on 1.07.24.
//

import UIKit

final class MainMenuViewController: UIViewController {
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView(
            image: UIImage(
                named: Image.Menu.logo.rawValue
            )
        )
        logo.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private lazy var background: UIImageView = {
        let background = UIImageView(
            image: UIImage(
                named: Image.Menu.background.rawValue
            )
        )
        background.contentMode = .scaleAspectFill
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    private lazy var playButton: UIButton = {
        let playButton = UIButton()
        
        playButton.setImage(UIImage(named: Image.Menu.button.rawValue), for: .normal)
        playButton.imageView?.contentMode = .scaleAspectFit
        
        playButton.addTarget(self, action: #selector(playClick), for: .touchUpInside)
        
        playButton.contentMode = .scaleAspectFit
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        return playButton
    }()
    
    private lazy var textImage: UIImageView = {
        let imageLabel = UIImageView(image: UIImage(named: Image.Menu.label.rawValue))
        
        imageLabel.contentMode = .scaleAspectFit
        
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return imageLabel
    }()
    
    private lazy var scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 55)
        scoreLabel.text = "\(UserDefaults.highScore)"
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return scoreLabel
    }()
    
    private lazy var scoreLabelBack: UIView = {
        let view = UIView()
        
        view.backgroundColor = .menu
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addLayouts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scoreLabel.text = "\(UserDefaults.highScore)"
    }
    
    func addViews() {
        view.addSubview(background)
        view.addSubview(logo)
        view.addSubview(playButton)
        view.addSubview(textImage)
        view.addSubview(scoreLabelBack)
        view.addSubview(scoreLabel)
    }
    
    func addLayouts() {
        NSLayoutConstraint.activate([
            self.background.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.background.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.background.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.background.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.logo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 75),
            self.logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logo.widthAnchor.constraint(equalToConstant: 350),
            self.logo.heightAnchor.constraint(equalToConstant: 175),
            
            self.playButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -140),
            self.playButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.playButton.widthAnchor.constraint(equalToConstant: 300),
            self.playButton.heightAnchor.constraint(equalToConstant: 120),
            
            self.textImage.topAnchor.constraint(equalTo: self.logo.bottomAnchor, constant: 125),
            self.textImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.textImage.widthAnchor.constraint(equalToConstant: 175),
            self.textImage.heightAnchor.constraint(equalToConstant: 75),
            
            self.scoreLabelBack.topAnchor.constraint(equalTo: self.logo.bottomAnchor, constant: 45),
            self.scoreLabelBack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.scoreLabelBack.widthAnchor.constraint(equalToConstant: CGFloat(100 + (String(UserDefaults.highScore).count - 1) * 25)),
            self.scoreLabelBack.heightAnchor.constraint(equalToConstant: 80),
            
            self.scoreLabel.centerYAnchor.constraint(equalTo: self.scoreLabelBack.centerYAnchor),
            self.scoreLabel.centerXAnchor.constraint(equalTo: self.scoreLabelBack.centerXAnchor),
        ])
    }
}


// MARK:  Buttons methods

extension MainMenuViewController {
    @objc private func playClick() {
        let gameVC = GameViewController()
        gameVC.modalPresentationStyle = .fullScreen
        gameVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}
