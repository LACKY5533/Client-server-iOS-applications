//
//  PhotoDB.swift
//  client-server-IOS-applications
//
//  Created by LACKY on 05.11.2021.
//

import Foundation
import RealmSwift

protocol PhotoDBProtocol {
    
    func save(_ item: [Photo])
    func load() -> Results<Photo>
    func delete(_ item: Photo)
}

final class PhotoDB: PhotoDBProtocol {

    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 16)
    }

    func save(_ items: [Photo]) {
        let realm = try! Realm()

        try! realm.write {
            realm.add(items)
        }
    }

    func load() -> Results<Photo> {
        let realm = try! Realm()
        let photos: Results<Photo> = realm.objects(Photo.self)
        return photos
    }

    func delete(_ items: Photo) {
        let realm = try! Realm()

        //Асинхронное API
        try! realm.write {
            realm.delete(items)
        }
    }
}
