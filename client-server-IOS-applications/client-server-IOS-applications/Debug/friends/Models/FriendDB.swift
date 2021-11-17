//
//  FriendDB.swift
//  client-server-IOS-applications
//
//  Created by LACKY on 05.11.2021.
//

import Foundation
import RealmSwift

protocol FriendDBProtocol {
    
    func save(_ friend: [Friend])
    func load() -> Results<Friend>
    func delete(_ friend: Friend)
}

final class FriendDB: FriendDBProtocol {

    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 16)
    }

    func save(_ items: [Friend]) {
        let realm = try! Realm()

        try! realm.write {
            realm.add(items)
        }
        print(realm.configuration.fileURL ?? "")
    }

    func load() -> Results<Friend> {
        let realm = try! Realm()
        let friends: Results<Friend> = realm.objects(Friend.self)
        return friends
    }

    func delete(_ items: Friend) {
        let realm = try! Realm()

        //Асинхронное API
        try! realm.write {
            realm.delete(items)
        }
    }
}
