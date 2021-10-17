//
//  NewsViewController.swift
//  lesson-4
//
//  Created by LACKY on 19.09.2021.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var NewsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NewsTableView.register(R.Nib.Newsbasic, forCellReuseIdentifier: R.Cell.Newsbasic)
    }
    
}

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.Cell.Newsbasic, for: indexPath)
    }
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}
