//
//  GroupsVKVIewController.swift
//  lesson-2
//
//  Created by LACKY on 20.10.2021.
//

import UIKit
import RealmSwift
import Firebase

class GroupsVKViewController: UITableViewController {
    
    private var groupsSearchController: UISearchController!
    
    private let groupsService = GroupsAPI()
    private let groupDB = GroupDB()
    
    private var groups: Results<Group>?
    private var token: NotificationToken?
    
    var SearchResultGroups: [Group] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(R.Nib.groups, forCellReuseIdentifier: R.Cell.groups)
        
        groupsSearchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = groupsSearchController.searchBar
        groupsSearchController.searchResultsUpdater = self
        
        groupsService.getGroups { [weak self] groups in
            guard let self = self else {return}
            
            let groupsOld = self.groupDB.load()
            groupsOld.forEach {
                self.groupDB.delete($0)
            }
            
            self.groupDB.save(groups)
            self.groups = self.groupDB.load()

            self.token = self.groups?.observe { [weak self] changes in
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
        if groupsSearchController.isActive {
            return SearchResultGroups.count
        } else {
            guard groups != nil else {return 0}
            return self.groups!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.Cell.groups, for: indexPath)
        
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if groupsSearchController.isActive {
            (cell as? groupsTableViewCell)?.configure(with: self.SearchResultGroups[indexPath.row])
        } else {
            (cell as? groupsTableViewCell)?.configure(with: self.groups![indexPath.row])
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if groupsSearchController.isActive {
            return false
        } else {
            return true
        }
    }
    

    
//    //удаление групп
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableView.beginUpdates()
//            groups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.endUpdates()
//        }
//    }

}




extension GroupsVKViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(searchText: searchText)
            tableView.reloadData()
        }
    }
    
    func filterContent(searchText: String){
        SearchResultGroups = groups!.filter({(GroupsSome: Group) -> Bool in
            let nameMatch = GroupsSome.screenName.range(of: searchText)
            
            return nameMatch != nil
        })
    }
    
    
}
