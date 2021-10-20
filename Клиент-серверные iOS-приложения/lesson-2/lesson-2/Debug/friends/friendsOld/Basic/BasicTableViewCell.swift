//
//  BasicTableViewCell.swift
//  lesson-3
//
//  Created by LACKY on 13.09.2021.
//

import UIKit

class BasicTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var friendLabel: UILabel!
    
    func configure(with item: FriendsDisplayItem) {
        self.friendLabel.text = item.friend
    }
    
}

struct FriendsDisplayItem {
    let friend: String
}
