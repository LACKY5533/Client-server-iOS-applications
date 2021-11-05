//
//  groupsAvatar.swift
//  client-server-IOS-applications
//
//  Created by LACKY on 28.10.2021.
//

import UIKit

class groupsAvatar: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
