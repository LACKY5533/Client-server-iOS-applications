//
//  NewsTableViewCell.swift
//  lesson-4
//
//  Created by LACKY on 19.09.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsLabel: UILabel!
    
    func configure(with item: News) {
        
        self.newsLabel.text = item.text
    }

//    @IBOutlet weak var animationView: UIView!
//    @IBOutlet private weak var LikesLabel: UILabel!
//
//    private var likes: Int = 0
//    private var didAnimate: Bool = false
//
//    private func animate() {
//
//        UIView.animate(withDuration: 1) {
//            self.animationView.transform = .init(scaleX: 4, y: 4)
//            self.animationView.transform = .identity
//        } completion: { _ in
//            self.didAnimate.toggle()
//        }
//
//    }
    
//    @IBAction func LikesButton(_ sender: Any) {
//
//        self.animate()
//        likes += 1
//        self.LikesLabel.text = "\(likes)"
//    }
    
}
