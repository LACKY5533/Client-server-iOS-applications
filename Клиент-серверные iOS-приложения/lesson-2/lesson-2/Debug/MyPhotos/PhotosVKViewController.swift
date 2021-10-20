//
//  PhotosVKViewController.swift
//  lesson-2
//
//  Created by LACKY on 20.10.2021.
//

import UIKit

class PhotosVKViewController: UITableViewController {

    let photosService = PhotosAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosService.getPhotos { friends in

            print("Получили фотографии")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
