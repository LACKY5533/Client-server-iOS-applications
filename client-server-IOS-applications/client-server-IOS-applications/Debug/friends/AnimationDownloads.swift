//
//  AnimationDownloads.swift
//  lesson-8
//
//  Created by LACKY on 03.10.2021.
//

import UIKit

class AnimationDownloads: UIView {
    
    var shapeLayer: CAShapeLayer?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        path.move(to: .init(x: 207, y: 22))
        path.addLine(to: .init(x: 217, y: 32))
        path.addLine(to: .init(x: 217, y: 12))
        path.addLine(to: .init(x: 197, y: 32))
        path.addLine(to: .init(x: 197, y: 12))
        path.addLine(to: .init(x: 207, y: 22))

        
        path.close()
        path.stroke()
        self.addShapeLayer(path: path)
    }
    
    private func addShapeLayer(path: UIBezierPath) {
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = UIColor.yellow.cgColor
        layer.fillColor = nil
        layer.strokeStart = 0
        layer.strokeEnd = 0
        layer.lineWidth = 5
        layer.lineCap = .round
        self.layer.addSublayer(layer)
        self.shapeLayer = layer
    }
    
    func animate() {
        
        let strokeEndAnimate = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimate.fromValue = 0
        strokeEndAnimate.toValue = 1.2
        
        let strokeStartAnimate = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimate.fromValue = 0
        strokeStartAnimate.toValue = 1
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeEndAnimate, strokeStartAnimate]
        animationGroup.duration = 1
        
        self.shapeLayer?.add(animationGroup, forKey: nil)
    }
}
