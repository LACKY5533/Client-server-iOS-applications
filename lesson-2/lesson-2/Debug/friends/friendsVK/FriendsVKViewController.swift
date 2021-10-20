//
//  FriendsVKViewController.swift
//  lesson-2
//
//  Created by LACKY on 20.10.2021.
//

import UIKit

class FriendsVKViewController: UITableViewController {

    let friendsService = FriendsAPI()

    override func viewDidLoad() {
        super.viewDidLoad()


        friendsService.getFriends { friends in

            print("Получили друзей в контроллере")
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
