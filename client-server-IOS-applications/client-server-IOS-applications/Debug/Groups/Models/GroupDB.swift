//
//  GroupDB.swift
//  client-server-IOS-applications
//
//  Created by LACKY on 05.11.2021.
//

import Foundation
import RealmSwift

protocol GroupDBProtocol {
    
    func save(_ item: [Group])
    func load() -> Results<Group>
    func delete(_ item: Group)
}

final class GroupDB: GroupDBProtocol {

    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 16)
    }

    func save(_ items: [Group]) {
        let realm = try! Realm()

        try! realm.write {
            realm.add(items)
        }
    }

    func load() -> Results<Group> {
        let realm = try! Realm()
        let groups: Results<Group> = realm.objects(Group.self)
        return groups
    }

    func delete(_ items: Group) {
        let realm = try! Realm()

        //Асинхронное API
        try! realm.write {
            realm.delete(items)
        }
    }
}
