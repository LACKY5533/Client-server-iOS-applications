//
//  GroupsVKVIewController.swift
//  lesson-2
//
//  Created by LACKY on 20.10.2021.
//

import UIKit

class GroupsVKViewController: UITableViewController {
    
    let groupsService = GroupsAPI()

    override func viewDidLoad() {
        super.viewDidLoad()


        groupsService.getGroups { groups in

            print("Получили группы")
        }
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

}
