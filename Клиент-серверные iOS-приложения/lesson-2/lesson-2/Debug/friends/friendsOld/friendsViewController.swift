//
//  friendsViewController.swift
//  lesson-3
//
//  Created by LACKY on 13.09.2021.
//

import UIKit

class friendsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var searchController: UISearchController!
    
    @IBOutlet weak var animationViewDownloads: AnimationDownloads!
    
    private var FriendsItem: [FriendsDisplayItem] = []
    private var SearchResultFriends: [FriendsDisplayItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(R.Nib.basic, forCellReuseIdentifier: R.Cell.basic)
        self.getData()
        
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self

    }
    
    private func getData() {
        
        let mockItems: [FriendsDisplayItem] = [
            .init(friend: "Лиза"),
            .init(friend: "Кирилл"),
            .init(friend: "Артём"),
            .init(friend: "Катя"),
            .init(friend: "Дима")]
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.FriendsItem = mockItems
            self.tableView.reloadData()
        }
    }
    
}

extension friendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return SearchResultFriends.count
        } else {
            return self.FriendsItem.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.Cell.basic, for: indexPath)
    }
}

extension friendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if searchController.isActive {
            (cell as? BasicTableViewCell)?.configure(with: self.SearchResultFriends[indexPath.row])
        } else {
            (cell as? BasicTableViewCell)?.configure(with: self.FriendsItem[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.animationViewDownloads.animate()
    }
    
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            FriendsItem.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
}

extension friendsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(searchText: searchText)
            tableView.reloadData()
        }
    }
    
    func filterContent(searchText: String){
        SearchResultFriends = FriendsItem.filter({(FriendsSome: FriendsDisplayItem) -> Bool in
            let nameMatch = FriendsSome.friend.range(of: searchText)
            
            return nameMatch != nil
        })
    }
    
    
}
