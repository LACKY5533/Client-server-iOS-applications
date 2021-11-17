//
//  photosTableViewCell.swift
//  client-server-IOS-applications
//
//  Created by LACKY on 05.11.2021.
//

import UIKit

class photosTableViewCell: UITableViewCell {

    @IBOutlet weak var photoPhotoImage: UIImageView!
    
    func configure(with item: Photo) {
        
        if let imageURL = URL(string: item.text) {
            photoPhotoImage.load(url: imageURL)
        }
    }
}
