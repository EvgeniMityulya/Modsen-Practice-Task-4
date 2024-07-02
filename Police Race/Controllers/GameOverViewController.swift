//
//  GameOverViewController.swift
//  Police Race
//
//  Created by Евгений Митюля on 2.07.24.
//

import UIKit

final class GameOverViewController: UIViewController {
    
    private var score: Int
    
    init(score: Int) {
        self.score = score
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "over-logo"))
        
        logo.contentMode = .scaleAspectFit
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        return logo
    }()
    
    private lazy var scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 55)
        scoreLabel.text = "Score \(score)"
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return scoreLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        addViews()
        addLayouts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func addViews() {
        view.addSubview(logo)
        view.addSubview(scoreLabel)
    }
    
    func addLayouts() {
        NSLayoutConstraint.activate([
            self.logo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 175),
            self.logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logo.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.logo.heightAnchor.constraint(equalTo: self.view.widthAnchor),
            
            self.scoreLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.scoreLabel.topAnchor.constraint(equalTo: self.logo.bottomAnchor, constant: 60),
        ])
    }
}
