//
//  UserDefaultsHighScoreManager.swift
//  Police Race
//
//  Created by Евгений Митюля on 1.07.24.
//

import UIKit

extension UserDefaults {
    static var highScore: Int {
        get { return UserDefaults.standard.integer(forKey: "highScore") }
        set { UserDefaults.standard.setValue(newValue, forKey: "highScore") }
    }
}
