//
//  Account.swift
//  lesson-1
//
//  Created by LACKY on 17.10.2021.
//

import Foundation

final class Account {
    
    private init() {}
    
    static let shared = Account()
    
    var name: String = ""
    var userID: String = ""
}
