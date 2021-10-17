//
//  R.swift
//  lesson-3
//
//  Created by LACKY on 12.09.2021.
//

import UIKit

enum R {
    
    enum Storyboard {
    static let DebugMenu: UIStoryboard = .init(name: "DebugMenu", bundle: nil)
    static let MainSettings: UIStoryboard = .init(name: "MainSettings", bundle: nil)
    static let notifications: UIStoryboard = .init(name: "notifications", bundle: nil)
    static let blackList: UIStoryboard = .init(name: "blackList", bundle: nil)
    static let Main: UIStoryboard = .init(name: "Main", bundle: nil)
    }
    
    enum Nib {
        static let basic: UINib = .init(nibName: "BasicTableViewCell", bundle: nil)
        static let Newsbasic: UINib = .init(nibName: "NewsTableViewCell", bundle: nil)
    }
    
    enum Cell {
        static let basic: String = "BasicCell"
        static let Newsbasic: String = "NewsCell"
    }
    
}
