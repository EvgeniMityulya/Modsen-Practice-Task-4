//
//  Image.swift
//  Police Race
//
//  Created by Paul Makey on 2.07.24.
//

import Foundation

enum Image {
    enum Car: String {
        case player = "car-player"
        case police = "car-police"
    }
    
    enum Control: String {
        case left = "arrow_left"
        case right = "arrow_right"
    }
    
    enum Game: String {
        case background = "game-back"
        case over = "over-logo"
    }
    
    enum Menu: String {
        case background = "menu-bg"
        case button = "menu-btn"
        case label = "menu-label"
        case logo = "menu-logo"
    }
}
