//
//  FriendsVKViewController.swift
//  lesson-2
//
//  Created by LACKY on 20.10.2021.
//

import UIKit
import RealmSwift

class FriendsVKViewController: UITableViewController {
    
    //для анимации
    @IBOutlet weak var animationViewDownloads: AnimationDownloads!
    
    private var friendsSearchController: UISearchController!
    
    private let friendsService = FriendsAPI()
    private let friendDB = FriendDB()
    
    private var friends: Results<Friend>?
    private var token: NotificationToken?
    
    var SearchResultFriends: [Friend] = [] //для отображения найденных друзей
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(R.Nib.basic, forCellReuseIdentifier: R.Cell.basic)
        
        friendsSearchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = friendsSearchController.searchBar
        friendsSearchController.searchResultsUpdater = self
        
        friendsService.getFriends { [weak self] friends in
            guard let self = self else {return}
            
            let friendsOld = self.friendDB.load()
            friendsOld.forEach {
                self.friendDB.delete($0)
            }

            self.friendDB.save(friends)
            self.friends = self.friendDB.load()
            
            self.token = self.friends?.observe { [weak self] changes in
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
        if friendsSearchController.isActive {
            return SearchResultFriends.count
        } else {
            guard friends != nil else {return 0}
            return self.friends!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.Cell.basic, for: indexPath)
        
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if friendsSearchController.isActive {
            (cell as? BasicTableViewCell)?.configure(with: self.SearchResultFriends[indexPath.row])
        } else {
            (cell as? BasicTableViewCell)?.configure(with: self.friends![indexPath.row])
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if friendsSearchController.isActive {
            return false
        } else {
            return true
        }
    }
    
    
    //анимация
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animationViewDownloads.animate()
    }

    
//    //удаление друзей
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableView.beginUpdates()
//            friends.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.endUpdates()
//        }
//    }

}




extension FriendsVKViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(searchText: searchText)
            tableView.reloadData()
        }
    }
    
    func filterContent(searchText: String){
        SearchResultFriends = friends!.filter({(FriendsSome: Friend) -> Bool in
            let nameMatch = FriendsSome.fullName.range(of: searchText)
            
            return nameMatch != nil
        })
    }
    
    
}
