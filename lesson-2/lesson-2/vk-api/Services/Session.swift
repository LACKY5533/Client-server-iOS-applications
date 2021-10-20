//
//  Session.swift
//  lesson-2
//
//  Created by LACKY on 20.10.2021.
//

import Foundation

final class Session {
    
    private init() {}
    
    static let shared = Session()
    
    var token: String = ""
    var userID: String = ""
}
