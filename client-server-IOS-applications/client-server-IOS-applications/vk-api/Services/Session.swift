//
//  Session.swift
//  lesson-2
//
//  Created by LACKY on 20.10.2021.
//

import Foundation
import SwiftKeychainWrapper

final class Session {
    
    private init() {}
    
    static let shared = Session()
    
    var token: String {
        set {
            KeychainWrapper.standard.set(newValue, forKey: "token")
        }
        get {
            return KeychainWrapper.standard.string(forKey: "token") ?? ""
        }
    }
    
    var userId: String {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "userId")
        }
        get {
            return UserDefaults.standard.string(forKey: "userId")!
        }
    }
}
