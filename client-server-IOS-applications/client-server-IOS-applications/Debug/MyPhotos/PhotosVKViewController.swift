//
//  PhotosVKViewController.swift
//  lesson-2
//
//  Created by LACKY on 20.10.2021.
//

import UIKit

class PhotosVKViewController: UITableViewController {

    let photosService = PhotosAPI()

    var photos: [Photo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "photosCell")
        
        photosService.getPhotos { [weak self] photos in
            self?.photos = photos
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photosCell", for: indexPath)
        let photo = photos[indexPath.row]
        
        let photoPhotoImage = UIImageView(frame: CGRect(x: 0, y : 0, width: photo.sizes[0].width, height: photo.sizes[0].height))
        
        photoPhotoImage.image = UIImage(data: try! Data(contentsOf: URL(string: photo.sizes[0].url)!))
        cell.addSubview(photoPhotoImage)

        return cell
    }
}
