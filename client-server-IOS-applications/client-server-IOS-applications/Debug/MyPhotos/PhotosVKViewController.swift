//
//  PhotosVKViewController.swift
//  lesson-2
//
//  Created by LACKY on 20.10.2021.
//

import UIKit
import RealmSwift

class PhotosVKViewController: UITableViewController {

    private let photosService = PhotosAPI()
    private let photoDB = PhotoDB()
    
    private var photos: Results<Photo>?
    private var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(R.Nib.photos, forCellReuseIdentifier: R.Cell.photos)
        
        photosService.getPhotos { [weak self] photos in
            guard let self = self else {return}
            
            let photosOld = self.photoDB.load()
            photosOld.forEach {
                self.photoDB.delete($0)
            }
            
            self.photoDB.save(photos)
            self.photos = self.photoDB.load()

            self.token = self.photos?.observe { [weak self] changes in
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
        guard photos != nil else {return 0}
        return photos!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.Cell.photos, for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            (cell as? photosTableViewCell)?.configure(with: self.photos![indexPath.row])
        }
}
