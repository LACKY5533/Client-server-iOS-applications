//
//  NewsVKViewController.swift
//  client-server-IOS-applications
//
//  Created by LACKY on 15.11.2021.
//

import UIKit
import RealmSwift

class NewsVKViewController: UITableViewController {
    
    private let newsService = NewsAPI()
    private let newsDB = NewsDB()
    
    private var news: Results<News>?
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(R.Nib.Newsbasic, forCellReuseIdentifier: R.Cell.Newsbasic)
        
        newsService.getNews { [weak self] news in
            guard let self = self else {return}

            
            let newsOld = self.newsDB.load()
            newsOld.forEach {
                self.newsDB.delete($0)
            }

            self.newsDB.save(news)
            self.news = self.newsDB.load()
            
            self.token = self.news?.observe { [weak self] changes in
                guard let self = self else { return }

                switch changes {
                    case .initial:
                        self.tableView.reloadData()
                    case .update(_, let deletions, let insertions, let modifications):
                        self.tableView.beginUpdates()
                        self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                        self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                        self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                        self.tableView.endUpdates()
                    case .error(let error):
                        fatalError("\(error)")
                }
            }
            
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard news != nil else {return 0}
        return self.news!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.Cell.basic, for: indexPath)
        
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? NewsTableViewCell)?.configure(with: self.news![indexPath.row])
        }
}
