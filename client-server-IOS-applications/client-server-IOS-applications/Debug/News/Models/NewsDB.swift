//
//  NewsDB.swift
//  client-server-IOS-applications
//
//  Created by LACKY on 15.11.2021.
//

import Foundation
import RealmSwift

protocol NewsDBProtocol {

    func save(_ news: [News])
    func load() -> Results<News>
    func delete(_ news: News)
}

final class NewsDB: NewsDBProtocol {

    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 16)
    }

    func save(_ items: [News]) {
        let realm = try! Realm()

        try! realm.write {
            realm.add(items)
        }
    }

    func load() -> Results<News> {
        let realm = try! Realm()
        let news: Results<News> = realm.objects(News.self)
        return news
    }

    func delete(_ items: News) {
        let realm = try! Realm()

        //Асинхронное API
        try! realm.write {
            realm.delete(items)
        }
    }
}
